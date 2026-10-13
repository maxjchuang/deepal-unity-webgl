Shader "Recovered/Hidden/Collision/Variant1" {
Properties {

[Toggle] fixMirror ("FixMirror", Float) = 0.0

[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2.0

}
SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull [_Cull]
Blend One Zero, One Zero
ZWrite On
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
#define hlslcc_mtx4x4unity_MatrixV transpose(UNITY_MATRIX_V)
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
float fixMirror;
struct AppData {
float4 in_POSITION0:POSITION0;
float3 in_NORMAL0:NORMAL0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_NORMAL0:TEXCOORD0;
float vs_TEXCOORD0:TEXCOORD1;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float u_xlat1;
float4 u_xlat2;
float u_xlat3;
float u_xlat4;

    u_xlat0 = input.in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * input.in_POSITION0.xxxx + u_xlat0;
    u_xlat1 = fixMirror * -2.0 + 1.0;
    u_xlat4 = u_xlat1 * input.in_POSITION0.z;
    u_xlat1 = u_xlat1 * input.in_NORMAL0.z;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * float4(u_xlat4,u_xlat4,u_xlat4,u_xlat4) + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    output.position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    output.vs_TEXCOORD0 = (-u_xlat0.x) * _ProjectionParams.w;
    u_xlat0.xyz = input.in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * input.in_NORMAL0.xxx + u_xlat0.xyz;
    output.vs_NORMAL0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * float3(u_xlat1,u_xlat1,u_xlat1) + u_xlat0.xyz;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat0;

    u_xlat0.x = dot(input.vs_NORMAL0.xyz, input.vs_NORMAL0.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * input.vs_NORMAL0.xyz;
    outputColor.xyz = u_xlat0.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
    outputColor.w = input.vs_TEXCOORD0;
    return outputColor;

return outputColor;
}
ENDCG
}}}
