using UnityEngine;
// Native weighted curve, SceneCharger.Update arithmetic and captured entry/exit timer lifecycle.
public sealed class RecoveredChargeControls:MonoBehaviour {
 public Material brightMaterial,darkMaterial;public Vector4 directDark;public Renderer background;public RecoveredLighting lighting;public AnimationCurve curve;public float period=4;
 public Vector4 directBase=new Vector4(2,2,2,1);bool visible;float started;
 public void SetVisible(bool value){if(value&&!visible)started=Time.time;visible=value;background.enabled=value;background.sharedMaterial.SetFloat("ratio",value?1:0);}
 public void SetTheme(bool dark){var m=dark?darkMaterial:brightMaterial;if(background.sharedMaterial!=m){float value=background.sharedMaterial.GetFloat("value");background.sharedMaterial=m;m.SetFloat("value",value);}m.SetFloat("ratio",visible?1:0);directBase=dark?directDark:new Vector4(2,2,2,1);}
 void Update(){if(!visible)return;float phase=Mathf.Repeat(Time.time-started,period)/period;float value=curve.Evaluate(phase);background.sharedMaterial.SetFloat("value",value);float intensity=.2f+.8f*Mathf.Clamp01(Mathf.Pow(Mathf.Sin(value*Mathf.PI),4));lighting.lightColour=directBase*intensity;lighting.sun.color=new Color(lighting.lightColour.x,lighting.lightColour.y,lighting.lightColour.z,1).gamma;}
}
