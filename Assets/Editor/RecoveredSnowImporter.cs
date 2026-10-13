using System;
using System.IO;
using UnityEngine;
using UnityEditor;

public static class RecoveredSnowImporter
{
    public static void Import(GameObject root,Camera camera,RecoveredSpecialScenes special)
    {
        var programs=root.AddComponent<RecoveredSnowPrograms>();
        programs.emit=Create("Recovered/Hidden/SnowCompute/Variant1","SnowEmit");
        programs.update=Create("Recovered/Hidden/SnowCompute/Variant3","SnowUpdate");
        programs.draw=Create("Recovered/Hidden/Snow/Variant1","SnowDraw");
        programs.draw.enableInstancing=true;
        programs.draw.SetFloat("_Size",.02500000037f);
        programs.draw.SetFloat("_Alpha",1);
        programs.draw.SetColor("_Color",new Color(1.317647099f,1.411764741f,1.498039246f,.800000012f));
        var data=JsonUtility.FromJson<S07RecoveryImporter.MeshData>(File.ReadAllText("Assets/Recovery/Weather/QuadXY.json"));
        var quad=new Mesh{name="OriginalSnowQuadXY"};quad.vertices=data.vertices;quad.uv=data.uv;quad.triangles=data.submeshes[0].indices;quad.RecalculateBounds();Save(quad,"SnowQuadXY");
        var clip=new Mesh{name="SnowComputeClipQuad"};clip.vertices=new[]{new Vector3(-1,-1,0),new Vector3(-1,1,0),new Vector3(1,1,0),new Vector3(1,-1,0)};clip.triangles=new[]{0,1,2,0,2,3};Save(clip,"SnowComputeQuad");
        var surface=new Texture2D(256,128,TextureFormat.RGBA32,false,true){name="NativeS07CollisionSnapshot",wrapMode=TextureWrapMode.Clamp,filterMode=FilterMode.Bilinear};surface.LoadRawTextureData(File.ReadAllBytes("Assets/Recovery/Weather/native-s07-collision.rgba"));surface.Apply(false,false);Save(surface,"SnowCollisionSnapshot");
        var simulation=root.AddComponent<RecoveredSnowSimulation>();simulation.programs=programs;simulation.quad=clip;
        var renderer=root.AddComponent<RecoveredSnowRenderer>();renderer.simulation=simulation;renderer.cameraSource=camera;renderer.drawQuad=quad;renderer.collisionSurface=surface;renderer.specialScenes=special;renderer.dynamicCollision=root.GetComponent<RecoveredCollisionSurface>();
    }
    static void Save(UnityEngine.Object asset,string name){var path="Assets/RecoveredS07/Environment/"+name+".asset";AssetDatabase.DeleteAsset(path);AssetDatabase.CreateAsset(asset,path);}
    static Material Create(string shaderName,string name)
    {
        var shader=Shader.Find(shaderName);
        if(shader==null||ShaderUtil.ShaderHasError(shader))throw new InvalidOperationException("Recovered snow shader failed: "+shaderName);
        var material=new Material(shader){name=name};
        var path="Assets/RecoveredS07/Environment/"+name+".mat";
        AssetDatabase.DeleteAsset(path);AssetDatabase.CreateAsset(material,path);
        return material;
    }
}
