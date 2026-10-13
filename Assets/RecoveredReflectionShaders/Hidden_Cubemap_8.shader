Shader "Recovered/Hidden/Cubemap/Variant8" {
Properties {
_MainTex ("Original HDR",2D)="white" {}
skyTex ("Original sky gradient",2D)="white" {}
skyTime ("Time",Float)=0.5
isDarkTheme ("Dark",Float)=0
skyColorOverride ("Sky override",Vector)=(0,0,0,0)
_AmbientColor ("Ambient",Vector)=(1,1,1,1)
mipmap ("Mipmap",Int)=0

}
SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Off
Blend One Zero, One Zero
ZWrite Off
ZTest Always
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
float skyTime;
float isDarkTheme;
float4 skyColorOverride;
int mipmap;
float3 _AmbientColor;
sampler2D _MainTex;
sampler2D skyTex;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
};
// Graphics.Blit adapter for the original full-screen reflection pass.
Varyings vert(AppData input){Varyings output;output.position=UnityObjectToClipPos(input.in_POSITION0);output.vs_TEXCOORD0=input.in_TEXCOORD0*2-1;return output;}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float4 u_xlat16_0;
int2 u_xlati0;
float2 u_xlat1;
float3 u_xlat16_1;
int2 u_xlati1;
bool u_xlatb1;
float3 u_xlat16_2;
float3 u_xlat16_3;
float3 u_xlat16_4;
float3 u_xlat16_7;
float u_xlat11;
bool u_xlatb16;
float u_xlat16_17;

    u_xlati0.x = int((0.0<input.vs_TEXCOORD0.x) ? 0xFFFFFFFFu : uint(0));
    u_xlati1.x = int((input.vs_TEXCOORD0.x<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlat16_2.x = input.vs_TEXCOORD0.y * 0.5 + 0.5;
    u_xlat16_2.x = -abs(u_xlat16_2.x) + 1.0;
    u_xlati0.y = int((0.0<u_xlat16_2.x) ? 0xFFFFFFFFu : uint(0));
    u_xlati1.y = int((u_xlat16_2.x<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlati0.xy = (-u_xlati0.xy) + u_xlati1.xy;
    u_xlat16_7.xy = float2(u_xlati0.xy);
    u_xlat16_0.yz = abs(u_xlat16_2.xx);
    u_xlat16_0.xw = abs(input.vs_TEXCOORD0.xx);
    u_xlat16_3.xy = (-u_xlat16_0.zw) + float2(1.0, 1.0);
    u_xlat16_17 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_4.y = (-u_xlat16_0.y) + u_xlat16_17;
    u_xlat16_7.xy = u_xlat16_7.xy * u_xlat16_3.xy;
    u_xlatb1 = u_xlat16_4.y<0.0;
    u_xlat16_4.z = (u_xlatb1) ? u_xlat16_7.y : u_xlat16_2.x;
    u_xlat16_4.x = (u_xlatb1) ? u_xlat16_7.x : input.vs_TEXCOORD0.x;
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = rsqrt(u_xlat16_2.x);
    u_xlat16_7.x = u_xlat16_4.y * u_xlat16_2.x + 1.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_4.y) * u_xlat16_2.x + 0.899999976;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_3.x * 0.200000018 + 0.100000001;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_3.y = skyTime;
    u_xlat16_7.xyz = tex2D(skyTex, u_xlat16_3.xy).xyz;
    u_xlat16_3.x = u_xlat16_7.y + u_xlat16_7.x;
    u_xlat16_3.x = u_xlat16_7.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.333000004 + 9.99999975e-05;
    u_xlat16_7.xyz = u_xlat16_7.xyz / u_xlat16_3.xxx;
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) + skyColorOverride.xyz;
    u_xlat16_7.xyz = skyColorOverride.www * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = (-_AmbientColor.yyy) * float3(0.899999976, 0.899999976, 0.899999976) + u_xlat16_7.xyz;
    u_xlat16_3.x = _AmbientColor.y * 0.899999976;
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_3.xxx;
    u_xlat16_0.w = u_xlat16_0.z * 1.05999994;
    u_xlat16_2.xyz = log2(abs(u_xlat16_0.xyw));
    u_xlat16_2.xyz = u_xlat16_2.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_17 = (-skyColorOverride.w) + 1.0;
    u_xlat16_17 = u_xlat16_17 * 0.200000003;
    u_xlat1.xy = input.vs_TEXCOORD0.xy * float2(0.5, 0.5) + float2(0.5, 0.5);
    u_xlat11 = float(mipmap);
    u_xlat16_1.xyz = tex2Dlod(_MainTex,float4( u_xlat1.xy,0, u_xlat11)).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz + (-u_xlat16_1.xyz);
    u_xlat16_3.xyz = float3(u_xlat16_17,u_xlat16_17,u_xlat16_17) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlatb16 = isDarkTheme!=0;
    u_xlat16_3.xyz = (bool(u_xlatb16)) ? u_xlat16_3.xyz : u_xlat16_1.xyz;
    outputColor.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
