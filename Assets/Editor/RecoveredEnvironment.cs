using System;using System.IO;using UnityEngine;using UnityEditor;
public static class RecoveredEnvironment
{
 [Serializable] public class Catalog{public Entry[] textures;}
 [Serializable] public class Entry{public string name,file;public int width,height,format,mips;}
 public static void Import(){
  var catalog=JsonUtility.FromJson<Catalog>(File.ReadAllText("Assets/Recovery/Environment/textures.json"));
  Directory.CreateDirectory("Assets/RecoveredS07/Environment");AssetDatabase.Refresh();
  foreach(var entry in catalog.textures){
   var path="Assets/RecoveredS07/Environment/"+entry.name+".asset";if(AssetDatabase.LoadAssetAtPath<Texture2D>(path)!=null)continue;
   if(!SystemInfo.SupportsTextureFormat((TextureFormat)entry.format))throw new InvalidOperationException("GPU cannot decode original HDR texture format: "+entry.format);
   var source=new Texture2D(entry.width,entry.height,(TextureFormat)entry.format,entry.mips>1,true);source.LoadRawTextureData(File.ReadAllBytes(entry.file));source.Apply(false,false);
   var copy=new Material(Shader.Find("Hidden/DeepalRecovery/CopyMip"));var previous=RenderTexture.active;
   using(var stream=new MemoryStream()){
    for(int mip=0;mip<entry.mips;mip++){
     int w=Math.Max(1,entry.width>>mip),h=Math.Max(1,entry.height>>mip);var rt=RenderTexture.GetTemporary(w,h,0,RenderTextureFormat.ARGBHalf,RenderTextureReadWrite.Linear);
     copy.SetFloat("_Mip",mip);Graphics.Blit(source,rt,copy);RenderTexture.active=rt;
     var read=new Texture2D(w,h,TextureFormat.RGBAHalf,false,true);read.ReadPixels(new Rect(0,0,w,h),0,0,false);read.Apply(false,false);var bytes=read.GetRawTextureData();stream.Write(bytes,0,bytes.Length);
     UnityEngine.Object.DestroyImmediate(read);RenderTexture.ReleaseTemporary(rt);
    }
    var result=new Texture2D(entry.width,entry.height,TextureFormat.RGBAHalf,entry.mips>1,true){name=entry.name,filterMode=FilterMode.Trilinear,wrapMode=TextureWrapMode.Clamp};result.LoadRawTextureData(stream.ToArray());result.Apply(false,false);AssetDatabase.CreateAsset(result,path);
   }
   RenderTexture.active=previous;UnityEngine.Object.DestroyImmediate(source);UnityEngine.Object.DestroyImmediate(copy);
  }
  AssetDatabase.SaveAssets();
 }
}
