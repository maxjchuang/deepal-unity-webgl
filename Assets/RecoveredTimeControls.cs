using System;using UnityEngine;using UnityEngine.Scripting;
public sealed class RecoveredTimeControls:MonoBehaviour {
 [Serializable] public class State{public string name;public float skyTime,isDarkTheme;public Vector4 ambient,lightColour,lightDirection,colourSun,pointLight,carRange,skyColorOverride,paramY,colorBGDefault,colorBGCarCenter;public Texture2D reflection;}
 [Serializable] public class Catalog{public State[] states;}
 public string selectedName="day";public RecoveredSpecialScenes specialScenes;public State[] states;public RecoveredLighting lighting;public RecoveredSceneState scene;
 [Preserve] public void SetTime(string name){selectedName=name;foreach(var state in states)if(state.name==name){Apply(state);specialScenes?.Refresh();return;}}
 public void Apply(State state){lighting.ambient=state.ambient;lighting.lightColour=state.lightColour;lighting.lightDirection=state.lightDirection;lighting.colourSun=state.colourSun;lighting.pointLight=state.pointLight;lighting.carRange=state.carRange;lighting.environment=state.reflection;lighting.sun.color=new Color(state.lightColour.x,state.lightColour.y,state.lightColour.z,1).gamma;lighting.sun.transform.rotation=Quaternion.LookRotation(-new Vector3(state.lightDirection.x,state.lightDirection.y,state.lightDirection.z),Vector3.forward);scene.skyTime=state.skyTime;scene.skyColorOverride=state.skyColorOverride;scene.paramY=state.paramY;scene.colorBGDefault=state.colorBGDefault;scene.colorBGCarCenter=state.colorBGCarCenter;}
}
