using System;using System.IO;using UnityEngine;using UnityEditor;
public static class RecoveredNativeScene {
 const string Src="Assets/Recovery/NativeScene/",Dst="Assets/RecoveredS07/Environment/";
 public static void Import(){
  var skyTex=new Texture2D(128,32,TextureFormat.RGBAFloat,false,true){name="NativeSkyGradient_Bright",wrapMode=TextureWrapMode.Clamp,filterMode=FilterMode.Bilinear};skyTex.LoadRawTextureData(File.ReadAllBytes("Assets/Recovery/Environment/native-sky-gradient.bytes"));skyTex.Apply(false,false);Save(skyTex,Dst+"NativeSkyGradient.asset");
  var darkTex=new Texture2D(128,32,TextureFormat.RGBAFloat,false,true){name="NativeSkyGradient_Dark",wrapMode=TextureWrapMode.Clamp,filterMode=FilterMode.Bilinear};darkTex.LoadRawTextureData(File.ReadAllBytes("Assets/Recovery/Environment/native-sky-dark-gradient.bytes"));darkTex.Apply(false,false);Save(darkTex,Dst+"NativeSkyGradient_Dark.asset");
  var sky=new Material(Shader.Find("Recovered/Hidden/Sky/Variant1")){name="OriginalSky",renderQueue=2001};sky.SetTexture("_MainTex",AssetDatabase.LoadAssetAtPath<Texture2D>(Src+"SkyMountains.png"));Save(sky,Dst+"NativeSky.mat");Create("NativeSky","Cylinder",sky);
  var floor=new Material(Shader.Find("Recovered/CarRP/Unlit/Floor/Variant1")){name="OriginalFloorBright",renderQueue=1990};floor.SetColor("_BaseColor",new Color(5.6077385f,5.804501f,6.263614f,1));Save(floor,Dst+"NativeFloor.mat");Create("NativeFloor","Floor",floor);
  var state=new GameObject("NativeSceneState").AddComponent<RecoveredSceneState>();state.sky=skyTex;
 }
 static void Create(string name,string source,Material mat){var d=JsonUtility.FromJson<S07RecoveryImporter.MeshData>(File.ReadAllText(Src+source+".json"));var mesh=new Mesh{name=d.name};mesh.vertices=d.vertices;if(d.normals.Length==d.vertices.Length)mesh.normals=d.normals;if(d.uv.Length==d.vertices.Length)mesh.uv=d.uv;mesh.subMeshCount=d.submeshes.Length;for(int i=0;i<d.submeshes.Length;i++)mesh.SetTriangles(d.submeshes[i].indices,i);mesh.RecalculateBounds();Save(mesh,Dst+source+"Native.asset");var go=new GameObject(name);go.transform.localScale=Vector3.one*30;go.AddComponent<MeshFilter>().sharedMesh=mesh;go.AddComponent<MeshRenderer>().sharedMaterial=mat;}
 static void Save(UnityEngine.Object obj,string path){AssetDatabase.DeleteAsset(path);AssetDatabase.CreateAsset(obj,path);}
}
