using System;using UnityEngine;using UnityEngine.Scripting;
// Native S07 air/seat overlay GPU programs and captured endpoint parameter mapping.
public sealed class RecoveredAirControls:MonoBehaviour {
 [Serializable] public class SeatCommand{public int index,value;}
 public Material air,seats,seats5,seats6;public Renderer render5,render6;float[] seatValues=new float[7];bool sixSeats,visible;
 void Start(){air.SetFloat("value",0);seats.SetFloatArray("values",seatValues);}
 public void SetVisible(bool value){visible=value;transform.localPosition=new Vector3(0,visible?0:1000,0);air.SetFloat("ratio",visible?1:0);seats.SetFloat("ratio",visible?1:0);}
 public void SetSixSeats(bool value){sixSeats=value;seats=sixSeats?seats6:seats5;render5.enabled=!sixSeats;render6.enabled=sixSeats;seats.SetFloatArray("values",seatValues);SetVisible(visible);}
 public void ResetControls(){Array.Clear(seatValues,0,seatValues.Length);air.SetFloat("value",0);seats.SetFloatArray("values",seatValues);}
 [Preserve]public void SetAirFlow(string text){if(int.TryParse(text,out var value)&&value>=-1&&value<=1)air.SetFloat("value",value);}
 [Preserve]public void SetSeatHeat(string json){var command=JsonUtility.FromJson<SeatCommand>(json);if(command.index<0||command.index>=seatValues.Length||command.value<-3||command.value>3)return;seatValues[command.index]=command.value;seats.SetFloatArray("values",seatValues);}
}
