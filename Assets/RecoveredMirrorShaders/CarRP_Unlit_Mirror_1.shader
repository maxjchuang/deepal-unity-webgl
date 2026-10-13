Shader "Recovered/CarRP/Unlit/Mirror/Variant1" {
Properties {
_Cull("Cull",Float)=2

ratio("Ratio",Float)=1
fixMirror("Mirror axis",Float)=0
}

SubShader {
Tags {"Queue"="Transparent+1" "RenderType"="Transparent"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull [_Cull]
Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
ZWrite Off
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#define hlslcc_mtx4x4glstate_matrix_projection transpose(UNITY_MATRIX_P)
#define hlslcc_mtx4x4unity_MatrixV transpose(UNITY_MATRIX_V)
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float ratio;
float fixMirror;
struct AppData {
float4 in_POSITION0:POSITION0;
float3 in_NORMAL0:NORMAL0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD0:TEXCOORD0;
float3 vs_TEXCOORD1:TEXCOORD1;
float3 vs_TEXCOORD2:TEXCOORD2;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;
float4 u_xlat2;
float u_xlat9;

    u_xlat0.xy = input.in_NORMAL0.xy;
    u_xlat1.xy = input.in_POSITION0.xy;
    u_xlat9 = fixMirror * -2.0 + 1.0;
    u_xlat1.z = u_xlat9 * input.in_POSITION0.z;
    u_xlat0.z = u_xlat9 * input.in_NORMAL0.z;
    u_xlat0.xyw = u_xlat0.xyz * float3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xyw = u_xlat0.xyw + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    output.vs_TEXCOORD0.xz = u_xlat0.xw;
    output.vs_TEXCOORD0.y = (-u_xlat0.y);
    u_xlat1 = (-u_xlat0.yyyy) * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyw = (-u_xlat0.xyw) + _WorldSpaceCameraPos.xyz;
    output.vs_TEXCOORD2.xyz = u_xlat0.xyw;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.xyw = u_xlat1.xzw + float3(0.0, 0.00100000005, 0.0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat2.zw = hlslcc_mtx4x4glstate_matrix_projection[3].xz;
    output.position.x = dot(u_xlat2.xyz, u_xlat0.xyw);
    u_xlat0.xyw = u_xlat1.yzw + float3(0.0, 0.00100000005, 0.0);
    u_xlat1 = u_xlat1 + float4(0.0, 0.0, 0.00100000005, 0.0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].y;
    output.position.y = dot(u_xlat2.xyz, u_xlat0.xyw);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    output.position.z = dot(u_xlat2, u_xlat1);
    u_xlat0.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat0.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    output.position.w = dot(u_xlat0.xy, u_xlat1.zw);
    u_xlat0.xyw = (-input.in_NORMAL0.yyy) * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * input.in_NORMAL0.xxx + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 1.17549435e-38);
    u_xlat9 = rsqrt(u_xlat9);
    u_xlat0.xyz = float3(u_xlat9,u_xlat9,u_xlat9) * u_xlat0.xyz;
    output.vs_TEXCOORD1.xyz = u_xlat0.xyz;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat16_0;
float3 u_xlat16_1;
float u_xlat16_2;
float u_xlat16_4;
float u_xlat16_6;

    u_xlat16_0.x = dot(input.vs_TEXCOORD2.xyz, input.vs_TEXCOORD2.xyz);
    u_xlat16_0.x = rsqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * input.vs_TEXCOORD2.xyz;
    u_xlat16_6 = dot(input.vs_TEXCOORD1.xyz, input.vs_TEXCOORD1.xyz);
    u_xlat16_6 = rsqrt(u_xlat16_6);
    u_xlat16_1.xyz = float3(u_xlat16_6,u_xlat16_6,u_xlat16_6) * input.vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_1.y * 0.800000012;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_4 = min(abs(input.vs_TEXCOORD0.y), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_6 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_4 = u_xlat16_6 * u_xlat16_4;
    u_xlat16_6 = u_xlat16_4 * 4.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_6 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_2 * u_xlat16_6 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat16_0.x = u_xlat16_0.x * ratio;
    outputColor.w = u_xlat16_0.x * 1.5;
    outputColor.w = clamp(outputColor.w, 0.0, 1.0);
    outputColor.xyz = float3(0.0, 0.0, 0.0);
    return outputColor;

return outputColor;
}
ENDCG
}}}
