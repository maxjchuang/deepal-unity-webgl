Shader "Recovered/CarRP/Lit/OpaqueLampG318/Variant3" {
Properties {

[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2.0

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

[HDR] _ColorLight ("Color Light", Color) = (0,0,0,0)

ratio ("ratio", Range(0, 1)) = 0.0

}
SubShader {
Tags {"IsEmissive"="true" "Queue"="Geometry" "RenderType"="Opaque"}
Pass {Tags {"IsEmissive"="true" "LightMode"="ForwardBase" "Queue"="Geometry" "RenderType"="Opaque"}
Cull [_Cull]
Blend One Zero, One Zero
ZWrite On
ZTest LEqual
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
float4 _EmissionColor;
float _AOPower;
float _Metallic;
float _Smoothness;
float4 _ColorLight;
float ratio;
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
float4 vs_TEXCOORD1:TEXCOORD1;
float4 vs_TEXCOORD2:TEXCOORD2;
float2 vs_TEXCOORD7:TEXCOORD3;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;
float4 u_xlat16_1;
float4 u_xlat16_2;
float3 u_xlat3;
float u_xlat16_6;
float u_xlat16_10;

    u_xlat0 = input.in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * input.in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * input.in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    output.position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    output.vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = input.in_COLOR0.yzw * float3(2.0, 2.0, 2.0) + input.in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat16_2.xyz = u_xlat0.xyw * u_xlat0.xyw;
    u_xlat16_2.x = u_xlat16_2.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_6 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.z);
    u_xlat16_6 = u_xlat16_6 * SH2.x;
    u_xlat16_2.x = (-u_xlat0.w) * u_xlat0.w + u_xlat16_2.x;
    u_xlat16_1.w = u_xlat16_2.x * 0.31539157;
    u_xlat16_2.xzw = u_xlat0.wyx * u_xlat0.xwy;
    u_xlat16_1.xyz = u_xlat16_2.xzw * float3(1.09254849, 1.09254849, 1.09254849);
    u_xlat16_2.x = dot(SH1, u_xlat16_1);
    u_xlat16_1.yzw = u_xlat0.xyw * float3(0.488602519, 0.488602519, 0.488602519);
    u_xlat16_1.x = 0.282094806;
    u_xlat16_10 = dot(SH0, u_xlat16_1);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_10;
    output.vs_TEXCOORD1.y = u_xlat16_6 * 0.546274245 + u_xlat16_2.x;
    u_xlat16_2.x = (-input.in_COLOR0.x) + 2.0;
    output.vs_TEXCOORD1.x = u_xlat16_2.x * input.in_COLOR0.x;
    output.vs_TEXCOORD1.zw = u_xlat0.xy;
    u_xlat3.xyz = input.in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * input.in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * input.in_NORMAL0.zzz + u_xlat3.xyz;
    output.vs_TEXCOORD2 = u_xlat0;
    output.vs_TEXCOORD7.xy = input.in_TEXCOORD0.xy;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat16_0;
float u_xlat1;
int2 u_xlati1;
bool u_xlatb1;
float3 u_xlat16_2;
float3 u_xlat16_3;
float3 u_xlat16_4;
float3 u_xlat16_5;
float3 u_xlat16_6;
float3 u_xlat16_7;
float3 u_xlat16_8;
float3 u_xlat16_9;
float2 u_xlat10;
bool2 u_xlatb10;
float u_xlat16_11;
float3 u_xlat16_15;
int2 u_xlati19;
float2 u_xlat16_25;
float u_xlat16_27;

    u_xlat16_0.xy = float2(ratio,ratio) + float2(-0.400000006, -0.800000012);
    u_xlat1 = u_xlat16_0.x * 3.0 + -1.0;
    u_xlat1 = u_xlat1 * 5.0;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat10.xy = u_xlat16_0.xx * float2(15.000001, 3.0);
    u_xlat16_0.x = u_xlat16_0.y * 10.000001 + -1.0;
    u_xlat10.xy = u_xlat10.xy;
    u_xlat10.xy = clamp(u_xlat10.xy, 0.0, 1.0);
    u_xlat1 = u_xlat10.x * u_xlat1;
    u_xlat1 = u_xlat1 * 0.200000003;
    u_xlat16_9.x = (-input.vs_TEXCOORD7.x) + 1.0;
    u_xlat10.x = (-u_xlat10.y) + u_xlat16_9.x;
    u_xlat1 = u_xlat10.x / u_xlat1;
    u_xlat1 = u_xlat1 + 1.0;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat16_0.x = abs(u_xlat16_0.x) + (-u_xlat1);
    u_xlatb10.xy = (float4(0.800000012, 0.400000006, 0.0, 0.0) <  float4(ratio,ratio,ratio,ratio)).xy;
    u_xlat16_9.x = (u_xlatb10.x) ? float(1.0) : float(0.0);
    u_xlat16_9.y = (u_xlatb10.y) ? float(1.0) : float(0.0);
    u_xlat16_0.x = u_xlat16_9.x * u_xlat16_0.x + u_xlat1;
    u_xlat1 = (-ratio) * 3.0 + input.vs_TEXCOORD7.x;
    u_xlat1 = u_xlat1 * 5.0 + 1.0;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat1 = u_xlat1 * 2.0 + -1.0;
    u_xlat1 = -abs(u_xlat1) + 1.0;
    u_xlat1 = u_xlat1 + u_xlat1;
    u_xlat1 = min(u_xlat1, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-u_xlat1);
    u_xlat16_0.x = u_xlat16_9.y * u_xlat16_0.x + u_xlat1;
    u_xlat16_9.xyz = _EmissionColor.xyz + (-_ColorLight.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_9.xyz + _ColorLight.xyz;
    u_xlat16_2.xyz = (-input.vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_27 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_27 = rsqrt(u_xlat16_27);
    u_xlat16_2.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_2.xyz;
    u_xlat16_27 = dot(input.vs_TEXCOORD2.xyz, input.vs_TEXCOORD2.xyz);
    u_xlat16_27 = rsqrt(u_xlat16_27);
    u_xlat16_3.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * input.vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = input.vs_TEXCOORD2.xyz * float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) + u_xlat16_2.xyz;
    u_xlat16_27 = dot((-u_xlat16_2.xyz), u_xlat16_3.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_5.xyz = u_xlat16_3.xyz * (-float3(u_xlat16_27,u_xlat16_27,u_xlat16_27)) + (-u_xlat16_2.xyz);
    u_xlat16_27 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_27 = rsqrt(u_xlat16_27);
    u_xlat16_5.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_5.xyz;
    u_xlat16_27 = abs(u_xlat16_5.y) + abs(u_xlat16_5.x);
    u_xlat16_27 = abs(u_xlat16_5.z) + u_xlat16_27;
    u_xlat16_6.xyz = u_xlat16_5.xyz / float3(u_xlat16_27,u_xlat16_27,u_xlat16_27);
    u_xlati1.xy = int2(uint2((float4(0.0, 0.0, 0.0, 0.0) <  u_xlat16_6.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati19.xy = int2(uint2((u_xlat16_6.xzxz <  float4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati19.xy;
    u_xlat16_7.xy = float2(u_xlati1.xy);
    u_xlat16_25.xy = -abs(u_xlat16_6.zx) + float2(1.0, 1.0);
    u_xlat16_7.xy = u_xlat16_25.xy * u_xlat16_7.xy;
    u_xlatb1 = u_xlat16_6.y>=0.0;
    u_xlat16_6.xy = (bool(u_xlatb1)) ? u_xlat16_6.xz : u_xlat16_7.xy;
    u_xlat16_7.x = u_xlat16_6.x * 0.5 + 0.5;
    u_xlat16_7.y = -abs(u_xlat16_6.y) + 1.0;
    u_xlat16_6.xy = (-float2(_Metallic, _Smoothness)) * float2(0.959999979, 0.699999988) + float2(0.959999979, 1.70000005);
    u_xlat16_27 = u_xlat16_6.y * _Smoothness;
    u_xlat16_27 = u_xlat16_27 * 6.0;
    u_xlat16_15.xyz = tex2Dlod(_ReflMapDefault,float4( u_xlat16_7.xy,0, u_xlat16_27)).xyz;
    u_xlat16_7.x = dot(u_xlat16_3.xyz, u_xlat16_2.xyz);
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_27 = dot(u_xlat16_3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_3.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_7.y = _Smoothness;
    u_xlat16_7.xy = tex2Dlod(_LUT,float4( u_xlat16_7.xy,0, 0.0)).xy;
    u_xlat16_8.xyz = _BaseColor.xyz + float3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_8.xyz = float3(float3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + float3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_7.xxx + u_xlat16_7.yyy;
    u_xlat16_15.xyz = u_xlat16_15.xyz * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xxx * _BaseColor.xyz;
    u_xlat16_3.xyz = u_xlat16_7.xyz * u_xlat16_3.xyz + u_xlat16_15.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_27 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_27 = rsqrt(u_xlat16_27);
    u_xlat16_3.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_27 = dot(u_xlat16_3.xyz, u_xlat16_2.xyz);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_2.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_2.x;
    u_xlat16_2.x = (-_Smoothness) + 1.0;
    u_xlat16_2.xyz = max(u_xlat16_8.xyz, u_xlat16_2.xxx);
    u_xlat16_2.xyz = (-u_xlat16_8.xyz) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) + u_xlat16_8.xyz;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_6.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * _BaseColor.xyz;
    u_xlat16_3.xyz = input.vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xy = input.vs_TEXCOORD1.zw;
    u_xlat16_2.z = input.vs_TEXCOORD2.w;
    u_xlat16_27 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_27 = rsqrt(u_xlat16_27);
    u_xlat16_2.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_2.xyz;
    u_xlat16_27 = dot(u_xlat16_5.xyz, u_xlat16_2.xyz);
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat16_27) + 1.0;
    u_xlat16_11 = input.vs_TEXCOORD1.x * u_xlat16_2.x + u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 + input.vs_TEXCOORD1.x;
    u_xlat16_27 = u_xlat16_27 + -0.800000012;
    u_xlat16_27 = u_xlat16_27 / _Smoothness;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_11 = (-u_xlat16_27) + u_xlat16_11;
    u_xlat16_11 = _Smoothness * u_xlat16_11 + u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_2.x + (-u_xlat16_11);
    u_xlat16_27 = _AOColor.w * u_xlat16_27 + u_xlat16_11;
    u_xlat16_27 = u_xlat16_27 * input.vs_TEXCOORD1.x;
    u_xlat16_2.x = u_xlat16_27 * u_xlat16_27 + (-u_xlat16_27);
    u_xlat16_27 = _AOPower * u_xlat16_2.x + u_xlat16_27;
    u_xlat16_2.xyz = (-_AOColor.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_2.xyz + _AOColor.xyz;
    outputColor.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    outputColor.w = _BaseColor.w;
    return outputColor;

return outputColor;
}
ENDCG
}}}
