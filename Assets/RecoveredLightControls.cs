using System;
using UnityEngine;
using UnityEngine.Scripting;
public sealed class RecoveredLightControls : MonoBehaviour
{
    [Serializable] public class State {public string materialName,property;public Color on,off;public Material material;public bool gradient;}
    [Serializable] public class Catalog {public State[] states,flashes;}
    public State[] states,flashes;
    public bool LightOn {get;private set;}
    public bool Flashing {get;private set;}
    float elapsed,tick;
    void Start(){Apply(states,false);Apply(flashes,false);Publish();}
    static void Apply(State[] bindings,bool value){Apply(bindings,value?1f:0f);}
    static void Apply(State[] bindings,float ratio){if(bindings==null)return;foreach(var state in bindings)if(state.material!=null){var color=state.gradient?state.on:(ratio>.5f?state.on:state.off);if(state.gradient)color.a=ratio;state.material.SetColor(state.property,color);}}
    // Original LightSwitch uses ratio > .5, not >= .5.
    public static bool FlashPhase(float time){return Mathf.Repeat(Mathf.Min(time,10f)+.25f,1f)>.5f;}
    void Update(){if(!Flashing)return;elapsed+=Time.deltaTime;tick+=Time.deltaTime;if(tick<.1f&&elapsed<10f)return;tick=Mathf.Repeat(tick,.1f);Apply(flashes,Mathf.Repeat(Mathf.Min(elapsed,10f)+.25f,1f));if(elapsed>=10f)FinishFlash();}
    [Preserve] public void SetLight(string value){LightOn=value=="1";Apply(states,LightOn);Publish();}
    [Preserve] public void ToggleLight(string ignored){SetLight(LightOn?"0":"1");}
    [Preserve] public void SetLightFlash(string value){if(value=="1"){
        // Repeated native start preserves the fractional second of timerFlash.
        elapsed=Flashing?Mathf.Repeat(elapsed,1f):0;tick=0;Flashing=true;Publish();
    }else if(Flashing)FinishFlash();}
    [Preserve] public void ToggleLightFlash(string ignored){SetLightFlash(Flashing?"0":"1");}
    void FinishFlash(){Flashing=false;Apply(flashes,false);if(LightOn)Apply(states,true);Publish();}
    void OnDisable(){if(Flashing)FinishFlash();}
    void Publish(){RecoveryWebEvents.Emit("lights",JsonUtility.ToJson(new LightState{light=LightOn,flash=Flashing}));}
    [Serializable] class LightState{public bool light,flash;}
}
