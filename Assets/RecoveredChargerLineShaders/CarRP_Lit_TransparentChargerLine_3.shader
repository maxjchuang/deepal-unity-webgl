Shader "Recovered/CarRP/Lit/TransparentChargerLine/Variant3" {
Properties {

[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2.0

[Enum(UnityEngine.Rendering.BlendMode)] _BlendSrc ("BlendSrc", Float) = 5.0

[Enum(UnityEngine.Rendering.BlendMode)] _BlendDst ("BlendDst", Float) = 10.0

[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("ZTest", Float) = 4.0

_GSAA_Intensity ("GSAA Intensity", Range(1, 10)) = 1.0

[NoScaleOffset] _ReflMapCustom ("Texture", Cube) = "black" { }

[HDR] _BaseColor ("Base Color", Color) = (0.5,0.5,0.5,1)

_BaseMap ("Texture", 2D) = "white" { }

_FresnelColor ("Color", Color) = (0,0,0,1)

_FresnelColorBlend ("Blend", Vector) = (1,0,0.5,0)

[Normal] _BumpMap ("Texture", 2D) = "bump" { }

_BumpScale ("Scale", Range(0, 2)) = 1.0

_Metallic ("Metallic", Range(0, 1)) = 0.0

_Smoothness ("Roughness", Range(0.01, 1)) = 0.0

[HDR] _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)

_FlakesScale ("Flakes Scale", Range(1, 20)) = 10.0

_FlakesIntensity ("Flakes Intensity", Range(0, 1)) = 0.5

[HDR] _FlakesColor ("Flakes Color", Color) = (1,1,1,1)

[HDR] _ClearCoatColor ("Color", Color) = (1,1,1,1)

_ClearCoatParam ("Param", Vector) = (0,1,45,44)

_ClearCoatBlend ("Blend", Vector) = (1,0,0.5,0)

[HDR] _EmissionColor ("Color", Color) = (0,0,0,0)

_AOColor ("Color", Color) = (0,0,0,0)

_AOPower ("Power", Range(0, 1)) = 0.0

[HDR] colorChargerStop ("Charger Stop", Color) = (0,0,0,0)

[HDR] colorChargerStart ("Charger Start", Color) = (0,0,0,0)

ratioCharger ("offset", Range(0, 1)) = 0.0

lineOffset ("offset", Float) = 0.0

}
SubShader {
Tags {"FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "Queue"="Transparent" "RenderType"="Transparent"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull [_Cull]
Blend [_BlendSrc] [_BlendDst], One One
ZWrite Off
ZTest [_ZTest]
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
float4 _LightColor0;
float3 _AmbientColor;
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
float4 SH0;
float4 SH1;
float4 SH2;
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float4 _BaseColor;
float4 _AOColor;
float _AOPower;
float _Metallic;
float _Smoothness;
float3 colorChargerStop;
float3 colorChargerStart;
float ratioCharger;
float lineOffset;
sampler2D _ReflMapDefault;
sampler2D _LUT;
struct AppData {
float4 in_POSITION0:POSITION0;
float3 in_NORMAL0:NORMAL0;
float4 in_COLOR0:COLOR0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD0:TEXCOORD0;
float vs_TEXCOORD6:TEXCOORD1;
float2 vs_TEXCOORD1:TEXCOORD2;
float3 vs_TEXCOORD2:TEXCOORD3;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;
float4 u_xlat16_1;
float4 u_xlat16_2;
float u_xlat16_5;
float u_xlat16_8;

    u_xlat0.x = input.in_POSITION0.y + 0.5;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) * lineOffset + input.in_POSITION0.y;
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * input.in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * input.in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    output.position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    output.vs_TEXCOORD0.xyz = u_xlat0.xyz;
    output.vs_TEXCOORD6 = (-input.in_TEXCOORD0.x) + 1.0;
    u_xlat0.xyz = input.in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * input.in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * input.in_NORMAL0.zzz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_2.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.z);
    u_xlat16_5 = u_xlat16_5 * SH2.x;
    u_xlat16_2.x = (-u_xlat0.z) * u_xlat0.z + u_xlat16_2.x;
    u_xlat16_1.w = u_xlat16_2.x * 0.31539157;
    u_xlat16_2.xzw = u_xlat0.zyx * u_xlat0.xzy;
    u_xlat16_1.xyz = u_xlat16_2.xzw * float3(1.09254849, 1.09254849, 1.09254849);
    u_xlat16_2.x = dot(SH1, u_xlat16_1);
    u_xlat16_1.yzw = u_xlat0.xyz * float3(0.488602519, 0.488602519, 0.488602519);
    output.vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_1.x = 0.282094806;
    u_xlat16_8 = dot(SH0, u_xlat16_1);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_8;
    output.vs_TEXCOORD1.y = u_xlat16_5 * 0.546274245 + u_xlat16_2.x;
    u_xlat16_2.x = (-input.in_COLOR0.x) + 2.0;
    output.vs_TEXCOORD1.x = u_xlat16_2.x * input.in_COLOR0.x;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat16_0;
float3 u_xlat16_1;
float3 u_xlat16_2;
float3 u_xlat16_3;
float u_xlat4;
int2 u_xlati4;
bool u_xlatb4;
float3 u_xlat16_5;
float3 u_xlat16_6;
float3 u_xlat16_7;
float3 u_xlat16_10;
int2 u_xlati18;
float2 u_xlat16_19;
float u_xlat16_21;

    u_xlat16_0.xyz = (-input.vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_21 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_21 = rsqrt(u_xlat16_21);
    u_xlat16_0.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_21 = dot(input.vs_TEXCOORD2.xyz, input.vs_TEXCOORD2.xyz);
    u_xlat16_21 = rsqrt(u_xlat16_21);
    u_xlat16_1.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * input.vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = input.vs_TEXCOORD2.xyz * float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) + u_xlat16_0.xyz;
    u_xlat16_21 = dot((-u_xlat16_0.xyz), u_xlat16_1.xyz);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_21;
    u_xlat16_3.xyz = u_xlat16_1.xyz * (-float3(u_xlat16_21,u_xlat16_21,u_xlat16_21)) + (-u_xlat16_0.xyz);
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = rsqrt(u_xlat16_21);
    u_xlat16_3.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_21 = abs(u_xlat16_3.y) + abs(u_xlat16_3.x);
    u_xlat16_21 = abs(u_xlat16_3.z) + u_xlat16_21;
    u_xlat16_3.xyz = u_xlat16_3.xyz / float3(u_xlat16_21,u_xlat16_21,u_xlat16_21);
    u_xlati4.xy = int2(uint2((float4(0.0, 0.0, 0.0, 0.0) <  u_xlat16_3.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati18.xy = int2(uint2((u_xlat16_3.xzxz <  float4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati18.xy;
    u_xlat16_5.xy = float2(u_xlati4.xy);
    u_xlat16_19.xy = -abs(u_xlat16_3.zx) + float2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_19.xy * u_xlat16_5.xy;
    u_xlatb4 = u_xlat16_3.y>=0.0;
    u_xlat16_3.xy = (bool(u_xlatb4)) ? u_xlat16_3.xz : u_xlat16_5.xy;
    u_xlat16_5.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_5.y = -abs(u_xlat16_3.y) + 1.0;
    u_xlat16_3.xy = (-float2(_Metallic, _Smoothness)) * float2(0.959999979, 0.699999988) + float2(0.959999979, 1.70000005);
    u_xlat16_21 = u_xlat16_3.y * _Smoothness;
    u_xlat16_21 = u_xlat16_21 * 6.0;
    u_xlat16_10.xyz = tex2Dlod(_ReflMapDefault,float4( u_xlat16_5.xy,0, u_xlat16_21)).xyz;
    u_xlat16_5.x = dot(u_xlat16_1.xyz, u_xlat16_0.xyz);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_21 = dot(u_xlat16_1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_1.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * _LightColor0.xyz;
    u_xlat16_5.y = _Smoothness;
    u_xlat16_5.xy = tex2Dlod(_LUT,float4( u_xlat16_5.xy,0, 0.0)).xy;
    u_xlat16_6.xyz = _BaseColor.xyz + float3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = float3(float3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + float3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_5.xxx + u_xlat16_5.yyy;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * _BaseColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz + u_xlat16_10.xyz;
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = rsqrt(u_xlat16_21);
    u_xlat16_2.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_7.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_7.x * u_xlat16_0.x;
    u_xlat16_7.x = (-_Smoothness) + 1.0;
    u_xlat16_7.xyz = max(u_xlat16_6.xyz, u_xlat16_7.xxx);
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_0.xxx + u_xlat16_6.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _BaseColor.xyz;
    u_xlat16_2.xyz = input.vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4 = _Time.y * 4.0;
    u_xlat4 = input.vs_TEXCOORD6 * 12.0 + (-u_xlat4);
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = u_xlat4 * 0.5 + 0.5;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat16_1.xyz = colorChargerStart.xyz * float3(u_xlat4,u_xlat4,u_xlat4) + (-float3(colorChargerStop.x, colorChargerStop.y, colorChargerStop.z));
    u_xlat16_1.xyz = float3(float3(ratioCharger, ratioCharger, ratioCharger)) * u_xlat16_1.xyz + float3(colorChargerStop.x, colorChargerStop.y, colorChargerStop.z);
    u_xlat16_21 = input.vs_TEXCOORD1.x * input.vs_TEXCOORD1.x + (-input.vs_TEXCOORD1.x);
    u_xlat16_21 = _AOPower * u_xlat16_21 + input.vs_TEXCOORD1.x;
    u_xlat16_2.xyz = (-_AOColor.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * u_xlat16_2.xyz + _AOColor.xyz;
    outputColor.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = input.vs_TEXCOORD6 + 0.300000012;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_7.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_7.x * u_xlat16_0.x;
    outputColor.w = u_xlat16_0.x * _BaseColor.w;
    return outputColor;

return outputColor;
}
ENDCG
}}}
