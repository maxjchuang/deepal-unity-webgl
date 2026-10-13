using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEditor.Build.Reporting;

public static class S07RecoveryImporter
{
    const string Input = "Assets/Recovery/S07/blueprint.json";
    const string Generated = "Assets/RecoveredS07";
    const string ScenePath = Generated + "/S07Recovery.unity";
    [Serializable] public class Blueprint { public Node[] nodes; public MeshRef[] meshes; public TextureRef[] textures; public MaterialRef[] materials; }
    [Serializable] public class Node { public string id,name,parent,mesh; public Vector3 position,scale; public Quaternion rotation; public bool active; public bool rendererEnabled=true; public string[] materials; }
    [Serializable] public class NativeMaterialDefaults {public NativeMaterialValue[] values;}
    [Serializable] public class NativeMaterialValue {public string materialName,property;public bool isColor;public Color color;public float scalar;}
    [Serializable] public class NativeRendererMasks {public NativeRendererMask[] nodes;}
    [Serializable] public class NativeRendererMask {public string nodeName;public uint mask;}
    [Serializable] public class NativeConfig { public NativeNode[] nodes; }
    [Serializable] public class NativeNode { public string nodeName,sourcePath;public Vector3 position; }
    [Serializable] public class MeshRef { public string id,file; }
    [Serializable] public class TextureRef { public string id,file,name; public int colorSpace,filterMode,wrapU,wrapV; }
    [Serializable] public class MaterialRef { public string id,name,shaderName; public string[] keywords; public int renderQueue; public ColorRef[] colors; public FloatRef[] floats; public TextureSlot[] textures; }
    [Serializable] public class ColorRef { public string name; public Color value; }
    [Serializable] public class FloatRef { public string name; public float value; }
    [Serializable] public class TextureSlot { public string name,texture; public Vector2 scale,offset; }
    [Serializable] public class MeshData { public string name; public Vector3[] vertices,normals; public Vector4[] tangents; public Vector2[] uv,uv2; public Color[] colors;public bool colorUNorm8; public IndexGroup[] submeshes; }
    [Serializable] public class IndexGroup { public int[] indices; }
    [Serializable] public class Ports {public Port[] ports;}
    [Serializable] public class Port {public string originalShader,shaderName;public string[] keywords;}
    [Serializable] public class NativeRenderState {public Vector4 ambient,lightColour,colourSun,pointLight,carRange;public Vector3 cameraPosition;public Quaternion cameraRotation;public float cameraFov,gsaaScale;public int colorSpace;}
    static T Read<T>(string path) { return JsonUtility.FromJson<T>(File.ReadAllText(path)); }
    static string Key(string id) { return id.Replace(':','_'); }
    static void Save(UnityEngine.Object value,string path) { if(AssetDatabase.LoadMainAssetAtPath(path)!=null) AssetDatabase.DeleteAsset(path); AssetDatabase.CreateAsset(value,path); }

    [MenuItem("Deepal Recovery/1. Import S07 Original Coordinates")]
    public static void Import()
    {
        var source=Read<Blueprint>(Input);var native=Read<NativeRenderState>("Assets/Recovery/S07/native-render-state.json");PlayerSettings.colorSpace=ColorSpace.Linear;
        Directory.CreateDirectory(Generated+"/Meshes");Directory.CreateDirectory(Generated+"/Materials");AssetDatabase.Refresh();
        var meshes=new Dictionary<string,Mesh>();
        foreach(var entry in source.meshes) {
            var d=Read<MeshData>(entry.file);
            var mesh=new Mesh {name=d.name,indexFormat=d.vertices.Length>65535?IndexFormat.UInt32:IndexFormat.UInt16};
            mesh.vertices=d.vertices;
            if(d.normals.Length==d.vertices.Length) mesh.normals=d.normals;
            if(d.tangents.Length==d.vertices.Length) mesh.tangents=d.tangents;
            if(d.uv.Length==d.vertices.Length) mesh.uv=d.uv;
            if(d.uv2.Length==d.vertices.Length) mesh.uv2=d.uv2;
            if(d.colors.Length==d.vertices.Length){if(d.colorUNorm8){var packed=new Color32[d.colors.Length];for(int i=0;i<packed.Length;i++){var c=d.colors[i];packed[i]=new Color32((byte)c.r,(byte)c.g,(byte)c.b,(byte)c.a);}mesh.colors32=packed;}else mesh.colors=d.colors;}
            mesh.subMeshCount=d.submeshes.Length;
            for(int i=0;i<d.submeshes.Length;i++)mesh.SetTriangles(d.submeshes[i].indices,i,false);
            if(d.normals.Length!=d.vertices.Length)mesh.RecalculateNormals();
            mesh.RecalculateBounds();Save(mesh,Generated+"/Meshes/"+Key(entry.id)+".asset");meshes.Add(entry.id,mesh);
        }
        var textures=new Dictionary<string,Texture2D>();
        foreach(var entry in source.textures){var importer=(TextureImporter)AssetImporter.GetAtPath(entry.file);bool srgb=entry.colorSpace==1;var wrapU=(TextureWrapMode)entry.wrapU;var wrapV=(TextureWrapMode)entry.wrapV;var filter=(FilterMode)entry.filterMode;if(importer.sRGBTexture!=srgb||importer.wrapModeU!=wrapU||importer.wrapModeV!=wrapV||importer.filterMode!=filter||importer.textureCompression!=TextureImporterCompression.Uncompressed){importer.sRGBTexture=srgb;importer.wrapModeU=wrapU;importer.wrapModeV=wrapV;importer.filterMode=filter;importer.textureCompression=TextureImporterCompression.Uncompressed;importer.SaveAndReimport();}textures.Add(entry.id,AssetDatabase.LoadAssetAtPath<Texture2D>(entry.file));}
        RecoveredEnvironment.Import();
        var restoredPorts=new List<Port>(Read<Ports>("Assets/RecoveredShaders/ports.json").ports);restoredPorts.AddRange(Read<Ports>("Assets/RecoveredMirrorShaders/ports.json").ports);restoredPorts.AddRange(Read<Ports>("Assets/RecoveredCollisionCommonShaders/ports.json").ports);restoredPorts.AddRange(Read<Ports>("Assets/RecoveredDepthReflectionShaders/ports.json").ports);var ports=restoredPorts.ToArray();
        var materials=new Dictionary<string,Material>();int missingShaders=0;int restoredMaterials=0;
        foreach(var entry in source.materials) {
            Shader shader=null;
            foreach(var port in ports){if(port.originalShader!=entry.shaderName||port.keywords.Length!=(entry.keywords?.Length??0))continue;bool same=true;foreach(var keyword in port.keywords)if(Array.IndexOf(entry.keywords,keyword)<0)same=false;if(same){shader=Shader.Find(port.shaderName);if(shader!=null&&!ShaderUtil.ShaderHasError(shader))restoredMaterials++;else shader=null;break;}}
            if(shader==null)shader=Shader.Find(entry.shaderName);
            if(shader==null) {shader=Shader.Find("Standard");missingShaders++;Debug.LogWarning("Original shader missing: "+entry.shaderName+" / "+entry.name+". Standard is a diagnostic fallback only.");}
            if(shader==null)throw new InvalidOperationException("No diagnostic shader available");
            var mat=new Material(shader){name=entry.name};mat.renderQueue=entry.renderQueue;
            foreach(var c in entry.colors)if(mat.HasProperty(c.name))mat.SetColor(c.name,c.value);
            foreach(var f in entry.floats){int index=shader.FindPropertyIndex(f.name);if(index<0)continue;var type=shader.GetPropertyType(index);if(type==ShaderPropertyType.Float||type==ShaderPropertyType.Range||type==ShaderPropertyType.Int)mat.SetFloat(f.name,f.value);}
            foreach(var slot in entry.textures)if(mat.HasProperty(slot.name)&&textures.TryGetValue(slot.texture,out var tex)) {mat.SetTexture(slot.name,tex);mat.SetTextureScale(slot.name,slot.scale);mat.SetTextureOffset(slot.name,slot.offset);}
            // Preserve original property metadata in blueprint; fallback translation
            // is for inspection, and is never treated as the recovered CarRP shader.
            if(shader.name=="Standard") {
                foreach(var c in entry.colors)if(c.name=="_BaseColor")mat.SetColor("_Color",c.value);
                foreach(var t in entry.textures)if(t.name=="_BaseMap"&&textures.TryGetValue(t.texture,out var diagnosticTexture))mat.SetTexture("_MainTex",diagnosticTexture);
            }
            Save(mat,Generated+"/Materials/"+Key(entry.id)+".mat");materials.Add(entry.id,mat);
        }
        var defaults=Read<NativeMaterialDefaults>("Assets/Recovery/S07/native-material-defaults.json");foreach(var value in defaults.values)foreach(var entry in source.materials)if(entry.name==value.materialName){var mat=materials[entry.id];if(value.isColor)mat.SetColor(value.property,value.color);else mat.SetFloat(value.property,value.scalar);EditorUtility.SetDirty(mat);}
        EditorSceneManager.NewScene(NewSceneSetup.EmptyScene,NewSceneMode.Single);
        var root=new GameObject("S07_OriginalHierarchy");var nodes=new Dictionary<string,GameObject>();
        var paint=root.AddComponent<RecoveredPaintControls>();
        paint.palette=new[]{materials["s07:-7896072911254535787"],materials["s07:-349682602857253158"],materials["s07:7752144505080071958"],materials["s07:-7534566939407317162"],materials["s07:-1601224337715859025"],materials["s07:-8963682156301354735"]};
        paint.body=materials["s07:-8098851792652826448"];paint.change=materials["s07:7138035473953057482"];paint.change1=materials["s07:1350783041371970028"];paint.change2=materials["s07:1478407551808247612"];paint.change3=materials["s07:-3059685782344647612"];paint.blackTrim=materials["s07:5093839813357641508"];paint.silverTrim=materials["s07:607080324541602945"];
        foreach(var node in source.nodes)nodes.Add(node.id,new GameObject(node.name));
        foreach(var node in source.nodes) {
            var go=nodes[node.id];go.transform.SetParent(nodes.TryGetValue(node.parent,out var parent)?parent.transform:root.transform,false);
            go.transform.localPosition=node.position;go.transform.localRotation=node.rotation;go.transform.localScale=node.scale;go.SetActive(node.active);
            if(!string.IsNullOrEmpty(node.mesh)&&meshes.TryGetValue(node.mesh,out var mesh)) {
                go.AddComponent<MeshFilter>().sharedMesh=mesh;var mr=go.AddComponent<MeshRenderer>();mr.enabled=node.rendererEnabled;
                var array=new Material[node.materials?.Length??0];for(int i=0;i<array.Length;i++)materials.TryGetValue(node.materials[i],out array[i]);mr.sharedMaterials=array;
            }
        }
        var masks=Read<NativeRendererMasks>("Assets/Recovery/S07/native-renderer-masks.json");foreach(var mask in masks.nodes)foreach(var node in source.nodes)if(node.name==mask.nodeName){var renderer=nodes[node.id].GetComponent<Renderer>();if(renderer!=null)renderer.renderingLayerMask=mask.mask;}
        var configuration=Read<NativeConfig>("Assets/Recovery/S07/native-configuration.json");foreach(var state in configuration.nodes)foreach(var node in source.nodes)if(node.name==state.nodeName)nodes[node.id].transform.localPosition=state.position;
        // No Body_L1/Body_R1/Trunk1 name-based hiding: original prefab groups
        // remain intact until the native visibility-controller logic is recovered.
        var motionCatalog=Read<NativeCarControls.Catalog>("Assets/Recovery/S07/native-motions.json");
        var carControls=root.AddComponent<NativeCarControls>();var doorBindings=new List<NativeCarControls.DoorBinding>();var windowBindings=new List<NativeCarControls.DoorBinding>();
        foreach(var motion in motionCatalog.motions)foreach(var node in source.nodes){
            if(node.name!=motion.nodeName)continue;
            if(motion.name.StartsWith("door"))doorBindings.Add(new NativeCarControls.DoorBinding{motion=motion,target=nodes[node.id].transform});
            else if(motion.name.StartsWith("window"))windowBindings.Add(new NativeCarControls.DoorBinding{motion=motion,target=nodes[node.id].transform});
            else if(motion.name=="trunk"){carControls.trunk=motion;carControls.trunkTransform=nodes[node.id].transform;}
        }
        carControls.doors=doorBindings.ToArray();carControls.windows=windowBindings.ToArray();
        var lightCatalog=Read<RecoveredLightControls.Catalog>("Assets/Recovery/S07/native-light-materials.json");
        Func<RecoveredLightControls.State[],RecoveredLightControls.State[]> bindLights=catalog=>{
            var result=new List<RecoveredLightControls.State>();
            foreach(var state in catalog)foreach(var entry in source.materials)if(entry.name==state.materialName){
                var binding=new RecoveredLightControls.State{materialName=state.materialName,property=state.property,on=state.on,off=state.off,material=materials[entry.id]};
                binding.material.SetColor(binding.property,binding.off);result.Add(binding);
            }
            return result.ToArray();
        };
        var lightControls=root.AddComponent<RecoveredLightControls>();lightControls.states=bindLights(lightCatalog.states);lightControls.flashes=bindLights(lightCatalog.flashes);

        var bounds=new Bounds(root.transform.position,Vector3.zero);bool first=true;
        foreach(var r in root.GetComponentsInChildren<Renderer>()) {if(first){bounds=r.bounds;first=false;}else bounds.Encapsulate(r.bounds);}
        var cameraObject=new GameObject("DiagnosticCamera");var camera=cameraObject.AddComponent<Camera>();camera.clearFlags=CameraClearFlags.SolidColor;camera.backgroundColor=new Color(.2f,.2f,.2f);camera.nearClipPlane=.01f;camera.farClipPlane=1000;camera.fieldOfView=35;
        camera.cullingMask=55;camera.fieldOfView=native.cameraFov;camera.transform.position=native.cameraPosition;camera.transform.rotation=native.cameraRotation;
        var forward=camera.transform.forward;var distanceToCentre=new Vector2(native.cameraPosition.x,native.cameraPosition.z).magnitude/Mathf.Max(.001f,new Vector2(forward.x,forward.z).magnitude);cameraObject.AddComponent<RecoveryOrbit>().target=native.cameraPosition+forward*distanceToCentre;
        var background=new GameObject("OriginalBG_Bright");var bgMesh=new Mesh();bgMesh.vertices=new[]{new Vector3(-.5f,-.5f,0),new Vector3(.5f,-.5f,0),new Vector3(.5f,.5f,0),new Vector3(-.5f,.5f,0)};bgMesh.uv=new[]{Vector2.zero,Vector2.right,Vector2.one,Vector2.up};bgMesh.triangles=new[]{0,1,2,0,2,3};Save(bgMesh,Generated+"/Environment/BackgroundMesh.asset");background.AddComponent<MeshFilter>().sharedMesh=bgMesh;background.AddComponent<MeshRenderer>();background.transform.SetParent(camera.transform,false);var bgController=background.AddComponent<RecoveredBackground>();bgController.cameraSource=camera;
        var bgMaterial=new Material(Shader.Find("Recovered/Hidden/SkyGradient"));bgMaterial.SetTexture("_MainTex",AssetDatabase.LoadAssetAtPath<Texture2D>(Generated+"/Environment/BG_Bright.asset"));bgMaterial.SetTexture("skyTexOverride",AssetDatabase.LoadAssetAtPath<Texture2D>(Generated+"/Environment/Day.asset"));bgMaterial.SetFloat("skyTexOverrideRatio",1);Save(bgMaterial,Generated+"/Environment/Background.mat");background.GetComponent<MeshRenderer>().sharedMaterial=bgMaterial;
        var lightObject=new GameObject("DiagnosticLight");var light=lightObject.AddComponent<Light>();light.type=LightType.Directional;light.intensity=1;light.color=new Color(native.lightColour.x,native.lightColour.y,native.lightColour.z,1).gamma;lightObject.transform.rotation=Quaternion.Euler(90,0,0);
        var lighting=root.AddComponent<RecoveredLighting>();lighting.environment=AssetDatabase.LoadAssetAtPath<Texture2D>(Generated+"/Environment/S7.asset");var brdf=new Texture2D(256,256,TextureFormat.RGBA32,false,true){name="Original_ibl_brdf_lut",wrapMode=TextureWrapMode.Clamp,filterMode=FilterMode.Bilinear};brdf.LoadRawTextureData(File.ReadAllBytes("Assets/Recovery/Environment/native-brdf-lut.rgba"));brdf.Apply(false,false);Save(brdf,Generated+"/Environment/NativeBRDF.asset");lighting.brdf=brdf;lighting.sun=light;lighting.ambient=native.ambient;lighting.lightColour=native.lightColour;lighting.colourSun=native.colourSun;lighting.pointLight=native.pointLight;lighting.carRange=native.carRange;lighting.gsaaScale=native.gsaaScale;lighting.sh0=new Vector4(2.4509432316f,-.0406451635f,.4544945061f,5.88389515e-9f);lighting.sh1=new Vector4(-2.96088778e-11f,-1.58331759e-9f,.0495497994f,-.0789440796f);lighting.sh2=new Vector4(-.2541347146f,0,0,0);
        Debug.Log("Restored GPU-formula material assignments: "+restoredMaterials);
        RecoveredNativeScene.Import();var timeCatalog=Read<RecoveredTimeControls.Catalog>("Assets/Recovery/NativeScene/time-states.json");foreach(var state in timeCatalog.states)state.reflection=RecoveredNativeReflection.Import(state);var timeControls=root.AddComponent<RecoveredTimeControls>();timeControls.states=timeCatalog.states;timeControls.lighting=lighting;timeControls.scene=UnityEngine.Object.FindObjectOfType<RecoveredSceneState>();timeControls.SetTime("day");var viewControls=cameraObject.AddComponent<RecoveredViewControls>();viewControls.states=Read<RecoveredViewControls.Catalog>("Assets/Recovery/S07/native-views.json").states;viewControls.specialScenes=RecoveredExtraSceneImporter.Import(timeControls);timeControls.specialScenes=viewControls.specialScenes;viewControls.cameraSource=camera;viewControls.orbit=cameraObject.GetComponent<RecoveryOrbit>();var proxyCatalog=Read<RecoveredBloomRegion.Catalog>("Assets/Recovery/S07/native-bloom-proxies.json");var bloomRegion=cameraObject.AddComponent<RecoveredBloomRegion>();foreach(var proxy in proxyCatalog.proxies)proxy.target=nodes[proxy.nodeId].transform;bloomRegion.proxies=proxyCatalog.proxies;RecoveredNativePost.Import(camera);RecoveredWeatherImporter.Import(root,timeControls,viewControls.specialScenes);RecoveredReflectionDrawerImporter.Import(root,nodes,meshes,materials,viewControls.specialScenes);RecoveredCollisionImporter.Import(root,nodes,meshes,materials);RecoveredSnowImporter.Import(root,camera,viewControls.specialScenes);RecoveredRainImporter.Import(root,camera,viewControls.specialScenes);RecoveredPlanetImporter.Import(root,camera,timeControls,viewControls.specialScenes);

        EditorSceneManager.SaveScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene(),ScenePath);AssetDatabase.SaveAssets();
        Debug.Log("S07 native coordinates imported. Missing original shaders: "+missingShaders+". Scene is an inspection baseline, not App parity.");
    }
    [MenuItem("Deepal Recovery/2. Build Diagnostic Web Preview")]
    public static void BuildDiagnosticWeb()
    {
        if(!File.Exists(ScenePath))Import();
        PlayerSettings.WebGL.compressionFormat=WebGLCompressionFormat.Disabled;
        var report=BuildPipeline.BuildPlayer(new BuildPlayerOptions{scenes=new[]{ScenePath},locationPathName="Builds/S07DiagnosticWeb",target=BuildTarget.WebGL,options=BuildOptions.None});
        if(report.summary.result!=BuildResult.Succeeded)throw new InvalidOperationException("Web build failed: "+report.summary.result);
        string version;using(var sha=System.Security.Cryptography.SHA256.Create()){version=BitConverter.ToString(sha.ComputeHash(File.ReadAllBytes("Builds/S07DiagnosticWeb/Build/S07DiagnosticWeb.data"))).Replace("-","").ToLowerInvariant().Substring(0,12);}
        Directory.CreateDirectory("Builds/S07DiagnosticWeb/Icons");foreach(var icon in Directory.GetFiles("WebHost/Icons"))File.Copy(icon,"Builds/S07DiagnosticWeb/Icons/"+Path.GetFileName(icon),true);
        File.WriteAllText("Builds/S07DiagnosticWeb/index.html",File.ReadAllText("WebHost/index.html").Replace("__BUILD_VERSION__",version));
    }
}
