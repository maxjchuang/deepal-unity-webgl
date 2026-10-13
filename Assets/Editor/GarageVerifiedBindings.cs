using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
public static class GarageVerifiedBindings
{
    [Serializable]class Catalog{public Vehicle[] vehicles;}
    [Serializable]class Vehicle{public string id;public bool is6S,seatTypeCaptured;public Light[] lights;public Extra[] extras;}
    [Serializable]class Light{public string name,kind;public int type;}
    [Serializable]class Extra{public int id;public Pose[] poses;}
    [Serializable]class Pose{public string path;public Vector3 closedPosition,openPosition;public Quaternion closedRotation,openRotation;public bool closedActive,openActive;}
    public static void Apply()
    {
        var catalog=JsonUtility.FromJson<Catalog>(File.ReadAllText("Assets/Recovery/Vehicles/verified-bindings.json"));
        foreach(var data in catalog.vehicles){
            if(!data.seatTypeCaptured)throw new InvalidOperationException("Seat type not captured: "+data.id);
            var path="Assets/RecoveredVehicles/"+data.id+"/Vehicle.prefab";var root=PrefabUtility.LoadPrefabContents(path);
            try{
                var vehicle=root.GetComponent<GarageVehicle>();vehicle.is6S=data.is6S;
                foreach(var light in data.lights){var states=light.kind=="lights"?vehicle.lights.states:vehicle.lights.flashes;foreach(var state in states)if(state.material.name==light.name){state.property=light.type==0||light.type==3?"_EmissionColor":light.type==1?"_BaseColor":"_Color";state.gradient=light.type==3;if(!state.material.HasProperty(state.property))throw new InvalidOperationException("Native light property missing "+data.id+" / "+light.name);}}
                foreach(var extra in vehicle.extras){var evidence=Array.Find(data.extras,e=>e.id==extra.configID);if(evidence==null)continue;var poses=new List<GarageVehicle.ExtraPose>();foreach(var pose in evidence.poses){var target=root.transform.Find(pose.path);if(target==null)throw new InvalidOperationException("Native extra target missing "+pose.path);poses.Add(new GarageVehicle.ExtraPose{target=target,closedPosition=pose.closedPosition,openPosition=pose.openPosition,closedRotation=pose.closedRotation,openRotation=pose.openRotation,closedActive=pose.closedActive,openActive=pose.openActive});}extra.nativePoses=poses.ToArray();extra.formulaVerified=GarageVehicle.CanUseExtra(extra);}
                PrefabUtility.SaveAsPrefabAsset(root,path);
            }finally{PrefabUtility.UnloadPrefabContents(root);}
        }
        AssetDatabase.SaveAssets();Debug.Log("GARAGE_VERIFIED_BINDINGS_OK "+catalog.vehicles.Length);
    }
}
