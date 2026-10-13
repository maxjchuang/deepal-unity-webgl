Shader "Recovered/Hidden/Star/Variant1" {
Properties {

radius ("Radius", Float) = 30.0

_Color ("_Color", Color) = (1,1,1,1)

_Size0 ("Size", Float) = 1.0

_Size1 ("Size", Float) = 1.0

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
#define hlslcc_mtx4x4glstate_matrix_projection transpose(UNITY_MATRIX_P)
#define hlslcc_mtx4x4unity_MatrixV transpose(UNITY_MATRIX_V)
float time;
float4 _Color;
float _Size0;
float _Size1;
float ratio;
float radius;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
float vs_TEXCOORD1:TEXCOORD1;
};
Varyings vert(AppData input, uint instanceID:SV_InstanceID) { Varyings output;
float4 phase0_Output0_0;
float4 u_xlat0;
float4 u_xlat16_0;
float4 u_xlat1;
float4 u_xlat2;
float3 u_xlat3;
float3 u_xlat16_4;
float u_xlat15;

    u_xlat0.x = float(uint(instanceID));
    u_xlat0 = u_xlat0.xxxx * float4(0.0973000005, 0.103, 0.109899998, 0.103100002);
    u_xlat0 = frac(u_xlat0);
    u_xlat1 = u_xlat0.zxwy + float4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat1.x = dot(u_xlat0.wyxz, u_xlat1);
    u_xlat0 = u_xlat0 + u_xlat1.xxxx;
    u_xlat1 = u_xlat0.yxxz + u_xlat0.wwyx;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat0 = frac(u_xlat0);
    u_xlat1.x = dot(float2(time,time), u_xlat0.zz);
    u_xlat15 = u_xlat0.w * 6.28318548 + u_xlat1.x;
    u_xlat15 = cos(u_xlat15);
    u_xlat15 = u_xlat15 * 0.400000006 + 0.600000024;
    u_xlat1.z = u_xlat15 * ratio;
    u_xlat1.xy = input.in_POSITION0.xy + float2(0.5, 0.5);
    phase0_Output0_0.xyz = u_xlat1.xyz;
    u_xlat0.y = sqrt(u_xlat0.y);
    u_xlat0.xy = u_xlat0.xy * float2(6.28318548, 1.57079637);
    u_xlat1.x = sin(u_xlat0.y);
    u_xlat2.x = cos(u_xlat0.y);
    u_xlat3.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.z = u_xlat0.x;
    u_xlat1.xz = u_xlat1.xx * u_xlat3.xz;
    u_xlat1.y = u_xlat2.x;
    u_xlat0.xyw = u_xlat1.xyz * float3(float3(radius, radius, radius));
    u_xlat16_4.x = u_xlat0.y * 0.5 + 1.0;
    u_xlat1.xyz = u_xlat16_4.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xyw = u_xlat0.xyw + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat16_4.x = (-_Size0) + _Size1;
    u_xlat16_4.x = u_xlat0.z * u_xlat16_4.x + _Size0;
    u_xlat16_4.xy = u_xlat16_4.xx * input.in_POSITION0.xy;
    u_xlat16_4.z = 0.0;
    u_xlat16_0.xyz = u_xlat0.xyw + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_0.xz;
    u_xlat1.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat1.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat1.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    u_xlat16_4.z = 1.0;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xy = u_xlat16_0.yz;
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat2.zw = hlslcc_mtx4x4glstate_matrix_projection[3].yz;
    u_xlat16_4.z = 1.0;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    u_xlat16_0.w = 1.0;
    u_xlat1.z = dot(u_xlat2, u_xlat16_0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    u_xlat1.w = dot(u_xlat2.xy, u_xlat16_0.zw);
    output.position = u_xlat1;
output.vs_TEXCOORD0 = phase0_Output0_0.xy;
output.vs_TEXCOORD1 = phase0_Output0_0.z;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float2 u_xlat16_0;

    u_xlat16_0.xy = input.vs_TEXCOORD0.xy + float2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * input.vs_TEXCOORD1;
    outputColor.w = u_xlat16_0.x * _Color.w;
    outputColor.xyz = _Color.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
