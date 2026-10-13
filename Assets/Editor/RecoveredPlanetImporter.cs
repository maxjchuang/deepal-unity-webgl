using System;
using System.IO;
using UnityEngine;
using UnityEditor;

public static class RecoveredPlanetImporter
{
    public static void Import(GameObject root,Camera camera,RecoveredTimeControls time,RecoveredSpecialScenes special)
    {
        var renderer=root.AddComponent<RecoveredPlanetRenderer>();renderer.cameraSource=camera;renderer.timeControls=time;renderer.specialScenes=special;
        renderer.quad=AssetDatabase.LoadAssetAtPath<Mesh>("Assets/RecoveredS07/Environment/SnowQuadXY.asset");
        var mat=Create("Hidden/Environment/Planet","OriginalSun");var path="Assets/Recovery/Weather/texture-46.png";
        var importer=(TextureImporter)AssetImporter.GetAtPath(path);importer.sRGBTexture=true;importer.textureCompression=TextureImporterCompression.Uncompressed;importer.SaveAndReimport();mat.SetTexture("_MainTex",AssetDatabase.LoadAssetAtPath<Texture2D>(path));mat.SetFloat("ratio",0);
        var go=new GameObject("RecoveredNativeSun");go.transform.SetPositionAndRotation(new Vector3(23.6f,11.92f,14.16f),new Quaternion(.0177828185f,.479255676f,.00198075245f,.877492964f));go.transform.localScale=Vector3.one*20.70605087f;
        var source=JsonUtility.FromJson<S07RecoveryImporter.MeshData>(File.ReadAllText("Assets/Recovery/Weather/CircleXY.json"));var mesh=new Mesh{name="OriginalSunCircleXY"};mesh.vertices=source.vertices;mesh.uv=source.uv;mesh.triangles=source.submeshes[0].indices;mesh.RecalculateBounds();var meshPath="Assets/RecoveredS07/Environment/SunCircleXY.asset";AssetDatabase.DeleteAsset(meshPath);AssetDatabase.CreateAsset(mesh,meshPath);
        go.AddComponent<MeshFilter>().sharedMesh=mesh;renderer.sun=go.AddComponent<MeshRenderer>();renderer.sun.sharedMaterial=mat;renderer.sun.enabled=false;
        renderer.stars=Create("Hidden/Star","OriginalStars");renderer.stars.enableInstancing=true;renderer.stars.SetColor("_Color",new Color(.552687824f,.557282984f,.566037774f,1));renderer.stars.SetFloat("_Size0",.1f);renderer.stars.SetFloat("_Size1",.05f);renderer.stars.SetFloat("radius",30);renderer.stars.SetFloat("ratio",0);
        renderer.shootingStar=Create("Hidden/ShootingStar","OriginalShootingStar");renderer.shootingStar.enableInstancing=true;
        renderer.shootingStar.SetColor("_Color",new Color(.552687824f,.557282984f,.566037774f,1));renderer.shootingStar.SetFloat("radius",30);renderer.shootingStar.SetFloat("sizeX",.07f);renderer.shootingStar.SetFloat("sizeY",5.06f);renderer.shootingStar.SetFloat("ratio",0);renderer.shootingStar.SetFloatArray("angleShootingStars",new float[3]);
        renderer.weather=root.GetComponent<RecoveredWeatherControls>();renderer.rain=root.GetComponent<RecoveredRainRenderer>();renderer.snow=root.GetComponent<RecoveredSnowRenderer>();
        // Native S07 has no bound moon renderer.
    }
    static Material Create(string original,string name){var shader=Shader.Find("Recovered/"+original+"/Variant1");if(shader==null||ShaderUtil.ShaderHasError(shader))throw new InvalidOperationException("Planet shader unavailable: "+original);var mat=new Material(shader){name=name};var path="Assets/RecoveredS07/Environment/"+name+".mat";AssetDatabase.DeleteAsset(path);AssetDatabase.CreateAsset(mat,path);return mat;}
}
