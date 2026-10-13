using System;
using System.IO;
using UnityEngine;
using UnityEditor.SceneManagement;

public static class RecoveredCollisionRuntimeProbe
{
    public static void Run()
    {
        EditorSceneManager.OpenScene("Assets/RecoveredS07/S07Recovery.unity");
        var surface=UnityEngine.Object.FindObjectOfType<RecoveredCollisionSurface>();
        var closed=Read(surface.Refresh());
        var controls=UnityEngine.Object.FindObjectOfType<NativeCarControls>();
        var door=Array.Find(controls.doors,d=>d.motion.name=="doorLF").target;
        var original=door.localRotation;door.localRotation=original*Quaternion.AngleAxis(55,Vector3.up);
        var opened=Read(surface.Refresh());int changed=0;for(int i=3;i<closed.Length;i+=4)if(closed[i]!=opened[i])changed++;
        door.localRotation=original;var restored=Read(surface.Refresh());
        for(int i=0;i<closed.Length;i++)if(closed[i]!=restored[i])throw new Exception("Collision map did not restore after closing door");
        if(changed==0)throw new Exception("Collision map did not follow native door transform");
        File.WriteAllBytes("collision-live-closed.rgba",closed);File.WriteAllBytes("collision-live-open.rgba",opened);
        File.WriteAllText("collision-live-probe.json","{\"doorChangedHeightPixels\":"+changed+",\"closedRestoredExactly\":true}");
        Debug.Log("Dynamic native collision transform probe passed");
    }
    static byte[] Read(RenderTexture target){var old=RenderTexture.active;RenderTexture.active=target;var texture=new Texture2D(256,128,TextureFormat.RGBA32,false,true);texture.ReadPixels(new Rect(0,0,256,128),0,0,false);texture.Apply(false,false);var bytes=texture.GetRawTextureData();UnityEngine.Object.DestroyImmediate(texture);RenderTexture.active=old;return bytes;}
}
