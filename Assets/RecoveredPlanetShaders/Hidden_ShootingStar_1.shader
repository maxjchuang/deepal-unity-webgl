Shader "Recovered/Hidden/ShootingStar/Variant1" {
Properties {

radius ("Radius", Float) = 30.0

_Color ("_Color", Color) = (1,1,1,1)

sizeX ("SizeX", Float) = 0.009999999776482582

sizeY ("SizeY", Float) = 0.05000000074505806

ratio ("ratio", Range(0, 1)) = 1.0

}
SubShader {
Tags {"RenderType"="Transparent" "Queue"="Transparent"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Off
Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
ZWrite Off
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile_instancing
#include "UnityCG.cginc"
float angleShootingStars[3];
float timeShootingStar;
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
float4 _Color;
float ratio;
float radius;
float sizeX;
float sizeY;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
float vs_TEXCOORD1:TEXCOORD1;
};
Varyings vert(AppData input, uint instanceID:SV_InstanceID) { Varyings output;
float4 u_xlat0;
float3 u_xlat16_0;
float4 u_xlat1;
int u_xlati1;
float3 u_xlat16_2;
float3 u_xlat16_3;
float3 u_xlat16_4;
float3 u_xlat16_5;
float3 u_xlat16_6;
float u_xlat7;
float u_xlat16_18;
float u_xlat16_20;

    u_xlat16_0.x = timeShootingStar * 3.14159274;
    u_xlat16_0.x = sin(u_xlat16_0.x);
    output.vs_TEXCOORD1 = u_xlat16_0.x * ratio;
    output.vs_TEXCOORD0.xy = input.in_POSITION0.xy + float2(0.5, 0.5);
    u_xlat1.x = float(uint(instanceID));
    u_xlat1.x = u_xlat1.x * 0.103100002;
    u_xlat1.x = frac(u_xlat1.x);
    u_xlat7 = u_xlat1.x + 33.3300018;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat1.x = dot(u_xlat1.xx, u_xlat1.xx);
    u_xlat1.x = frac(u_xlat1.x);
    u_xlat16_0.x = u_xlat1.x * 0.200000003;
    u_xlat16_0.x = timeShootingStar * timeShootingStar + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_2.y = 0.660000026;
    u_xlati1 = instanceID;
    u_xlat16_3.x = sin(angleShootingStars[u_xlati1]);
    u_xlat16_2.x = cos(angleShootingStars[u_xlati1]);
    u_xlat16_6.x = 1.0 + angleShootingStars[u_xlati1];
    u_xlat16_4.x = sin(u_xlat16_6.x);
    u_xlat16_5.x = cos(u_xlat16_6.x);
    u_xlat16_2.z = u_xlat16_3.x;
    u_xlat16_6.xyz = u_xlat16_2.xyz * float3(float3(radius, radius, radius));
    u_xlat16_5.y = 0.159999996;
    u_xlat16_5.z = u_xlat16_4.x;
    u_xlat16_2.xyz = u_xlat16_5.xyz * float3(float3(radius, radius, radius)) + (-u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.zxy) + _WorldSpaceCameraPos.zxy;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = rsqrt(u_xlat16_18);
    u_xlat16_3.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_18 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_18 = rsqrt(u_xlat16_18);
    u_xlat16_2.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.yzx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.zxy * u_xlat16_2.zxy + (-u_xlat16_4.xyz);
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = rsqrt(u_xlat16_18);
    u_xlat16_3.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * float3(float3(sizeX, sizeX, sizeX));
    u_xlat16_3.xyz = u_xlat16_3.xyz * input.in_POSITION0.xxx;
    u_xlat16_18 = input.in_POSITION0.y + 0.5;
    u_xlat16_20 = u_xlat16_18 * sizeY;
    u_xlat16_18 = (-u_xlat16_18) + 2.0;
    u_xlat16_0.xyz = u_xlat16_2.xyz * float3(u_xlat16_20,u_xlat16_20,u_xlat16_20) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat16_0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat16_0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    output.position = u_xlat0;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float u_xlat16_0;

    u_xlat16_0 = input.vs_TEXCOORD0.y * input.vs_TEXCOORD0.y;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * input.vs_TEXCOORD1;
    outputColor.w = u_xlat16_0 * _Color.w;
    outputColor.xyz = _Color.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
