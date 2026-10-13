Shader "Recovered/Hidden/FX/Copy/Variant1" {
Properties {
_MainTex("Source",2D)="white"{}
_ClipRect("Clip rectangle",Vector)=(0,0,1,1)
sharpness("Original sharpen ratio",Float)=0
_rcpFrame("Reciprocal native frame",Vector)=(0,0,0,0)
}
SubShader { Pass { Cull Off ZWrite Off ZTest Always Blend One Zero
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
sampler2D _MainTex;float4 _ClipRect;float2 _rcpFrame;float sharpness;
struct AppData{float4 vertex:POSITION;float2 uv:TEXCOORD0;};
struct Varyings{float4 position:SV_POSITION;float2 uv:TEXCOORD0;};
// Adapter matches the existing Graphics.Blit clip convention; original fragment arithmetic follows.
Varyings vert(AppData input){Varyings output;float2 uv=lerp(_ClipRect.xy,_ClipRect.zw,input.uv);output.position=UnityObjectToClipPos(input.vertex);output.position.xy=(uv*2-1)*output.position.w;output.uv=uv;return output;}
float4 frag(Varyings input):SV_Target{float4 result;
float4 u_xlat16_0;

    u_xlat16_0 = tex2D(_MainTex, input.uv.xy);
    result = u_xlat16_0;
    return result;
}
ENDCG
}}}
