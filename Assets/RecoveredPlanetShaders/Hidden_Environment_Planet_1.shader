Shader "Recovered/Hidden/Environment/Planet/Variant1" {
Properties {

_MainTex ("Texture", 2D) = "white" { }

ratio ("ratio", Range(0, 1)) = 1.0

}
SubShader {
Tags {"RenderType"="Transparent" "Queue"="Transparent"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend SrcAlpha One, SrcAlpha One
ZWrite Off
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile_instancing
#include "UnityCG.cginc"
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float ratio;
Texture2D<float4> _MainTex; SamplerState sampler_MainTex;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
};
Varyings vert(AppData input, uint instanceID:SV_InstanceID) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;

    output.vs_TEXCOORD0.xy = input.in_POSITION0.xy + float2(0.5, 0.5);
    u_xlat0 = input.in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * input.in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * input.in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    output.position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float4 u_xlat16_0;

    u_xlat16_0 = _MainTex.Sample(sampler_MainTex, input.vs_TEXCOORD0.xy);
    outputColor.w = u_xlat16_0.w * ratio;
    outputColor.xyz = u_xlat16_0.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
