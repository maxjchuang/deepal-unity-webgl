using UnityEngine;using UnityEngine.Scripting;
public sealed class RecoveredSpecialScenes:MonoBehaviour {
 public RecoveredTimeControls.State[] states,darkTimes;
 public Renderer carCenter,energyCenter,airBackground,sky,floor;public RecoveredAirControls air;public RecoveredChargeControls charge;public RecoveredConnectorControls connectors;
 public RecoveredLighting lighting;public RecoveredSceneState scene;public RecoveredTimeControls timeControls;public Texture2D brightSky,darkSky;
 public RecoveredWeatherControls weather;public bool IsDark=>dark;string active="default";bool dark;
 public void SetView(string name){
  bool center=name=="carCenter",energy=name=="energyCenter",ac=name=="airConditioner",charging=name=="chargingL"||name=="chargingR";active=name;
  carCenter.enabled=center;energyCenter.enabled=energy;airBackground.enabled=ac;air.SetVisible(ac);charge.SetVisible(charging);connectors.SetVisible(charging);sky.enabled=!(center||energy||ac||charging);floor.enabled=!(center||energy||ac||charging);airBackground.sharedMaterial.SetFloat("ratio",ac?1:0);lighting.ratioOverrideAlbedo=ac?1:0;lighting.valueOverrideAlbedo=ac?.5f:0;lighting.ratioOverrideMetallic=ac?1:0;lighting.valueOverrideMetallic=0;
  carCenter.sharedMaterial.SetFloat("ratio",center?1:0);energyCenter.sharedMaterial.SetFloat("ratio",energy?1:0);scene.ratioCarCenter=center?1:0;
  if(IsSpecial)ApplyActive();else timeControls.SetTime(timeControls.selectedName);
 }
 [Preserve]public void SetAppearance(string name){dark=name=="dark";if(IsSpecial)ApplyActive();else timeControls.SetTime(timeControls.selectedName);}
 public bool IsSpecial=>active=="carCenter"||active=="energyCenter"||active=="airConditioner"||active=="chargingL"||active=="chargingR";
 void ThemeGlobals(){scene.isDarkTheme=dark?1:0;scene.sky=dark?darkSky:brightSky;charge.SetTheme(dark);airBackground.sharedMaterial.SetColor("_Color",dark?new Color(0,0,0,0):new Color(5.992156982f,5.992156982f,5.992156982f,0));energyCenter.sharedMaterial.SetColor("_Color0",dark?new Color(0,0,0,0):new Color(1.289000034f,1.539700031f,1.872499943f,1));energyCenter.sharedMaterial.SetColor("_Color1",dark?new Color(0,0,0,0):new Color(.541999996f,.635299981f,.856000006f,1));}
 void ApplyActive(){string name=active+(dark?"_dark":"");foreach(var state in states)if(state.name==name){timeControls.Apply(state);break;}ThemeGlobals();}
 public void Refresh(){if(IsSpecial){ApplyActive();weather?.Refresh();return;}ThemeGlobals();if(dark){foreach(var state in darkTimes)if(state.name==timeControls.selectedName+"_dark"){lighting.environment=state.reflection;scene.colorBGDefault=state.colorBGDefault;scene.colorBGCarCenter=state.colorBGCarCenter;break;}}weather?.Refresh();}
}
