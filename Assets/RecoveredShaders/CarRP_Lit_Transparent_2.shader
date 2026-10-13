Shader "Recovered/CarRP/Lit/Transparent/Variant2" {
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
Highlight ("Highlight", Int) = 0
}

SubShader {
Tags {"FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "Queue"="Transparent" "RenderType"="Transparent"}
Pass {Tags {"FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "LightMode"="ForwardBase" "Queue"="Transparent" "RenderType"="Transparent"}
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
float4 pointLight;
float2 carRange;
float valueOverrideAlbedo;
float ratioOverrideAlbedo;
float valueOverrideMetallic;
float ratioOverrideMetallic;
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float4 _BaseColor;
float4 _BaseMap_ST;
float _Metallic;
float4 colorSun;
sampler2D _BaseMap;
struct AppData {
float4 in_POSITION0:POSITION0;
float3 in_NORMAL0:NORMAL0;
float4 in_COLOR0:COLOR0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD0:TEXCOORD0;
float2 vs_TEXCOORD1:TEXCOORD1;
float3 vs_TEXCOORD2:TEXCOORD2;
float2 vs_TEXCOORD3:TEXCOORD3;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;
float4 u_xlat16_1;
float4 u_xlat16_2;
float u_xlat16_5;
float u_xlat16_8;

    u_xlat0 = input.in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * input.in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * input.in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    output.position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    output.vs_TEXCOORD0.xyz = u_xlat0.xyz;
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
    output.vs_TEXCOORD3.xy = input.in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat16_0;
float3 u_xlat16_1;
float4 u_xlat16_2;
float4 u_xlat16_3;
float u_xlat4;
float3 u_xlat16_5;
float u_xlat16_10;
float u_xlat16_15;
float u_xlat16_16;

    u_xlat16_0.x = dot(input.vs_TEXCOORD2.xyz, input.vs_TEXCOORD2.xyz);
    u_xlat16_0.x = rsqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * input.vs_TEXCOORD2.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_5.xyz = input.vs_TEXCOORD0.xyz + (-pointLight.xyz);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = sqrt(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * 0.200000003;
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_10 = colorSun.w * pointLight.w;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = u_xlat16_5.x * 4.0;
    u_xlat16_5.xyz = u_xlat16_5.xxx * colorSun.xyz;
    u_xlat16_1.xyz = (-_LightColor0.xyz) + float3(0.5, 0.5, 0.5);
    u_xlat16_1.xyz = float3(ratioOverrideAlbedo,ratioOverrideAlbedo,ratioOverrideAlbedo) * u_xlat16_1.xyz + _LightColor0.xyz;
    u_xlat16_2 = tex2D(_BaseMap, input.vs_TEXCOORD3.xy);
    u_xlat16_3 = u_xlat16_2 * _BaseColor;
    u_xlat16_16 = dot(u_xlat16_3.xyz, float3(0.300000012, 0.5, 0.200000003));
    u_xlat16_16 = u_xlat16_16 + 0.699999988;
    u_xlat16_16 = float(1.0) / u_xlat16_16;
    u_xlat16_5.xyz = u_xlat16_5.xyz * float3(u_xlat16_16,u_xlat16_16,u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_15 = valueOverrideMetallic + (-_Metallic);
    u_xlat16_15 = ratioOverrideMetallic * u_xlat16_15 + _Metallic;
    u_xlat16_15 = (-u_xlat16_15) * 0.959999979 + 0.959999979;
    u_xlat16_1.xyz = (-_BaseColor.xyz) * u_xlat16_2.xyz + float3(float3(valueOverrideAlbedo, valueOverrideAlbedo, valueOverrideAlbedo));
    u_xlat16_16 = (-_BaseColor.w) * u_xlat16_2.w + 0.600000024;
    outputColor.w = ratioOverrideAlbedo * u_xlat16_16 + u_xlat16_3.w;
    u_xlat16_1.xyz = float3(ratioOverrideAlbedo,ratioOverrideAlbedo,ratioOverrideAlbedo) * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = float3(u_xlat16_15,u_xlat16_15,u_xlat16_15) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = input.vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat4 = _Time.y * 0.5;
    u_xlat4 = frac(u_xlat4);
    u_xlat16_15 = input.vs_TEXCOORD0.x * carRange.x + carRange.y;
    u_xlat16_15 = (-u_xlat4) * 3.0 + u_xlat16_15;
    u_xlat16_15 = -abs(u_xlat16_15) + 1.0;
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_15;
    outputColor.xyz = float3(u_xlat16_15,u_xlat16_15,u_xlat16_15) * float3(0.150000006, 0.349999994, 0.899999976) + u_xlat16_0.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
