using System;using System.Collections;using UnityEngine;using UnityEngine.Scripting;
public sealed class NativeCarControls:MonoBehaviour
{
 [Serializable] public class Motion {public string name,nodeName;public Vector3 closedPosition,openPosition;public bool animatePosition;public Quaternion closedRotation,openRotation;public float observedAngle,derivedDuration;}
 [Serializable] public class Catalog {public Motion[] motions;}
 [Serializable] public class DoorBinding {public Motion motion;public Transform target;[NonSerialized]public bool open;[NonSerialized]public Coroutine animation;}
 public DoorBinding[] doors,windows;public Motion trunk;public Transform trunkTransform;
 bool trunkOpen;Coroutine trunkAnimation;
 void TogglePart(DoorBinding[] parts,string name){foreach(var part in parts){if(part.motion.name!=name)continue;part.open=!part.open;if(part.animation!=null)StopCoroutine(part.animation);part.animation=StartCoroutine(Animate(part.target,part.motion,part.open));return;}}
 [Preserve] public void ToggleNamedDoor(string name){TogglePart(doors,name);}
 [Preserve] public void ToggleNamedWindow(string name){TogglePart(windows,name);}
 [Preserve] public void ToggleDoor(string ignored){ToggleNamedDoor("doorLF");}
 [Preserve] public void ToggleTrunk(string ignored){trunkOpen=!trunkOpen;if(trunkAnimation!=null)StopCoroutine(trunkAnimation);trunkAnimation=StartCoroutine(Animate(trunkTransform,trunk,trunkOpen));}
 [Preserve] public void ToggleWindow(string ignored){ToggleNamedWindow("windowLF");}
 [Serializable]class MotionState{public string name;public bool value,moving;}
 static void Publish(Motion motion,bool value,bool moving){RecoveryWebEvents.Emit("motion",JsonUtility.ToJson(new MotionState{name=motion.name,value=value,moving=moving}));}
 IEnumerator Animate(Transform target,Motion motion,bool open){
  if(target==null||motion==null)yield break;
  var fromPosition=target.localPosition;var toPosition=open?motion.openPosition:motion.closedPosition;var from=target.localRotation;var to=open?motion.openRotation:motion.closedRotation;
  var travel=motion.observedAngle>0.001f?Quaternion.Angle(from,to)/motion.observedAngle:Vector3.Distance(fromPosition,toPosition)/Mathf.Max(.000001f,Vector3.Distance(motion.closedPosition,motion.openPosition));
  var duration=motion.derivedDuration*Mathf.Clamp01(travel);Publish(motion,open,true);float t=0;
  while(t<duration){t+=Time.deltaTime;target.localRotation=Quaternion.Slerp(from,to,duration>0?t/duration:1);if(motion.animatePosition)target.localPosition=Vector3.Lerp(fromPosition,toPosition,duration>0?t/duration:1);yield return null;}
  target.localRotation=to;if(motion.animatePosition)target.localPosition=toPosition;Publish(motion,open,false);
 }
}
