using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public static class RecoveredCollisionImporter
{
    [Serializable] public class Catalog {public Entry[] bindings;}
    [Serializable] public class Entry {public string name,nodeId,meshId,materialId;public int submesh,layer;public float fixMirror,cull;}
    public static void Import(GameObject root,Dictionary<string,GameObject> nodes,Dictionary<string,Mesh> meshes,Dictionary<string,Material> materials)
    {
        var source=JsonUtility.FromJson<Catalog>(File.ReadAllText("Assets/Recovery/Weather/collision-drawer.json"));
        var component=root.AddComponent<RecoveredCollisionSurface>();var array=new RecoveredCollisionSurface.Binding[source.bindings.Length];
        for(int i=0;i<array.Length;i++){var entry=source.bindings[i];var material=materials[entry.materialId];if(material.shader.name!="Recovered/CarRP/Hidden/Collision/Variant1"||ShaderUtil.ShaderHasError(material.shader))throw new InvalidOperationException("Native collision shader unavailable: "+entry.name);array[i]=new RecoveredCollisionSurface.Binding{source=nodes[entry.nodeId].transform,mesh=meshes[entry.meshId],material=material,submesh=entry.submesh};}
        component.bindings=array;component.floorMesh=AssetDatabase.LoadAssetAtPath<Mesh>("Assets/RecoveredS07/Environment/FloorNative.asset");component.floorMaterial=materials[source.bindings[0].materialId];
    }
}
