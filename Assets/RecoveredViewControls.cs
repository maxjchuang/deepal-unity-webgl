using System;using System.Collections;using UnityEngine;using UnityEngine.Scripting;
public sealed class RecoveredViewControls:MonoBehaviour {
 [Serializable]public class Preset{public Vector3 origin;public float yaw,pitch,roll,posZ,fov,yawOffsetFix;public bool isLimitRange,isPitchReverse;public int zoomMode;public Vector2 yawRange,pitchRange,posZRange,fovRange,extentRangeX,extentRangeY,extentRangeZ;}
 [Serializable]public class State{public string name;public Vector3 position;public Quaternion rotation;public float fov;public int cullingMask;public Preset preset;}
 [Serializable]public class Catalog{public State[] states;}
 public RecoveredSpecialScenes specialScenes;public State[] states;public Camera cameraSource;public RecoveryOrbit orbit;Preset current;Coroutine animation;
 public bool IsTransitioning=>animation!=null;
 void Start(){foreach(var state in states)if(state.name=="default")current=state.preset;}
 [Preserve] public void SetView(string name){foreach(var state in states)if(state.name==name){if(animation!=null)StopCoroutine(animation);else if(current!=null)current=FromCamera();specialScenes?.SetView(name);cameraSource.cullingMask=state.cullingMask;animation=StartCoroutine(Transition(current,state));return;}}
 Preset FromCamera(){return orbit.GetNativePreset();}
 static float Ease(float progress){float v=1-Mathf.Pow(1-Mathf.Clamp01(progress),2.7f);float q=v*v;return .5f*(q+q*q*(3-2*q));}
 static Preset Mix(Preset a,Preset b,float t){return new Preset{origin=Vector3.Lerp(a.origin,b.origin,t),yaw=a.yaw+Mathf.DeltaAngle(a.yaw,b.yaw)*t,pitch=a.pitch+Mathf.DeltaAngle(a.pitch,b.pitch)*t,roll=a.roll+Mathf.DeltaAngle(a.roll,b.roll)*t,posZ=Mathf.Lerp(a.posZ,b.posZ,t),fov=Mathf.Lerp(a.fov,b.fov,t),yawOffsetFix=Mathf.Lerp(a.yawOffsetFix,b.yawOffsetFix,t)};}
 void Apply(Preset p){var rotation=Quaternion.Euler(p.pitch,p.yaw,p.roll);var position=p.origin+rotation*new Vector3(0,0,p.posZ);position.z+=Mathf.Cos(p.yaw*Mathf.Deg2Rad)*p.yawOffsetFix;cameraSource.transform.SetPositionAndRotation(position,rotation);cameraSource.fieldOfView=p.fov;}
 IEnumerator Transition(Preset start,State state){orbit.navigationEnabled=false;if(start==null)start=state.preset;float time=0;while(time<.7f){time+=Time.deltaTime;current=Mix(start,state.preset,Ease(time/.7f));Apply(current);yield return null;}current=state.preset;orbit.SetNativePreset(state.preset);orbit.navigationEnabled=true;animation=null;}
}
