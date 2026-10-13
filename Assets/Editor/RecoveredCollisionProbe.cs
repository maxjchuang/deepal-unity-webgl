using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor.SceneManagement;

// Candidate geometry comparison, kept separate from production until verified.
public static class RecoveredCollisionProbe
{
    [System.Serializable] public class DrawerCatalog {public DrawerBinding[] bindings;}
    [System.Serializable] public class DrawerBinding {public string name,nodeId,meshId,materialId;public int submesh,layer;public float fixMirror,cull;}
    public static void Run(){foreach(var mode in new[]{"drawer"})Capture(mode);}
    static void Capture(string mode)
    {
        EditorSceneManager.OpenScene("Assets/RecoveredS07/S07Recovery.unity");
        var shader=Shader.Find("Recovered/Hidden/Collision/Variant1");
        var root=GameObject.Find("S07_OriginalHierarchy");
        var renderers=new List<MeshRenderer>(root.GetComponentsInChildren<MeshRenderer>());
        if(mode=="drawer") {
            renderers.Clear();
            var blueprint=JsonUtility.FromJson<S07RecoveryImporter.Blueprint>(File.ReadAllText("Assets/Recovery/S07/blueprint.json"));
            var catalog=JsonUtility.FromJson<DrawerCatalog>(File.ReadAllText("Assets/Recovery/Weather/collision-drawer.json"));
            var drawerRoot=new GameObject("NativeDrawerSource");
            foreach(var binding in catalog.bindings){
                var name=System.Array.Find(blueprint.nodes,n=>n.id==binding.nodeId).name;
                var source=System.Array.Find(root.GetComponentsInChildren<Transform>(true),t=>t.name==name);
                var go=new GameObject(binding.name);go.transform.SetParent(drawerRoot.transform);go.transform.SetPositionAndRotation(source.position,source.rotation);go.transform.localScale=source.lossyScale;
                go.AddComponent<MeshFilter>().sharedMesh=UnityEditor.AssetDatabase.LoadAssetAtPath<Mesh>("Assets/RecoveredS07/Meshes/"+binding.meshId.Replace(':','_')+".asset");
                var material=new Material(shader);material.SetFloat("fixMirror",binding.fixMirror);material.SetFloat("_Cull",binding.cull);
                var renderer=go.AddComponent<MeshRenderer>();renderer.sharedMaterial=material;renderers.Add(renderer);
            }
        }
        renderers.Add(GameObject.Find("NativeFloor").GetComponent<MeshRenderer>());
        var holder=new GameObject("CollisionCandidate");var materials=new List<Material>();
        foreach(var source in renderers)
        {
            if(!source.enabled||!source.gameObject.activeInHierarchy)continue;
            if(mode.Contains("no-shell")&&source.name.StartsWith("Shell"))continue;
            if(mode.Contains("body1")&&(source.name=="Body_L1"||source.name=="Body_R1"))continue;
            if(mode.Contains("body0")&&(source.name=="Body_L0"||source.name=="Body_R0"))continue;
            if(mode.Contains("mask1")&&(source.renderingLayerMask&1)==0)continue;
            var mesh=source.GetComponent<MeshFilter>()?.sharedMesh;if(mesh==null)continue;
            var clone=new GameObject(source.name);clone.layer=31;clone.transform.SetParent(holder.transform);
            clone.transform.SetPositionAndRotation(source.transform.position,source.transform.rotation);clone.transform.localScale=source.transform.lossyScale;
            if(mode.Contains("opaque")){mesh=Object.Instantiate(mesh);for(int i=0;i<mesh.subMeshCount;i++)if(i>=source.sharedMaterials.Length||source.sharedMaterials[i].renderQueue>=2500)mesh.SetTriangles(new int[0],i);}
            clone.AddComponent<MeshFilter>().sharedMesh=mesh;var renderer=clone.AddComponent<MeshRenderer>();
            var array=new Material[source.sharedMaterials.Length];
            for(int i=0;i<array.Length;i++)
            {
                var original=source.sharedMaterials[i];var material=new Material(shader);materials.Add(material);
                material.SetFloat("fixMirror",original.HasProperty("fixMirror")?original.GetFloat("fixMirror"):0);
                material.SetFloat("_Cull",original.HasProperty("_Cull")?original.GetFloat("_Cull"):2);array[i]=material;
            }
            renderer.sharedMaterials=array;
        }
        var cameraObject=new GameObject("CollisionCandidateCamera");var camera=cameraObject.AddComponent<Camera>();camera.enabled=false;
        camera.transform.SetPositionAndRotation(new Vector3(.21f,2.5f,0),new Quaternion(.70710677f,0,0,.70710677f));
        camera.orthographic=true;camera.orthographicSize=2;camera.aspect=2;camera.nearClipPlane=.001f;camera.farClipPlane=3;camera.cullingMask=1<<31;
        camera.clearFlags=CameraClearFlags.SolidColor;camera.backgroundColor=Color.clear;camera.allowHDR=false;camera.allowMSAA=false;camera.useOcclusionCulling=false;
        var target=new RenderTexture(256,128,24,RenderTextureFormat.ARGB32,RenderTextureReadWrite.Linear);target.Create();camera.targetTexture=target;camera.Render();
        var previous=RenderTexture.active;RenderTexture.active=target;var image=new Texture2D(256,128,TextureFormat.RGBA32,false,true);image.ReadPixels(new Rect(0,0,256,128),0,0,false);image.Apply(false,false);
        File.WriteAllBytes("collision-candidate-"+mode+".rgba",image.GetRawTextureData());File.WriteAllBytes("collision-candidate-"+mode+".png",image.EncodeToPNG());
        RenderTexture.active=previous;camera.targetTexture=null;target.Release();Object.DestroyImmediate(target);Object.DestroyImmediate(image);Object.DestroyImmediate(cameraObject);Object.DestroyImmediate(holder);foreach(var material in materials)Object.DestroyImmediate(material);
        Debug.Log("Collision candidate captured for native comparison");
    }
}
