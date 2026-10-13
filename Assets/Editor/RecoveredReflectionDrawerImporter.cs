using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public static class RecoveredReflectionDrawerImporter
{
    [Serializable] public class Catalog {public Entry[] bindings;}
    [Serializable] public class Entry {public string name,nodeId,meshId,materialId,shader;public int layer,submesh;}
    public static void Import(GameObject root,Dictionary<string,GameObject> nodes,Dictionary<string,Mesh> meshes,Dictionary<string,Material> materials,RecoveredSpecialScenes special)
    {
        var catalog=JsonUtility.FromJson<Catalog>(File.ReadAllText("Assets/Recovery/S07/native-mesh-drawer-bindings.json"));var list=new List<RecoveredReflectionDrawers.Binding>();
        var parent=new GameObject("NativeSerializedReflectionDrawers");
        foreach(var entry in catalog.bindings)
        {
            if(entry.layer!=0)continue;
            var material=materials[entry.materialId];
            if(material.shader.name=="Standard"||ShaderUtil.ShaderHasError(material.shader))throw new InvalidOperationException("Native layer-0 shader unavailable: "+entry.shader);
            var go=new GameObject(entry.name+"_"+material.name);go.transform.SetParent(parent.transform,false);go.AddComponent<MeshFilter>().sharedMesh=meshes[entry.meshId];var renderer=go.AddComponent<MeshRenderer>();renderer.sharedMaterial=material;
            var source=nodes[entry.nodeId].transform;go.transform.SetPositionAndRotation(source.position,source.rotation);go.transform.localScale=source.lossyScale;
            list.Add(new RecoveredReflectionDrawers.Binding{source=source,target=go.transform,renderer=renderer});
        }
        var controls=root.AddComponent<RecoveredReflectionDrawers>();controls.bindings=list.ToArray();controls.specialScenes=special;
    }
}
