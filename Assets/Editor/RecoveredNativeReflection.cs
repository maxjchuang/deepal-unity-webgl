using System;using System.IO;using UnityEngine;using UnityEditor;
public static class RecoveredNativeReflection {
 public static Texture2D Import(RecoveredTimeControls.State state=null,Texture2D nativeSky=null,Texture2D nativeAtlas=null,string destination=null){
  string dst=destination??"Assets/RecoveredS07/Environment/NativeReflection"+(state==null?"":"_"+state.name)+".asset";
  var shader=Shader.Find("Recovered/Hidden/Cubemap/Variant8");if(shader==null||ShaderUtil.ShaderHasError(shader))throw new InvalidOperationException("Original octahedral reflection shader port failed");
  var source=nativeAtlas??AssetDatabase.LoadAssetAtPath<Texture2D>("Assets/RecoveredS07/Environment/S7.asset");var sky=nativeSky??AssetDatabase.LoadAssetAtPath<Texture2D>(state!=null&&state.isDarkTheme>0?"Assets/RecoveredS07/Environment/NativeSkyGradient_Dark.asset":"Assets/RecoveredS07/Environment/NativeSkyGradient.asset");var material=new Material(shader);material.SetTexture("skyTex",sky);material.SetFloat("skyTime",state==null ? .5f : state.skyTime);material.SetFloat("isDarkTheme",state==null?0:state.isDarkTheme);material.SetVector("skyColorOverride",state==null?Vector4.zero:state.skyColorOverride);material.SetVector("_AmbientColor",state==null?new Vector4(.9999945f,.9999966f,.9999977f,1):state.ambient);
  var previous=RenderTexture.active;Texture2D result;
  using(var bytes=new MemoryStream()){
   for(int mip=0;mip<10;mip++){int w=Math.Max(1,512>>mip),h=Math.Max(1,256>>mip);var rt=RenderTexture.GetTemporary(w,h,0,RenderTextureFormat.ARGBHalf,RenderTextureReadWrite.Linear);material.SetInt("mipmap",mip);Graphics.Blit(source,rt,material,0);RenderTexture.active=rt;var image=new Texture2D(w,h,TextureFormat.RGBAHalf,false,true);image.ReadPixels(new Rect(0,0,w,h),0,0,false);image.Apply(false,false);var raw=image.GetRawTextureData();bytes.Write(raw,0,raw.Length);UnityEngine.Object.DestroyImmediate(image);RenderTexture.ReleaseTemporary(rt);}
   result=new Texture2D(512,256,TextureFormat.RGBAHalf,true,true){name="NativeOctahedralReflection_Day",filterMode=FilterMode.Trilinear,wrapMode=TextureWrapMode.Clamp};result.LoadRawTextureData(bytes.ToArray());result.Apply(false,false);
  }
  RenderTexture.active=previous;UnityEngine.Object.DestroyImmediate(material);AssetDatabase.DeleteAsset(dst);AssetDatabase.CreateAsset(result,dst);return result;
 }
}
