using UnityEngine;
// Native formulas and original reflection atlas; camera globals remain a
// documented adapter until the original lighting controller is recovered.
public sealed class RecoveredLighting : MonoBehaviour
{
 public Texture2D environment,brdf;public Light sun;public Vector4 sh0,sh1,sh2,ambient,lightColour,colourSun,pointLight,carRange;public float ratioOverrideAlbedo,valueOverrideAlbedo,ratioOverrideMetallic,valueOverrideMetallic,gsaaScale;public Vector4 lightDirection=new Vector4(0,1,0,0);
 void LateUpdate(){Shader.SetGlobalTexture("_LUT",brdf);Shader.SetGlobalFloat("_GSAA_Scale",gsaaScale);Shader.SetGlobalVector("_LightColor0",lightColour);Shader.SetGlobalVector("_WorldSpaceLightPos0",lightDirection);Shader.SetGlobalTexture("_ReflMapDefault",environment);Shader.SetGlobalVector("_AmbientColor",ambient);Shader.SetGlobalVector("colorSun",colourSun);Shader.SetGlobalVector("pointLight",pointLight);Shader.SetGlobalVector("carRange",carRange);Shader.SetGlobalVector("SH0",sh0);Shader.SetGlobalVector("SH1",sh1);Shader.SetGlobalVector("SH2",sh2);Shader.SetGlobalFloat("ratioOverrideAlbedo",ratioOverrideAlbedo);Shader.SetGlobalFloat("ratioOverrideMetallic",ratioOverrideMetallic);Shader.SetGlobalFloat("valueOverrideAlbedo",valueOverrideAlbedo);Shader.SetGlobalFloat("valueOverrideMetallic",valueOverrideMetallic);}
}
