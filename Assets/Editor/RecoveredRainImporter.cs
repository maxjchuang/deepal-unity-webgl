using System;
using UnityEngine;
using UnityEditor;

public static class RecoveredRainImporter
{
    public static void Import(GameObject root,Camera camera,RecoveredSpecialScenes special)
    {
        var data=new GameObject("OriginalRainPrograms").AddComponent<RecoveredSnowPrograms>();
        data.emit=Create("Hidden/RainDropCompute",1,"RainEmit");data.update=Create("Hidden/RainDropCompute",3,"RainUpdate");data.draw=Create("Hidden/RainDrop",1,"RainDraw");
        data.draw.SetColor("_Color",new Color(1.147078395f,1.229012609f,1.304118872f,.623529434f));data.draw.SetFloat("_Size",.02f);data.draw.SetFloat("_Alpha",1);data.draw.enableInstancing=true;
        var path="Assets/Recovery/Weather/texture-54.png";var importer=(TextureImporter)AssetImporter.GetAtPath(path);importer.sRGBTexture=true;importer.textureCompression=TextureImporterCompression.Uncompressed;importer.SaveAndReimport();data.draw.SetTexture("_MainTex",AssetDatabase.LoadAssetAtPath<Texture2D>(path));
        var simulation=root.AddComponent<RecoveredSnowSimulation>();simulation.programs=data;simulation.bufferWidth=64;simulation.bufferHeight=64;simulation.slotCount=4096;simulation.initialRate=0;simulation.quad=AssetDatabase.LoadAssetAtPath<Mesh>("Assets/RecoveredS07/Environment/SnowComputeQuad.asset");
        var render=root.AddComponent<RecoveredRainRenderer>();render.drops=simulation;render.cameraSource=camera;render.specialScenes=special;render.collision=root.GetComponent<RecoveredCollisionSurface>();render.computeQuad=simulation.quad;render.drawQuad=AssetDatabase.LoadAssetAtPath<Mesh>("Assets/RecoveredS07/Environment/SnowQuadXY.asset");
        render.ringUpdate=Create("Hidden/RainRingUpdate",1,"RainRingUpdate");render.ringDraw=Create("Hidden/RainRing",1,"RainRingDraw");render.ringDraw.SetColor("_Color",new Color(.366283774f,.394459456f,.416999996f,.501960814f));render.ringDraw.SetFloat("_Size",.07f);render.ringDraw.SetFloat("_Alpha",1);render.ringDraw.enableInstancing=true;
    }
    static Material Create(string original,int index,string name){var shader=Shader.Find("Recovered/"+original+"/Variant"+index);if(shader==null||ShaderUtil.ShaderHasError(shader))throw new InvalidOperationException("Rain shader unavailable: "+original);var mat=new Material(shader){name=name};var path="Assets/RecoveredS07/Environment/"+name+".mat";AssetDatabase.DeleteAsset(path);AssetDatabase.CreateAsset(mat,path);return mat;}
}
