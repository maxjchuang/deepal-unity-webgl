Shader "Recovered/CarRP/Unlit/Shadow/Variant1" {
Properties {
_Color ("_Color", Color) = (1,1,1,1)
_MainTex ("Texture", 2D) = "white" { }
_Pow ("Pow", Float) = 1.5
_Scale ("Scale", Float) = 1.0
}

SubShader {
Tags {"IGNOREPROJECTOR"="true" "Queue"="Transparent-1" "RenderType"="CarShadow"}
Pass {Tags {"IGNOREPROJECTOR"="true" "LightMode"="ForwardBase" "Queue"="Transparent-1" "RenderType"="CarShadow"}
Cull Back
Blend SrcAlpha OneMinusSrcAlpha, One One
ZWrite Off
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float4 _Color;
float _Pow;
float _Scale;
sampler2D _MainTex;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;

    output.vs_TEXCOORD0.xy = input.in_TEXCOORD0.xy;
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
float4 u_xlat0;
float u_xlat16_0;

    u_xlat16_0 = tex2D(_MainTex, input.vs_TEXCOORD0.xy).x;
    u_xlat0.x = u_xlat16_0 * _Scale;
    u_xlat0.x = log2(abs(u_xlat0.x));
    u_xlat0.x = u_xlat0.x * _Pow;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.w = u_xlat0.x * _Color.w;
    u_xlat0.xyz = _Color.xyz;
    outputColor = u_xlat0;
    return outputColor;

return outputColor;
}
ENDCG
}}}
