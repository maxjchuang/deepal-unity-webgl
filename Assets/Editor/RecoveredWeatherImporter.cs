using System.IO;
using UnityEngine;
using UnityEditor;

public static class RecoveredWeatherImporter
{
    const string Src="Assets/Recovery/Weather/", Dst="Assets/RecoveredS07/Environment/";
    public static void Import(GameObject root, RecoveredTimeControls time, RecoveredSpecialScenes special)
    {
        var catalog=JsonUtility.FromJson<RecoveredWeatherControls.Catalog>(File.ReadAllText(Src+"states.json"));
        foreach(var state in catalog.states)
        {
            state.sky=new Texture2D(128,32,TextureFormat.RGBAFloat,false,true){name=state.name+"_Sky",filterMode=FilterMode.Bilinear,wrapMode=TextureWrapMode.Clamp};
            state.sky.LoadRawTextureData(File.ReadAllBytes(state.skyFile));state.sky.Apply(false,false);
            Save(state.sky,Dst+state.name+"_Sky.asset");
            state.reflection=RecoveredNativeReflection.Import(state,state.sky);
        }
        var material=new Material(Shader.Find("Recovered/Hidden/Environment/Cloud/Variant1")){name="RecoveredNativeCloud",renderQueue=2997};
        foreach(var id in new[]{45,50})
        {
            var path=Src+"texture-"+id+".png";
            var importer=(TextureImporter)AssetImporter.GetAtPath(path);
            importer.sRGBTexture=false;importer.wrapMode=TextureWrapMode.Repeat;importer.filterMode=FilterMode.Bilinear;importer.textureCompression=TextureImporterCompression.Uncompressed;importer.SaveAndReimport();
            material.SetTexture(id==50?"_FlatCloudsBaseTexture":"_FlatCloudsDetailTexture",AssetDatabase.LoadAssetAtPath<Texture2D>(path));
        }
        Save(material,Dst+"NativeCloud.mat");
        var go=new GameObject("NativeCloud");go.transform.localScale=new Vector3(29.85000038f,29.32500076f,29.85000038f);
        go.AddComponent<MeshFilter>().sharedMesh=AssetDatabase.LoadAssetAtPath<Mesh>(Dst+"CylinderNative.asset");
        var renderer=go.AddComponent<MeshRenderer>();renderer.sharedMaterial=material;renderer.enabled=false;
        var controls=root.AddComponent<RecoveredWeatherControls>();controls.states=catalog.states;controls.cloud=renderer;controls.timeControls=time;controls.specialScenes=special;special.weather=controls;controls.Refresh();
    }
    static void Save(Object value,string path){AssetDatabase.DeleteAsset(path);AssetDatabase.CreateAsset(value,path);}
}
