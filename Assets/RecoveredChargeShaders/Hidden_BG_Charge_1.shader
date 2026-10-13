Shader "Recovered/Hidden/BG_Charge/Variant1" {
Properties {

radius ("Radius", Float) = 30.0

value ("value", Range(0, 1)) = 0.0

height ("Height", Float) = 30.0

ratio ("ratio", Range(0, 1)) = 1.0

_MainTex ("BG", 2D) = "white" { }

texDots ("Dots", 2D) = "black" { }

[HDR] _Color ("Color", Color) = (1,1,1,1)

[HDR] _ColorBackLight ("ColorBackLight", Color) = (1,1,1,1)

}
SubShader {
Tags {"IsEmissive"="true" "Queue"="Geometry-10" "RenderType"="Opaque"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend SrcAlpha OneMinusSrcAlpha, Zero Zero
ZWrite Off
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float radius;
float height;
float ratio;
float value;
float3 _Color;
float3 _ColorBackLight;
float2 paramY;
float3 colorBGDefault;
float3 colorBGCarCenter;
float ratioCarCenter;
sampler2D _MainTex;
sampler2D texDots;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD1:TEXCOORD0;
float4 vs_TEXCOORD2:TEXCOORD1;
float2 vs_TEXCOORD0:TEXCOORD2;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float2 u_xlat16_0;
float4 u_xlat1;
float3 u_xlat2;
float u_xlat16_3;
float u_xlat4;
float u_xlat7;

    u_xlat16_0.x = dot(_WorldSpaceCameraPos.xz, _WorldSpaceCameraPos.xz);
    u_xlat16_3 = rsqrt(u_xlat16_0.x);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat1.x = max(u_xlat16_0.x, radius);
    u_xlat1.x = u_xlat1.x + (-radius);
    u_xlat16_0.xy = float2(u_xlat16_3,u_xlat16_3) * _WorldSpaceCameraPos.xz;
    u_xlat4 = dot(u_xlat16_0.xy, input.in_POSITION0.xz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat1.x = u_xlat4 * u_xlat1.x + radius;
    u_xlat1.xy = u_xlat1.xx * input.in_POSITION0.xz;
    u_xlat7 = input.in_POSITION0.y * height;
    u_xlat2.xyz = float3(u_xlat7,u_xlat7,u_xlat7) * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xzw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.yyy + u_xlat1.xzw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    output.vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    output.position = u_xlat0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * float2(0.5, 0.5);
    output.vs_TEXCOORD2.zw = u_xlat0.zw;
    output.vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    output.vs_TEXCOORD0.xy = input.in_TEXCOORD0.xy;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float4 u_xlat0;
float3 u_xlat16_1;
float4 u_xlat2;
float3 u_xlat16_3;
float3 u_xlat16_5;
float u_xlat6;
float2 u_xlat16_9;
float u_xlat16_13;
float u_xlat16_15;

    u_xlat0.x = input.vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = abs(u_xlat0.x) + abs(u_xlat0.x);
    u_xlat0.y = input.vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat0.xy + float2(-0.5, -0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * 3.5999999;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = (-value) * 1.60000002 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * 1.66666663 + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_9.x = (-u_xlat0.x) * 2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_9.x * u_xlat16_5.x;
    u_xlat0.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat2.xy = input.vs_TEXCOORD2.xy / input.vs_TEXCOORD2.ww;
    u_xlat2.w = u_xlat0.x * u_xlat2.y;
    u_xlat0.xy = u_xlat2.xw * float2(26.0, 26.0);
    u_xlat16_5.y = tex2D(texDots, u_xlat0.xy).x;
    u_xlat16_13 = value * 3.14159274;
    u_xlat16_5.z = sin(u_xlat16_13);
    u_xlat16_5.xz = u_xlat16_5.yz * u_xlat16_5.xz;
    u_xlat16_9.x = u_xlat16_5.y * u_xlat16_5.z;
    u_xlat16_9.x = u_xlat16_9.x * 0.0299999993;
    u_xlat0.x = input.vs_TEXCOORD0.y * 2.0 + -0.860000014;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat0.x + u_xlat16_9.x;
    u_xlat16_9.xy = u_xlat0.xx * float2(2.5, 3.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_3.xyz = u_xlat16_1.xxx * _Color.xyz;
    u_xlat0.yw = u_xlat16_9.xx;
    u_xlat16_1.x = min(u_xlat16_9.y, 1.0);
    u_xlat6 = u_xlat2.x + -0.5;
    u_xlat0.x = u_xlat6 * 1.39999998;
    u_xlat0.z = u_xlat0.x;
    u_xlat16_5.x = dot(u_xlat0.xy, u_xlat0.zw);
    u_xlat16_5.x = sqrt(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_1.y = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.xz = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.x = u_xlat16_1.z * u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ColorBackLight.xyz + u_xlat16_3.xyz;
    u_xlat2.z = input.vs_TEXCOORD0.y;
    u_xlat16_3.xyz = tex2D(_MainTex, u_xlat2.xz).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-colorBGDefault.xyz) + colorBGCarCenter.xyz;
    u_xlat16_3.xyz = float3(float3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_3.xyz + colorBGDefault.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_13 = paramY.x + -0.699999988;
    u_xlat0.x = u_xlat16_13 * -0.5;
    u_xlat16_13 = input.vs_TEXCOORD2.y / input.vs_TEXCOORD2.w;
    u_xlat0.x = u_xlat16_13 * paramY.x + u_xlat0.x;
    u_xlat0.x = paramY.x * paramY.y + u_xlat0.x;
    u_xlat16_13 = ratioCarCenter * ratioCarCenter;
    u_xlat16_13 = u_xlat16_13 * 1.80000007 + -0.200000003;
    u_xlat16_15 = ratioCarCenter * -1.50000012 + 3.4000001;
    u_xlat16_13 = u_xlat0.x * u_xlat16_15 + u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_15 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = (-u_xlat16_13) * 2.0 + 3.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_15;
    outputColor.xyz = float3(u_xlat16_13,u_xlat16_13,u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    outputColor.w = ratio;
    return outputColor;

return outputColor;
}
ENDCG
}}}
