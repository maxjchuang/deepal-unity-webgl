Shader "Recovered/Hidden/FX/Sharpen/Variant1" {
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
float4 u_xlat0;
float4 u_xlat16_0;
float4 u_xlat1;
float3 u_xlat16_1;
float3 u_xlat16_2;
float3 u_xlat16_3;
float3 u_xlat4;
float2 u_xlat5;

    u_xlat0.xy = input.uv.xy + _rcpFrame.xy;
    u_xlat16_1.xyz = tex2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat0 = _rcpFrame.xyxy * float4(-1.0, 1.0, 0.0, 1.0) + input.uv.xyxy;
    u_xlat16_2.xyz = tex2D(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_3.xyz = tex2D(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = tex2D(_MainTex, input.uv.xy);
    u_xlat4.xyz = u_xlat16_0.xyz * float3(9.0, 9.0, 9.0) + (-u_xlat16_3.xyz);
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat1 = _rcpFrame.xyxy * float4(-1.0, 0.0, 1.0, 0.0) + input.uv.xyxy;
    u_xlat16_2.xyz = tex2D(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = tex2D(_MainTex, u_xlat1.zw).xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat16_3.xyz) + u_xlat4.xyz;
    u_xlat5.xy = input.uv.xy + (-_rcpFrame.xy);
    u_xlat16_2.xyz = tex2D(_MainTex, u_xlat5.xy).xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat1 = _rcpFrame.xyxy * float4(0.0, -1.0, 1.0, -1.0) + input.uv.xyxy;
    u_xlat16_2.xyz = tex2D(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = tex2D(_MainTex, u_xlat1.zw).xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat16_3.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = saturate(u_xlat4.xyz);
    u_xlat4.xyz = (-u_xlat16_0.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = float3(sharpness,sharpness,sharpness) * u_xlat4.xyz + u_xlat16_0.xyz;
    result.w = u_xlat16_0.w;
    result.xyz = u_xlat4.xyz;
    return result;
}
ENDCG
}}}
