Shader "Recovered/CarRP/Lit/OpaqueWheelFX/Variant1" {
Properties {
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2.0
_GSAA_Intensity ("GSAA Intensity", Range(1, 10)) = 1.0
[NoScaleOffset] _ReflMapCustom ("Texture", Cube) = "black" { }
[HDR] _BaseColor ("Base Color", Color) = (0.5,0.5,0.5,1)
_BaseMap ("Texture", 2D) = "white" { }
_FresnelColor ("Color", Color) = (0,0,0,1)
_FresnelColorBlend ("Blend", Vector) = (1,0,0.5,0)
_BumpMapCustom ("Texture", 2D) = "white" { }
_BumpScale ("Scale", Range(0, 2)) = 1.0
_Metallic ("Metallic", Range(0, 1)) = 0.0
_Smoothness ("Roughness", Range(0.01, 1)) = 0.0
[HDR] _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
[HDR] _ClearCoatColor ("Color", Color) = (1,1,1,1)
_ClearCoatParam ("Param", Vector) = (0,1,45,44)
_ClearCoatBlend ("Blend", Vector) = (1,0,0.5,0)
[HDR] _EmissionColor ("Color", Color) = (0,0,0,0)
_AOColor ("Color", Color) = (0,0,0,0)
_AOPower ("Power", Range(0, 1)) = 0.0
[HDR] _FXColor ("FXColor", Color) = (0,0,0,0)
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
float4 pointLight;
float valueOverrideAlbedo;
float ratioOverrideAlbedo;
float valueOverrideMetallic;
float ratioOverrideMetallic;
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float4 _BaseColor;
float4 _AOColor;
float4 _SpecColor;
float4 _EmissionColor;
float _BumpScale;
float _AOPower;
float _Metallic;
float _Smoothness;
float4 _BumpMapCustom_ST;
float4 _FXColor;
float4 colorSun;
sampler2D _ReflMapDefault;
sampler2D _LUT;
sampler2D _BumpMapCustom;
struct AppData {
float4 in_POSITION0:POSITION0;
float3 in_NORMAL0:NORMAL0;
float4 in_COLOR0:COLOR0;
float2 in_TEXCOORD0:TEXCOORD0;
float4 in_TANGENT0:TANGENT0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD0:TEXCOORD0;
float4 vs_TEXCOORD1:TEXCOORD1;
float4 vs_TEXCOORD2:TEXCOORD2;
float2 vs_TEXCOORD3:TEXCOORD3;
float4 vs_TANGENT0:TEXCOORD4;
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
    output.vs_TEXCOORD3.xy = input.in_TEXCOORD0.xy * _BumpMapCustom_ST.xy + _BumpMapCustom_ST.zw;
    u_xlat0.xyz = input.in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * input.in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * input.in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat0.w = input.in_TANGENT0.w * unity_WorldTransformParams.w;
    output.vs_TANGENT0 = u_xlat0;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat16_0;
float3 u_xlat16_1;
float4 u_xlat16_2;
float3 u_xlat3;
int2 u_xlati3;
bool u_xlatb3;
float3 u_xlat4;
float4 u_xlat16_5;
float3 u_xlat6;
float3 u_xlat7;
float4 u_xlat16_8;
float3 u_xlat16_9;
float3 u_xlat16_10;
float3 u_xlat16_11;
float3 u_xlat16_12;
float3 u_xlat16_13;
float3 u_xlat16_14;
int2 u_xlati29;
float2 u_xlat16_34;
float u_xlat16_39;
float u_xlat16_41;
float u_xlat16_44;

    u_xlat16_0.xyz = input.vs_TEXCOORD0.xyz + (-pointLight.xyz);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.200000003;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_13.x = colorSun.w * pointLight.w;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_13.x;
    u_xlat16_0.x = u_xlat16_0.x * 4.0;
    u_xlat16_13.xyz = u_xlat16_0.xxx * colorSun.xyz;
    u_xlat16_1.xyz = colorSun.xyz * u_xlat16_0.xxx + _LightColor0.xyz;
    u_xlat16_0.x = dot(_BaseColor.xyz, float3(0.300000012, 0.5, 0.200000003));
    u_xlat16_0.x = u_xlat16_0.x + 0.699999988;
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_0.xyz = u_xlat16_13.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
    u_xlat16_39 = dot(input.vs_TEXCOORD2.xyz, input.vs_TEXCOORD2.xyz);
    u_xlat16_39 = rsqrt(u_xlat16_39);
    u_xlat16_1.xyz = float3(u_xlat16_39,u_xlat16_39,u_xlat16_39) * input.vs_TEXCOORD2.zxy;
    u_xlat16_39 = dot(input.vs_TANGENT0, input.vs_TANGENT0);
    u_xlat16_39 = rsqrt(u_xlat16_39);
    u_xlat16_2 = float4(u_xlat16_39,u_xlat16_39,u_xlat16_39,u_xlat16_39) * input.vs_TANGENT0;
    u_xlat3.xyz = u_xlat16_1.xyz * u_xlat16_2.yzx;
    u_xlat3.xyz = u_xlat16_1.zxy * u_xlat16_2.zxy + (-u_xlat3.xyz);
    u_xlat3.xyz = u_xlat16_2.www * u_xlat3.xyz;
    u_xlat4.y = u_xlat3.x;
    u_xlat4.z = u_xlat16_1.y;
    u_xlat4.x = u_xlat16_2.x;
    u_xlat16_5.xyz = tex2D(_BumpMapCustom, input.vs_TEXCOORD3.xy).xyz;
    u_xlat16_5.xyw = u_xlat16_5.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
    u_xlat16_39 = (-u_xlat16_5.z) + _Smoothness;
    u_xlat16_39 = u_xlat16_39 + 1.0;
    u_xlat16_39 = min(u_xlat16_39, 0.99000001);
    u_xlat16_5.xy = u_xlat16_5.xy * float2(_BumpScale,_BumpScale);
    u_xlat4.x = dot(u_xlat4.xyz, u_xlat16_5.xyw);
    u_xlat6.x = u_xlat16_2.y;
    u_xlat7.x = u_xlat16_2.z;
    u_xlat6.z = u_xlat16_1.z;
    u_xlat7.z = u_xlat16_1.x;
    u_xlat6.y = u_xlat3.y;
    u_xlat7.y = u_xlat3.z;
    u_xlat4.z = dot(u_xlat7.xyz, u_xlat16_5.xyw);
    u_xlat4.y = dot(u_xlat6.xyz, u_xlat16_5.xyw);
    u_xlat16_1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16_1.x = rsqrt(u_xlat16_1.x);
    u_xlat16_14.xyz = u_xlat16_1.xxx * u_xlat4.xyz;
    u_xlat16_2.x = dot(u_xlat16_14.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = (-input.vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_41 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_41 = rsqrt(u_xlat16_41);
    u_xlat16_2.xyz = float3(u_xlat16_41,u_xlat16_41,u_xlat16_41) * u_xlat16_2.xyz;
    u_xlat16_41 = dot((-u_xlat16_2.xyz), u_xlat16_14.xyz);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_41;
    u_xlat16_5.xyz = u_xlat16_14.xyz * (-float3(u_xlat16_41,u_xlat16_41,u_xlat16_41)) + (-u_xlat16_2.xyz);
    u_xlat16_8.x = dot(u_xlat16_14.xyz, u_xlat16_2.xyz);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_14.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_14.x = rsqrt(u_xlat16_14.x);
    u_xlat16_14.xyz = u_xlat16_14.xxx * u_xlat16_5.xyz;
    u_xlat16_41 = abs(u_xlat16_14.y) + abs(u_xlat16_14.x);
    u_xlat16_41 = abs(u_xlat16_14.z) + u_xlat16_41;
    u_xlat16_5.xyz = u_xlat16_14.xyz / float3(u_xlat16_41,u_xlat16_41,u_xlat16_41);
    u_xlati3.xy = int2(uint2((float4(0.0, 0.0, 0.0, 0.0) <  u_xlat16_5.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati29.xy = int2(uint2((u_xlat16_5.xzxz <  float4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = (-u_xlati3.xy) + u_xlati29.xy;
    u_xlat16_34.xy = float2(u_xlati3.xy);
    u_xlat16_9.xy = -abs(u_xlat16_5.zx) + float2(1.0, 1.0);
    u_xlat16_34.xy = u_xlat16_34.xy * u_xlat16_9.xy;
    u_xlatb3 = u_xlat16_5.y>=0.0;
    u_xlat16_5.xy = (bool(u_xlatb3)) ? u_xlat16_5.xz : u_xlat16_34.xy;
    u_xlat16_9.x = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_9.y = -abs(u_xlat16_5.y) + 1.0;
    u_xlat16_41 = (-u_xlat16_39) + 0.400000006;
    u_xlat16_8.y = ratioOverrideAlbedo * u_xlat16_41 + u_xlat16_39;
    u_xlat16_39 = (-u_xlat16_8.y) * 0.699999988 + 1.70000005;
    u_xlat16_39 = u_xlat16_39 * u_xlat16_8.y;
    u_xlat16_39 = u_xlat16_39 * 6.0;
    u_xlat16_5.xyz = tex2Dlod(_ReflMapDefault,float4( u_xlat16_9.xy,0, u_xlat16_39)).xyz;
    u_xlat16_8.xz = tex2Dlod(_LUT,float4( u_xlat16_8.xy,0, 0.0)).xy;
    u_xlat16_9.xyz = u_xlat16_5.xyz + (-_SpecColor.www);
    u_xlat16_9.xyz = clamp(u_xlat16_9.xyz, 0.0, 1.0);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_9.xyz;
    u_xlat16_10.xyz = float3(ratioOverrideAlbedo,ratioOverrideAlbedo,ratioOverrideAlbedo) * (-_SpecColor.xyz) + _SpecColor.xyz;
    u_xlat16_39 = valueOverrideMetallic + (-_Metallic);
    u_xlat16_39 = ratioOverrideMetallic * u_xlat16_39 + _Metallic;
    u_xlat16_11.xyz = float3(float3(valueOverrideAlbedo, valueOverrideAlbedo, valueOverrideAlbedo)) + (-_BaseColor.xyz);
    u_xlat16_11.xyz = float3(ratioOverrideAlbedo,ratioOverrideAlbedo,ratioOverrideAlbedo) * u_xlat16_11.xyz + _BaseColor.xyz;
    u_xlat16_12.xyz = u_xlat16_11.xyz + float3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_12.xyz = float3(u_xlat16_39,u_xlat16_39,u_xlat16_39) * u_xlat16_12.xyz + float3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_39 = (-u_xlat16_39) * 0.959999979 + 0.959999979;
    u_xlat16_10.xyz = u_xlat16_10.xyz + (-u_xlat16_12.xyz);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_10.xyz + u_xlat16_12.xyz;
    u_xlat16_8.xzw = u_xlat16_9.xyz * u_xlat16_8.xxx + u_xlat16_8.zzz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xzw;
    u_xlat16_41 = dot(u_xlat16_14.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = log2(u_xlat16_41);
    u_xlat16_44 = (-u_xlat16_8.y) + 1.0;
    u_xlat16_8.x = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.x = u_xlat16_8.x * 20.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_8.x;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_8.x = (-u_xlat16_44) * 10.0 + 10.5;
    u_xlat16_9.xyz = max(u_xlat16_12.xyz, float3(u_xlat16_44,u_xlat16_44,u_xlat16_44));
    u_xlat16_9.xyz = (-u_xlat16_12.xyz) + u_xlat16_9.xyz;
    u_xlat16_44 = float(1.0) / u_xlat16_8.x;
    u_xlat16_44 = u_xlat16_44 + -1.07000005;
    u_xlat16_44 = -abs(u_xlat16_44) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_44;
    u_xlat16_41 = u_xlat16_41 * 8.0;
    u_xlat16_8.xzw = u_xlat16_12.xyz * float3(u_xlat16_41,u_xlat16_41,u_xlat16_41);
    u_xlat16_8.xzw = u_xlat16_11.xyz * float3(u_xlat16_39,u_xlat16_39,u_xlat16_39) + u_xlat16_8.xzw;
    u_xlat16_0.xyz = u_xlat16_8.xzw * u_xlat16_0.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = _EmissionColor.xyz + float3(-20.0, -20.0, -20.0);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, float3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = u_xlat16_5.xyz + (-_EmissionColor.xyz);
    u_xlat16_5.xyz = float3(ratioOverrideAlbedo,ratioOverrideAlbedo,ratioOverrideAlbedo) * u_xlat16_5.xyz + _EmissionColor.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat4.xyz * u_xlat16_1.xxx + u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_1.x = rsqrt(u_xlat16_1.x);
    u_xlat16_5.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_5.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_9.xyz * u_xlat16_1.xxx + u_xlat16_12.xyz;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = float3(u_xlat16_39,u_xlat16_39,u_xlat16_39) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_11.xyz * u_xlat16_2.xyz;
    u_xlat16_5.xyz = input.vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xy = input.vs_TEXCOORD1.zw;
    u_xlat16_2.z = input.vs_TEXCOORD2.w;
    u_xlat16_39 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_39 = rsqrt(u_xlat16_39);
    u_xlat16_2.xyz = float3(u_xlat16_39,u_xlat16_39,u_xlat16_39) * u_xlat16_2.xyz;
    u_xlat16_39 = dot(u_xlat16_14.xyz, u_xlat16_2.xyz);
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_1.x = (-u_xlat16_39) + 1.0;
    u_xlat16_14.x = input.vs_TEXCOORD1.x * u_xlat16_1.x + u_xlat16_39;
    u_xlat16_39 = u_xlat16_39 + input.vs_TEXCOORD1.x;
    u_xlat16_39 = u_xlat16_39 + -0.800000012;
    u_xlat16_39 = u_xlat16_39 / u_xlat16_8.y;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_14.x = (-u_xlat16_39) + u_xlat16_14.x;
    u_xlat16_14.x = u_xlat16_8.y * u_xlat16_14.x + u_xlat16_39;
    u_xlat16_39 = u_xlat16_39 * u_xlat16_1.x + (-u_xlat16_14.x);
    u_xlat16_39 = _AOColor.w * u_xlat16_39 + u_xlat16_14.x;
    u_xlat16_39 = u_xlat16_39 * input.vs_TEXCOORD1.x;
    u_xlat16_1.x = u_xlat16_39 * u_xlat16_39 + (-u_xlat16_39);
    u_xlat16_39 = _AOPower * u_xlat16_1.x + u_xlat16_39;
    u_xlat16_1.xyz = (-_AOColor.xyz) + float3(0.699999988, 0.699999988, 0.699999988);
    u_xlat16_1.xyz = float3(ratioOverrideAlbedo,ratioOverrideAlbedo,ratioOverrideAlbedo) * u_xlat16_1.xyz + _AOColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = float3(u_xlat16_39,u_xlat16_39,u_xlat16_39) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + float3(0.300000012, 0.300000012, 0.300000012);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_2.xyz * _FXColor.xyz;
    u_xlat3.x = _Time.y * 5.0;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 0.5 + 0.5;
    u_xlat16_39 = (-input.vs_TEXCOORD0.y) + _FXColor.w;
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_39 = u_xlat16_39 * u_xlat16_39;
    u_xlat3.x = u_xlat3.x * u_xlat16_39;
    outputColor.xyz = u_xlat16_1.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = (-_BaseColor.w) + 0.600000024;
    outputColor.w = ratioOverrideAlbedo * u_xlat16_0.x + _BaseColor.w;
    return outputColor;

return outputColor;
}
ENDCG
}}}
