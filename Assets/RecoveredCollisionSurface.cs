using System;
using UnityEngine;

public sealed class RecoveredCollisionSurface : MonoBehaviour
{
    [Serializable] public class Binding {public Transform source;public Mesh mesh;public Material material;public int submesh;}
    public Binding[] bindings;
    public Mesh floorMesh;
    public Material floorMaterial;
    Camera capture;
    GameObject geometry;
    Transform[] copies;
    Matrix4x4[] previous;
    RenderTexture surface;
    bool ready;

    public void SetBindings(Binding[] value,Material floor)
    {
        if(geometry!=null)geometry.SetActive(false);
        OnDestroy();geometry=null;capture=null;surface=null;ready=false;
        bindings=value;floorMaterial=floor;
    }

    public RenderTexture Refresh()
    {
        if(surface==null)Create();
        var dirty=!ready;
        for(int i=0;i<bindings.Length;i++)
        {
            var source=bindings[i].source;var matrix=source.localToWorldMatrix;
            if(ready&&matrix==previous[i])continue;
            copies[i].SetPositionAndRotation(source.position,source.rotation);copies[i].localScale=source.lossyScale;
            previous[i]=matrix;dirty=true;
        }
        if(dirty){capture.Render();ready=true;}
        return surface;
    }
    void Create()
    {
        geometry=new GameObject("NativeCollisionGeometry");copies=new Transform[bindings.Length];previous=new Matrix4x4[bindings.Length];
        for(int i=0;i<bindings.Length;i++)
        {
            var binding=bindings[i];var go=Node(binding.source.name,binding.mesh,binding.material);copies[i]=go.transform;
        }
        var floor=Node("NativeCollisionFloor",floorMesh,floorMaterial);floor.transform.localScale=Vector3.one*30;
        var cameraObject=new GameObject("NativeCollisionCamera");cameraObject.transform.SetParent(geometry.transform);
        capture=cameraObject.AddComponent<Camera>();capture.enabled=false;capture.transform.SetPositionAndRotation(new Vector3(.21f,2.5f,0),new Quaternion(.70710677f,0,0,.70710677f));
        capture.orthographic=true;capture.orthographicSize=2;capture.aspect=2;capture.nearClipPlane=.001f;capture.farClipPlane=3;capture.cullingMask=1<<31;
        capture.clearFlags=CameraClearFlags.SolidColor;capture.backgroundColor=Color.clear;capture.allowHDR=false;capture.allowMSAA=false;capture.useOcclusionCulling=false;
        surface=new RenderTexture(256,128,24,RenderTextureFormat.ARGB32,RenderTextureReadWrite.Linear){name="RecoveredDynamicS07Collision",filterMode=FilterMode.Bilinear,wrapMode=TextureWrapMode.Clamp};surface.Create();capture.targetTexture=surface;
    }
    GameObject Node(string name,Mesh mesh,Material material)
    {
        var go=new GameObject(name);go.layer=31;go.transform.SetParent(geometry.transform,false);go.AddComponent<MeshFilter>().sharedMesh=mesh;go.AddComponent<MeshRenderer>().sharedMaterial=material;return go;
    }
    void OnDestroy()
    {
        if(surface!=null){surface.Release();if(Application.isPlaying)Destroy(surface);else DestroyImmediate(surface);}
        if(geometry!=null){if(Application.isPlaying)Destroy(geometry);else DestroyImmediate(geometry);}
    }
}
