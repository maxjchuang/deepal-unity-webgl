using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using UnityEditor.SceneManagement;
public static class GarageBuild
{
    [Serializable]public class EnvironmentBinding{public string model,sourceName;public Vector4 sh0,sh1,sh2,bentPoints,bentFactor;}
    [Serializable]public class EnvironmentCatalog{public EnvironmentBinding[] models;}
    [Serializable]public class WebCatalog{public GarageRuntime.Entry[] models;}
    const string Generated="Assets/RecoveredVehicles/Environment/";
    public static void Import()
    {
        S07RecoveryImporter.Import();
        RecoveredVehicleImporter.ImportAll();GarageVerifiedBindings.Apply();
        var atlases=RecoveredVehicleEnvironments.Import();
        var catalog=JsonUtility.FromJson<EnvironmentCatalog>(File.ReadAllText("Assets/Recovery/VehicleEnvironments/bindings.json"));
        var root=GameObject.Find("S07_OriginalHierarchy");var time=root.GetComponent<RecoveredTimeControls>();var weather=root.GetComponent<RecoveredWeatherControls>();var special=UnityEngine.Object.FindObjectOfType<RecoveredSpecialScenes>();
        var processed=new HashSet<string>();var entries=new List<GarageRuntime.Entry>();
        foreach(var binding in catalog.models){
            string name=binding.sourceName;entries.Add(new GarageRuntime.Entry{id=binding.model,label=binding.model.ToUpperInvariant().Replace("_"," · "),environment="environment-"+name.ToLowerInvariant()});
            if(!processed.Add(name))continue;
            string folder=Generated+name;Directory.CreateDirectory(folder);AssetDatabase.Refresh();
            var profile=ScriptableObject.CreateInstance<GarageEnvironmentProfile>();profile.nameSource=name;profile.sh0=binding.sh0;profile.sh1=binding.sh1;profile.sh2=binding.sh2;
            var reflections=new List<GarageEnvironmentProfile.Reflection>();
            foreach(var state in weather.states){string key=state.timeName+"_"+state.appearance+"_"+state.weather;var texture=RecoveredNativeReflection.Import(state,state.sky,atlases[binding.model],folder+"/"+key+".asset");reflections.Add(new GarageEnvironmentProfile.Reflection{key=key,texture=texture});}
            foreach(var state in special.states){string key=state.name;var texture=RecoveredNativeReflection.Import(state,null,atlases[binding.model],folder+"/"+key+".asset");reflections.Add(new GarageEnvironmentProfile.Reflection{key=key,texture=texture});}
            profile.reflections=reflections.ToArray();AssetDatabase.DeleteAsset(folder+"/Profile.asset");AssetDatabase.CreateAsset(profile,folder+"/Profile.asset");
        }
        var runtime=new GameObject("GarageRuntime").AddComponent<GarageRuntime>();runtime.entries=entries.ToArray();runtime.originalHierarchy=root.transform.GetChild(0).gameObject;runtime.originalDrawers=GameObject.Find("NativeSerializedReflectionDrawers");runtime.time=time;runtime.scenes=special;runtime.weather=weather;
        runtime.views=UnityEngine.Object.FindObjectOfType<RecoveredViewControls>();runtime.bloomRegion=UnityEngine.Object.FindObjectOfType<RecoveredBloomRegion>();runtime.collision=root.GetComponent<RecoveredCollisionSurface>();runtime.snow=root.GetComponent<RecoveredSnowRenderer>();runtime.rain=root.GetComponent<RecoveredRainRenderer>();
        EditorSceneManager.SaveScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene(),"Assets/RecoveredS07/S07Recovery.unity");AssetDatabase.SaveAssets();
        File.WriteAllText("WebHost/vehicles.json",JsonUtility.ToJson(new WebCatalog{models=runtime.entries},true));
    }
    public static void BuildBundles()
    {
        var builds=new List<AssetBundleBuild>();foreach(var directory in Directory.GetDirectories("Assets/RecoveredVehicles")){var id=Path.GetFileName(directory);var prefab=directory+"/Vehicle.prefab";if(!File.Exists(prefab))continue;builds.Add(new AssetBundleBuild{assetBundleName="vehicle-"+id,assetNames=new[]{prefab}});}
        foreach(var directory in Directory.GetDirectories(Generated)){var profile=directory+"/Profile.asset";if(!File.Exists(profile))continue;builds.Add(new AssetBundleBuild{assetBundleName="environment-"+Path.GetFileName(directory).ToLowerInvariant(),assetNames=new[]{profile}});}
        Directory.CreateDirectory("Assets/StreamingAssets/VehicleBundles");
        var manifest=BuildPipeline.BuildAssetBundles("Assets/StreamingAssets/VehicleBundles",builds.ToArray(),BuildAssetBundleOptions.ChunkBasedCompression,BuildTarget.WebGL);
        if(manifest==null||manifest.GetAllAssetBundles().Length!=29)throw new InvalidOperationException("Expected 23 vehicle bundles and 6 environment bundles");
        Debug.Log("GARAGE_BUNDLES_OK "+manifest.GetAllAssetBundles().Length);
    }
    public static void Build(){S07RecoveryImporter.BuildDiagnosticWeb();File.Copy("WebHost/vehicles.json","Builds/S07DiagnosticWeb/vehicles.json",true);}
}
