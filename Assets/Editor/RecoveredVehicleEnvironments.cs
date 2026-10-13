using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

// Original ASTC HDR payloads are decoded by Unity's GPU, one explicit mip at a time.
// No generated image, tonemapping, RGBM conversion, or regenerated mip pyramid.
public static class RecoveredVehicleEnvironments
{
    const string Input = "Assets/Recovery/VehicleEnvironments";
    const string Output = "Assets/RecoveredVehicles/Environment";
    [Serializable] public sealed class Catalog { public Model[] models; }
    [Serializable] public sealed class Model { public string model; public Entry source; }
    [Serializable] public sealed class Entry
    {
        public string name, file, sha256;
        public int width, height, format, mips, colorSpace, filterMode, wrapU, wrapV, wrapW, aniso;
        public float mipBias;
    }
    public static string AssetPath(string sourceName) { return Output + "/" + sourceName + ".asset"; }
    public static Dictionary<string, Texture2D> Import()
    {
        var catalog = JsonUtility.FromJson<Catalog>(File.ReadAllText(Input + "/environments.json"));
        if (catalog == null || catalog.models == null) throw new InvalidOperationException("Missing original vehicle HDR catalog");
        var copyShader = Shader.Find("Hidden/DeepalRecovery/CopyMip");
        if (copyShader == null || ShaderUtil.ShaderHasError(copyShader)) throw new InvalidOperationException("Original mip copy shader unavailable");
        Directory.CreateDirectory(Output);
        AssetDatabase.Refresh();
        var decoded = new Dictionary<string, Texture2D>();
        var models = new Dictionary<string, Texture2D>();
        foreach (var model in catalog.models)
        {
            Texture2D result;
            if (!decoded.TryGetValue(model.source.sha256, out result))
            {
                result = Decode(model.source, copyShader);
                decoded.Add(model.source.sha256, result);
            }
            models.Add(model.model, result);
        }
        AssetDatabase.SaveAssets();
        return models;
    }
    static Texture2D Decode(Entry entry, Shader copyShader)
    {
        if (!SystemInfo.SupportsTextureFormat((TextureFormat)entry.format))
            throw new InvalidOperationException("GPU cannot decode original HDR format " + entry.format + " for " + entry.name);
        bool linear = entry.colorSpace == 0;
        var source = new Texture2D(entry.width, entry.height, (TextureFormat)entry.format, entry.mips, linear);
        var material = new Material(copyShader);
        var previous = RenderTexture.active;
        Texture2D image = null;
        RenderTexture rt = null;
        Texture2D result = null;
        try
        {
            source.LoadRawTextureData(File.ReadAllBytes(Path.Combine(Input, entry.file)));
            source.Apply(false, false);
            source.filterMode = (FilterMode)entry.filterMode;
            source.wrapModeU = (TextureWrapMode)entry.wrapU;
            source.wrapModeV = (TextureWrapMode)entry.wrapV;
            source.wrapModeW = (TextureWrapMode)entry.wrapW;
            source.anisoLevel = entry.aniso;
            source.mipMapBias = entry.mipBias;
            using (var stream = new MemoryStream())
            {
                for (int mip = 0; mip < entry.mips; mip++)
                {
                    int w = Math.Max(1, entry.width >> mip), h = Math.Max(1, entry.height >> mip);
                    rt = RenderTexture.GetTemporary(w, h, 0, RenderTextureFormat.ARGBHalf, RenderTextureReadWrite.Linear);
                    material.SetFloat("_Mip", mip);
                    Graphics.Blit(source, rt, material);
                    RenderTexture.active = rt;
                    image = new Texture2D(w, h, TextureFormat.RGBAHalf, false, true);
                    image.ReadPixels(new Rect(0, 0, w, h), 0, 0, false);
                    image.Apply(false, false);
                    var bytes = image.GetRawTextureData();
                    stream.Write(bytes, 0, bytes.Length);
                    UnityEngine.Object.DestroyImmediate(image); image = null;
                    RenderTexture.active = previous;
                    RenderTexture.ReleaseTemporary(rt); rt = null;
                }
                // GPU sampling returns linear values; retain that interpretation in the half atlas.
                result = new Texture2D(entry.width, entry.height, TextureFormat.RGBAHalf, entry.mips, true);
                result.name = entry.name;
                result.filterMode = (FilterMode)entry.filterMode;
                result.wrapModeU = (TextureWrapMode)entry.wrapU;
                result.wrapModeV = (TextureWrapMode)entry.wrapV;
                result.wrapModeW = (TextureWrapMode)entry.wrapW;
                result.anisoLevel = entry.aniso;
                result.mipMapBias = entry.mipBias;
                result.LoadRawTextureData(stream.ToArray());
                result.Apply(false, false);
            }
            var path = AssetPath(entry.name);
            var existing = AssetDatabase.LoadAssetAtPath<Texture2D>(path);
            if (existing != null)
            {
                EditorUtility.CopySerialized(result, existing);
                UnityEngine.Object.DestroyImmediate(result);
                result = existing;
            }
            else AssetDatabase.CreateAsset(result, path);
            return result;
        }
        finally
        {
            RenderTexture.active = previous;
            if (image != null) UnityEngine.Object.DestroyImmediate(image);
            if (rt != null) RenderTexture.ReleaseTemporary(rt);
            UnityEngine.Object.DestroyImmediate(source);
            UnityEngine.Object.DestroyImmediate(material);
        }
    }
}
