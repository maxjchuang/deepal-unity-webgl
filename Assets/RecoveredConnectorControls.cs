using System;using UnityEngine;using UnityEngine.Scripting;
public sealed class RecoveredConnectorControls:MonoBehaviour {
 [Serializable] public class Command{public int side,state;}
 public Transform[] covers;public Transform[] parts;public Material[] lineMaterials;public Vector3[] positions;public Quaternion[] rotations;
 int[] states=new int[2];bool visible;
 public void Configure(GarageVehicle vehicle){Array.Clear(states,0,states.Length);for(int side=0;side<2;side++){covers[side]=null;foreach(var node in vehicle.GetComponentsInChildren<Transform>(true))if(node.name==(side==0?"ChargerL":"ChargerR")){covers[side]=node;break;}positions[side]=new Vector3(vehicle.chargerPosition.x,vehicle.chargerPosition.y,(side==0?-1:1)*Mathf.Abs(vehicle.chargerPosition.z));Apply(side);}}
 public void SetVisible(bool value){visible=value;for(int i=0;i<2;i++)Apply(i);}
 [Preserve]public void SetCharger(string json){var c=JsonUtility.FromJson<Command>(json);if(c.side<0||c.side>1||c.state<0||c.state>2)return;states[c.side]=c.state;if(covers[c.side]!=null)covers[c.side].localRotation=c.state>0?new Quaternion(0,.7071068287f,0,.7071068287f):Quaternion.identity;Apply(c.side);}
 void Apply(int side){parts[side].localPosition=visible&&states[side]>0?positions[side]:new Vector3(0,1000,0);parts[side].localRotation=rotations[side];lineMaterials[side].SetFloat("lineOffset",.0600000024f);lineMaterials[side].SetFloat("ratioCharger",states[side]==2?1:0);}
}
