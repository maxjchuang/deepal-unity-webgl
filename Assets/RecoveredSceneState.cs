using UnityEngine;
// Exact daytime globals captured from the independent original Unity runtime.
public sealed class RecoveredSceneState:MonoBehaviour {
 public Vector4 skyColor;public Texture2D sky;public float isDarkTheme,ratioCarCenter,skyTime=.5f;public Vector4 skyColorOverride,paramY=new Vector4(.6651234627f,0,0,0),colorBGDefault=new Vector4(2.0098f,1.9956f,1.9972f,1),colorBGCarCenter=new Vector4(5.992157f,5.992157f,5.992157f,1);
 void LateUpdate(){Shader.SetGlobalTexture("skyTex",sky);Shader.SetGlobalVector("skyColor",skyColor);Shader.SetGlobalFloat("skyRadius",30);Shader.SetGlobalFloat("skyTime",skyTime);Shader.SetGlobalFloat("isDarkTheme",isDarkTheme);Shader.SetGlobalFloat("ratioCarCenter",ratioCarCenter);Shader.SetGlobalVector("paramY",paramY);Shader.SetGlobalVector("colorBGDefault",colorBGDefault);Shader.SetGlobalVector("colorBGCarCenter",colorBGCarCenter);}
}
