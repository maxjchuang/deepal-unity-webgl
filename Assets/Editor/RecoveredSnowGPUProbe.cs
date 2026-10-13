using System;
using System.IO;
using UnityEngine;
using UnityEditor.SceneManagement;

public static class RecoveredSnowGPUProbe
{
    // An explicit empty-surface fixture checks MRT transport and integer indexing.
    // It is not a production replacement for the native collision texture.
    public static void Run()
    {
        EditorSceneManager.OpenScene("Assets/RecoveredS07/S07Recovery.unity");
        var go=new GameObject("SnowGPUProbe");var simulation=go.AddComponent<RecoveredSnowSimulation>();
        simulation.programs=GameObject.Find("S07_OriginalHierarchy").GetComponent<RecoveredSnowPrograms>();
        var quad=new Mesh{name="ComputeClipQuad"};quad.vertices=new[]{new Vector3(-1,-1,0),new Vector3(-1,1,0),new Vector3(1,1,0),new Vector3(1,-1,0)};quad.triangles=new[]{0,1,2,0,2,3};simulation.quad=quad;
        simulation.Play(Texture2D.whiteTexture);
        var before=Read(simulation.Velocities);
        int alive=0;foreach(var p in before){if(!Finite(p))throw new Exception("Non-finite snow emission output");if(p.a>0)alive++;}
        if(alive!=849)throw new Exception("Snow emit/index/MRT transport failed: expected 849 active native slots, got "+alive);
        if(simulation.Advance(1f/60f))throw new Exception("Native strict step gate failed");
        if(!simulation.Advance(.02f))throw new Exception("Snow update did not execute");
        var after=Read(simulation.Positions);foreach(var p in after)if(!Finite(p))throw new Exception("Non-finite snow update output");
        File.WriteAllText("snow-gpu-probe.json","{\"fixture\":\"empty collision surface\",\"emitActiveSlots\":"+alive+",\"strictStepGate\":true,\"updateFinite\":true,\"productionCollisionVerified\":false}");
        simulation.Stop();UnityEngine.Object.DestroyImmediate(go);UnityEngine.Object.DestroyImmediate(quad);
        Debug.Log("Original snow GPU MRT emit/update probe passed");
    }
    static Color[] Read(RenderTexture rt){var old=RenderTexture.active;RenderTexture.active=rt;var image=new Texture2D(rt.width,rt.height,TextureFormat.RGBAFloat,false,true);image.ReadPixels(new Rect(0,0,rt.width,rt.height),0,0,false);image.Apply(false,false);var result=image.GetPixels();UnityEngine.Object.DestroyImmediate(image);RenderTexture.active=old;return result;}
    static bool Finite(Color c)=>Finite(c.r)&&Finite(c.g)&&Finite(c.b)&&Finite(c.a);
    static bool Finite(float v)=>!float.IsNaN(v)&&!float.IsInfinity(v);
}
