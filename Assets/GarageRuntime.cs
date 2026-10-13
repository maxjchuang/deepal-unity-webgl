using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.Scripting;

// Keeps one Unity player alive. A failed asynchronous load preserves the current vehicle.
[Preserve,DefaultExecutionOrder(-100)]
public sealed class GarageRuntime : MonoBehaviour
{
    [Serializable] public class Entry{public string id,label,environment;}
    [Serializable] public class Command{public string method,arg;}
    [Serializable] class Choice{public string value,label;public float state;public bool disabled;}
    [Serializable] class VehicleInfo{public string id,label;public Choice[] paint,interior,wheels,extras;public bool loading,sixSeats;public float progress;public string error;}
    public Entry[] entries;
    public GameObject originalHierarchy,originalDrawers;
    public RecoveredTimeControls time;public RecoveredSpecialScenes scenes;public RecoveredWeatherControls weather;
    public RecoveredBloomRegion bloomRegion;public RecoveredCollisionSurface collision;
    public RecoveredSnowRenderer snow;public RecoveredRainRenderer rain;public RecoveredViewControls views;
    GarageVehicle active;GameObject vehicle;AssetBundle vehicleBundle;GarageEnvironmentProfile environment;
    readonly Dictionary<string,AssetBundle> environmentBundles=new Dictionary<string,AssetBundle>();
    readonly Dictionary<int,float> extraStates=new Dictionary<int,float>();
    bool loading;string view="default";GameObject drawerRoot;

    [Preserve]public void SelectVehicle(string id){if(loading)return;var entry=Array.Find(entries,e=>e.id==id);if(entry==null){ReportError("未知车型");return;}if(active!=null&&active.model==id){Publish();return;}StartCoroutine(Load(entry));}
    IEnumerator Load(Entry entry)
    {
        loading=true;Emit(new VehicleInfo{id=entry.id,label=entry.label,loading=true});
        AssetBundle nextBundle=null,envBundle=null;
        if(!environmentBundles.TryGetValue(entry.environment,out envBundle)){
            using(var request=UnityWebRequestAssetBundle.GetAssetBundle(Application.streamingAssetsPath+"/VehicleBundles/"+entry.environment)){
                var op=request.SendWebRequest();while(!op.isDone){Emit(new VehicleInfo{id=entry.id,label=entry.label,loading=true,progress=op.progress*.3f});yield return null;}
                if(request.result!=UnityWebRequest.Result.Success){ReportError(request.error);yield break;}
                envBundle=DownloadHandlerAssetBundle.GetContent(request);environmentBundles.Add(entry.environment,envBundle);
            }
        }
        using(var request=UnityWebRequestAssetBundle.GetAssetBundle(Application.streamingAssetsPath+"/VehicleBundles/vehicle-"+entry.id)){
            var op=request.SendWebRequest();while(!op.isDone){Emit(new VehicleInfo{id=entry.id,label=entry.label,loading=true,progress=.3f+op.progress*.6f});yield return null;}
            if(request.result!=UnityWebRequest.Result.Success){ReportError(request.error);yield break;}
            nextBundle=DownloadHandlerAssetBundle.GetContent(request);
        }
        var prefab=nextBundle.LoadAsset<GameObject>("Vehicle.prefab");var nextEnvironment=envBundle.LoadAsset<GarageEnvironmentProfile>("Profile.asset");
        if(prefab==null||nextEnvironment==null){nextBundle.Unload(true);ReportError("车型资源不完整");yield break;}
        var next=Instantiate(prefab);var nextVehicle=next.GetComponent<GarageVehicle>();
        if(nextVehicle==null||nextVehicle.collisionBindings.Length==0){Destroy(next);nextBundle.Unload(true);ReportError("车型控制数据不完整");yield break;}
        snow.SetSnowImmediate("0");rain.SetRainImmediate("0");
        originalHierarchy.SetActive(false);if(originalDrawers!=null)originalDrawers.SetActive(false);
        if(vehicle!=null){vehicle.SetActive(false);Destroy(vehicle);}
        if(drawerRoot!=null){drawerRoot.SetActive(false);Destroy(drawerRoot);}
        var previousBundle=vehicleBundle;vehicleBundle=nextBundle;vehicle=next;active=nextVehicle;environment=nextEnvironment;
        collision.SetBindings(active.collisionBindings,active.collisionBindings[0].material);bloomRegion.proxies=active.proxies;
        scenes.air.SetSixSeats(active.is6S);scenes.air.ResetControls();scenes.connectors.Configure(active);
        MakeDrawers();extraStates.Clear();foreach(var extra in active.extras)extraStates[extra.configID]=(active.configExtraDefault&extra.configID)!=0?1:0;
        views.SetView("default");view="default";
        // Wait until the old geometry is destroyed before unloading its referenced assets.
        yield return null;if(previousBundle!=null)previousBundle.Unload(true);
        while(views.IsTransitioning)yield return null;
        yield return new WaitForEndOfFrame();
        loading=false;Publish();
    }
    void MakeDrawers(){drawerRoot=new GameObject("ActiveVehicleReflectionDrawers");var control=drawerRoot.AddComponent<RecoveredReflectionDrawers>();var bindings=new List<RecoveredReflectionDrawers.Binding>();foreach(var source in active.reflectionBindings){var go=new GameObject(source.name);go.transform.SetParent(drawerRoot.transform,false);go.AddComponent<MeshFilter>().sharedMesh=source.mesh;var renderer=go.AddComponent<MeshRenderer>();renderer.sharedMaterial=source.material;bindings.Add(new RecoveredReflectionDrawers.Binding{source=source.source,target=go.transform,renderer=renderer});}control.bindings=bindings.ToArray();control.specialScenes=scenes;}
    void LateUpdate(){if(active==null||environment==null)return;var key=scenes.IsSpecial?view+(scenes.IsDark?"_dark":"") : time.selectedName+"_"+(scenes.IsDark?"dark":"bright")+"_"+weather.selected;var texture=environment.Find(key);if(texture!=null)time.lighting.environment=texture;time.lighting.sh0=environment.sh0;time.lighting.sh1=environment.sh1;time.lighting.sh2=environment.sh2;}
    [Preserve]public void Request(string json)
    {
        if(loading||active==null)return;
        try{var c=JsonUtility.FromJson<Command>(json);switch(c.method){
            case "ToggleNamedDoor":active.controls.ToggleNamedDoor(c.arg);break;
            case "ToggleNamedWindow":active.controls.ToggleNamedWindow(c.arg);break;
            case "ToggleTrunk":active.controls.ToggleTrunk(c.arg);break;
            case "ToggleLight":active.lights.ToggleLight(c.arg);break;
            case "ToggleLightFlash":active.lights.ToggleLightFlash(c.arg);break;
            case "SetPaint":active.SetPaint(int.Parse(c.arg));break;
            case "SetInterior":active.SetInterior(int.Parse(c.arg));break;
            case "SetWheel":active.SetWheel(int.Parse(c.arg));break;
            case "SetExtra":var parts=c.arg.Split(':');var id=int.Parse(parts[0]);var value=extraStates[id]>.5f?0:1;if(active.SetExtra(id,value)){extraStates[id]=value;Publish();}break;
            case "SetView":view=c.arg;views.SetView(view);break;
            default:originalHierarchy.transform.parent.gameObject.SendMessage(c.method,c.arg,SendMessageOptions.DontRequireReceiver);break;
        }}catch(Exception error){ReportError(error.Message);}
    }
    void Publish(){if(active==null)return;var paints=new List<Choice>();for(int i=0;i<(active.paint?.variants.Length??0);i++)paints.Add(new Choice{value=i.ToString(),label=active.paint.variants[i].name});var interiors=new List<Choice>();for(int i=0;i<(active.interior?.variants.Length??0);i++)interiors.Add(new Choice{value=i.ToString(),label=active.interior.variants[i].name});var wheels=new List<Choice>();for(int i=0;i<active.wheels.Length;i++)wheels.Add(new Choice{value=i.ToString(),label=active.wheels[i].name});var extras=new List<Choice>();foreach(var e in active.extras)if((active.configExtraSupports&e.configID)!=0)extras.Add(new Choice{value=e.configID.ToString(),label=e.label,state=extraStates[e.configID],disabled=!GarageVehicle.CanUseExtra(e)});Emit(new VehicleInfo{id=active.model,label=active.label,sixSeats=active.is6S,paint=paints.ToArray(),interior=interiors.ToArray(),wheels=wheels.ToArray(),extras=extras.ToArray(),loading=loading});}
    void ReportError(string error){loading=false;Emit(new VehicleInfo{id=active?.model,label=active?.label,error=error});}
    static void Emit(VehicleInfo info){RecoveryWebEvents.Emit("vehicle",JsonUtility.ToJson(info));}
}
