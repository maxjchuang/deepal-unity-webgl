Shader "Recovered/Hidden/Environment/Cloud/Variant1" {
Properties {

_Alpha ("Alpha", Range(0, 1)) = 1.0

_FlatCloudsBaseTexture ("Base Map", 2D) = "black" { }

_FlatCloudsDetailTexture ("Detail Map", 2D) = "black" { }

_FlatCloudsParams ("_FlatCloudsParams", Vector) = (1,1,1,1)

_FlatCloudsTiling ("_FlatCloudsTiling", Vector) = (1,1,1,1)

_FlatCloudsAnimation ("_FlatCloudsAnimation", Vector) = (1,1,1,1)

_FlatCloudsLightingParams ("_FlatCloudsLightingParams", Vector) = (1,1,1,1)

_FlatCloudsAmbientColor ("_FlatCloudsAmbientColor", Color) = (1,1,1,1)

}
SubShader {
Tags {"RenderType"="Transparent" "Queue"="Transparent-3"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
ZWrite Off
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float skyTime;
float3 skyColor;
float isDarkTheme;
float densitySkySystem;
float _GlobalTime;
float4 _FlatCloudsParams;
float4 _FlatCloudsTiling;
float4 _FlatCloudsAnimation;
float4 _FlatCloudsLightingParams;
sampler2D skyTex;
sampler2D _FlatCloudsBaseTexture;
sampler2D _FlatCloudsDetailTexture;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
float3 vs_TEXCOORD2:TEXCOORD1;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;

    output.vs_TEXCOORD0.xy = input.in_TEXCOORD0.xy;
    u_xlat0 = input.in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * input.in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * input.in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * input.in_POSITION0.www + u_xlat0.xyz;
    output.vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    output.position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat16_0;
float4 u_xlat1;
float4 u_xlat16_1;
float4 u_xlat2;
float4 u_xlat16_2;
float4 u_xlat3;
float4 u_xlat4;
float4 u_xlat16_5;
float3 u_xlat16_6;
float3 u_xlat16_7;
float2 u_xlat16_14;
float u_xlat16_21;

    u_xlat16_0.xyz = input.vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_21 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_21 = rsqrt(u_xlat16_21);
    u_xlat16_0.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_21 = rsqrt(u_xlat16_21);
    u_xlat16_1.xyz = float3(u_xlat16_21,u_xlat16_21,u_xlat16_21) * _WorldSpaceLightPos0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, (-u_xlat16_0.xyz));
    u_xlat16_7.x = u_xlat16_0.x * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = dot(u_xlat16_0.xx, _FlatCloudsLightingParams.ww);
    u_xlat16_14.x = (-_FlatCloudsLightingParams.w) * _FlatCloudsLightingParams.w + 1.0;
    u_xlat2.x = u_xlat16_14.x * 0.119366206;
    u_xlat16_14.xy = _FlatCloudsLightingParams.ww * _FlatCloudsLightingParams.ww + float2(2.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat16_14.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_14.y;
    u_xlat16_0.x = log2(abs(u_xlat16_0.x));
    u_xlat16_0.x = u_xlat16_0.x * 1.5;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat16_7.x / u_xlat16_0.x;
    u_xlat16_7.x = dot(input.vs_TEXCOORD2.xyz, input.vs_TEXCOORD2.xyz);
    u_xlat16_7.x = rsqrt(u_xlat16_7.x);
    u_xlat16_1 = (-input.vs_TEXCOORD2.zyzy) * u_xlat16_7.xxxx + float4(0.0, 1.0, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * float4(0.0250000004, -0.0250000004, 0.0250000004, -0.0250000004);
    u_xlat2.x = input.vs_TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.800000012;
    u_xlat2.yw = exp2(u_xlat2.xx);
    u_xlat3.x = _Time.y * 0.300000012;
    u_xlat3.x = _GlobalTime * 20.0 + u_xlat3.x;
    u_xlat3 = u_xlat3.xxxx * _FlatCloudsAnimation;
    u_xlat2.xz = input.vs_TEXCOORD0.xx;
    u_xlat4 = u_xlat2.zwzw * _FlatCloudsTiling.xxyy + u_xlat3;
    u_xlat16_5 = tex2Dlod(_FlatCloudsBaseTexture,float4( u_xlat4.xy,0, 0.0));
    u_xlat4.xy = u_xlat4.zw + u_xlat4.zw;
    u_xlat16_7.xyz = tex2Dlod(_FlatCloudsDetailTexture,float4( u_xlat4.xy,0, 0.0)).xyz;
    u_xlat16_7.x = dot(u_xlat16_7.xyz, float3(0.625, 0.25, 0.125));
    u_xlat16_14.x = dot(u_xlat16_5.yzw, float3(0.625, 0.25, 0.125));
    u_xlat16_21 = (-u_xlat16_14.x) + u_xlat16_5.x;
    u_xlat16_14.x = (-u_xlat16_14.x) + 2.0;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_14.x = u_xlat16_21 / u_xlat16_14.x;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_21 = (-u_xlat16_7.x) * 0.5 + 1.0;
    u_xlat16_7.x = log2(abs(u_xlat16_7.x));
    u_xlat16_7.x = u_xlat16_7.x * 0.400000006;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_14.x = u_xlat16_14.x * _FlatCloudsParams.x + (-u_xlat16_21);
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_14.x = u_xlat16_14.x / u_xlat16_21;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_14.x;
    u_xlat16_7.x = u_xlat16_7.x * _FlatCloudsParams.y;
    u_xlat16_14.x = u_xlat16_7.x * 0.199999988 + 0.800000012;
    u_xlat1 = (-u_xlat16_1) * u_xlat16_14.xxxx + u_xlat2;
    u_xlat1 = u_xlat1 * _FlatCloudsTiling.xxyy + u_xlat3;
    u_xlat16_2 = tex2Dlod(_FlatCloudsBaseTexture,float4( u_xlat1.xy,0, 0.0));
    u_xlat3.xy = u_xlat1.zw + u_xlat1.zw;
    u_xlat16_5.xyz = tex2Dlod(_FlatCloudsDetailTexture,float4( u_xlat3.xy,0, 0.0)).xyz;
    u_xlat16_14.x = dot(u_xlat16_5.xyz, float3(0.625, 0.25, 0.125));
    u_xlat16_21 = dot(u_xlat16_2.yzw, float3(0.625, 0.25, 0.125));
    u_xlat16_5.x = (-u_xlat16_21) + u_xlat16_2.x;
    u_xlat16_21 = (-u_xlat16_21) + 2.0;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_21 = u_xlat16_5.x / u_xlat16_21;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_14.x) * 0.5 + 1.0;
    u_xlat16_14.x = log2(abs(u_xlat16_14.x));
    u_xlat16_14.x = u_xlat16_14.x * 0.400000006;
    u_xlat16_14.x = exp2(u_xlat16_14.x);
    u_xlat16_21 = u_xlat16_21 * _FlatCloudsParams.x + (-u_xlat16_5.x);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_21 = u_xlat16_21 / u_xlat16_5.x;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_21;
    u_xlat16_14.x = u_xlat16_14.x * _FlatCloudsParams.y + 3.0;
    u_xlat16_14.x = u_xlat16_14.x * 0.166666672;
    u_xlat16_21 = u_xlat16_14.x * _FlatCloudsLightingParams.z;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_0.x = dot(u_xlat16_0.xx, float2(u_xlat16_21,u_xlat16_21));
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_21;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_14.x;
    u_xlat16_0.x = u_xlat16_0.x * 32.0;
    u_xlat3.x = input.vs_TEXCOORD0.y * 4.80000019;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.y = skyTime;
    u_xlat16_5.xyz = tex2D(skyTex, u_xlat3.xy).xyz;
    u_xlat16_14.x = isDarkTheme * -0.5 + 1.0;
    u_xlat16_6.xyz = u_xlat16_14.xxx * skyColor.xyz;
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, float3(6.0, 6.0, 6.0));
    u_xlat3.x = dot(u_xlat16_6.xyz, float3(0.330000013, 0.330000013, 0.330000013));
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + u_xlat3.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * float3(0.5, 0.5, 0.5) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat3.xxx) + u_xlat16_6.xyz;
    u_xlat16_14.x = skyTime * 2.0 + -1.0;
    u_xlat16_6.xyz = abs(u_xlat16_14.xxx) * u_xlat16_6.xyz + u_xlat3.xxx;
    outputColor.xyz = u_xlat16_6.xyz * u_xlat16_0.xxx + u_xlat16_5.xyz;
    u_xlat16_0.x = input.vs_TEXCOORD2.y * 0.100000001;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_14.x = u_xlat16_0.x * u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_7.x * u_xlat16_0.x + 0.200000003;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_14.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    outputColor.w = u_xlat16_0.x * densitySkySystem;
    return outputColor;

return outputColor;
}
ENDCG
}}}
