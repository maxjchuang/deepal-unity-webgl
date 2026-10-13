using System;
using System.Collections;
using UnityEngine;

// Serialized vehicle-local resource bindings. Scene/camera orchestration belongs to the garage runtime.
public sealed class GarageVehicle : MonoBehaviour
{
    [Serializable] public class PaletteVariant { public string name; public Material[] materials; }
    [Serializable] public class Palette { public Material[] targets; public PaletteVariant[] variants;
        public void Apply(int index) { if(variants==null||index<0||index>=variants.Length)throw new ArgumentOutOfRangeException(nameof(index));var source=variants[index].materials;if(source.Length!=targets.Length)throw new InvalidOperationException("Original material preset group length mismatch");for(int i=0;i<targets.Length;i++){if(targets[i]==null||source[i]==null)throw new InvalidOperationException("Missing original preset material");targets[i].shader=source[i].shader;targets[i].shader=source[i].shader;targets[i].CopyPropertiesFromMaterial(source[i]);} }
    }
    [Serializable] public class Wheel { public string name,nodeId; public Transform target;public Vector3 originalPosition; }
    [Serializable] public class LightBinding { public string materialId,property,shaderName;public Material material;public Color on,off;public bool flash,gradient,requiresNativeRatioCapture; }
    [Serializable] public class ExtraPose{public Transform target;public Vector3 closedPosition,openPosition;public Quaternion closedRotation,openRotation;public bool closedActive,openActive;}
    [Serializable] public class Extra { public string type,label;public int configID;public float duration;public Transform t0,t1,rotator0,rotator1,rotator,translater;public Vector3 angles0,angles1,angles,pos0,pos1;public Quaternion closed0,closed1,closedRotation;public bool formulaVerified;public LightBinding light;public ExtraPose[] nativePoses;[NonSerialized]public Coroutine animation;[NonSerialized]public float progress; }
    [Serializable] public class Drawer { public string sourceComponent,assetID,name,nodeId;public Transform source;public Mesh mesh;public Material material;public int layer,instance,submesh;public float fixMirror,cull; }
    [Serializable] public class Global {public string name;public Vector4 value;}
    public string model,label,motionDurationSource;
    public bool is6S;
    public int carTypes,sideCharger,axisTrunk,configExtraSupports,configExtraDefault;
    public NativeCarControls controls;
    public RecoveredLightControls lights;
    public Palette paint,interior;
    public Wheel[] wheels;
    public Transform[] wheelNodes;public string[] wheelLabels;
    public Extra[] extras;
    public LightBinding[] gradients;
    public RecoveredBloomRegion.Proxy[] proxies;
    public Drawer[] drawers,reflectionBindings;
    public RecoveredCollisionSurface.Binding[] collisionBindings;
    public Vector3 cameraPosition,chargerPosition;
    public Quaternion cameraRotation;
    public float cameraFov,sentryScale;
    public Global[] globals;
    public string[] evidenceWarnings;
    public void SetPaint(int index){if(paint==null)throw new InvalidOperationException("No original paint preset");paint.Apply(index);}
    public void SetInterior(int index){if(interior==null)throw new InvalidOperationException("No original interior preset");interior.Apply(index);}
    public void SetWheel(int index){if(wheels==null||index<0||index>=wheels.Length)throw new ArgumentOutOfRangeException(nameof(index));for(int i=0;i<wheels.Length;i++)if(wheels[i].target!=null){wheels[i].target.gameObject.SetActive(true);wheels[i].target.localPosition=i==index?wheels[i].originalPosition:new Vector3(0,1000,0);}}
    public void SetExtraToggle(int id,bool enabled){if(extras==null)return;foreach(var e in extras){if(e.configID!=id||e.type!="ConfigExtraToggle")continue;if(e.nativePoses!=null&&e.nativePoses.Length>0){foreach(var pose in e.nativePoses){pose.target.gameObject.SetActive(enabled?pose.openActive:pose.closedActive);pose.target.localPosition=enabled?pose.openPosition:pose.closedPosition;pose.target.localRotation=enabled?pose.openRotation:pose.closedRotation;}}else{if(e.t0!=null)e.t0.gameObject.SetActive(!enabled);if(e.t1!=null)e.t1.gameObject.SetActive(enabled);}}}
    public static bool CanUseExtra(Extra e){return e.type=="ConfigExtraToggle"?(e.t0!=null||e.t1!=null):e.type=="ConfigExtraLight"?e.light?.material!=null:e.type=="ConfigExtraRotate2"?(e.rotator0!=null&&e.rotator1!=null):e.type=="ConfigExtraRotateAndTranslate2"?(e.rotator!=null&&e.translater!=null):false;}
    public bool SetExtra(int id,float value){if(extras==null)return false;foreach(var e in extras){if(e.configID!=id||!CanUseExtra(e))continue;value=Mathf.Clamp01(value);if(e.type=="ConfigExtraToggle"){SetExtraToggle(id,value>.5f);return true;}if(e.type=="ConfigExtraLight"){if(e.light?.material!=null)e.light.material.SetColor(e.light.property,value>.5f?e.light.on:e.light.off);return true;}if(e.type=="ConfigExtraRotate2"||e.type=="ConfigExtraRotateAndTranslate2"){if(e.animation!=null)StopCoroutine(e.animation);e.animation=StartCoroutine(AnimateExtra(e,value));return true;}}return false;}
    IEnumerator AnimateExtra(Extra e,float target){float start=e.progress,time=0,duration=e.duration*Mathf.Abs(target-start);while(time<duration){time+=Time.deltaTime;ApplyExtraPose(e,Mathf.Lerp(start,target,duration>0?time/duration:1));yield return null;}ApplyExtraPose(e,target);e.animation=null;}
    // Candidate reconstruction using exact serialized angles/positions. Formula awaits original extra API sampling.
    static void ApplyExtraPose(Extra e,float value){e.progress=value;if(e.type=="ConfigExtraRotate2"){if(e.rotator0!=null)e.rotator0.localRotation=Quaternion.Euler(e.angles0*Mathf.Clamp01((value-.1f)/.9f));if(e.rotator1!=null)e.rotator1.localRotation=Quaternion.Euler(e.angles1*Mathf.Clamp01(value/.1f));}else{if(e.rotator!=null)e.rotator.localRotation=Quaternion.Euler(e.angles*Mathf.Clamp01((value-.3f)/.7f));if(e.translater!=null)e.translater.localPosition=2f*value*(1-value)*e.pos0+value*value*e.pos1;}}
    // Caller supplies the native continuous phase. Boolean flash code must not overwrite alpha.
    public void SetGradientPhase(float phase){if(gradients==null)return;foreach(var binding in gradients){if(binding.material==null)continue;var value=binding.on;value.a=phase;binding.material.SetColor(binding.property,value);}}
}
