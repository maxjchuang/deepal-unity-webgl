Shader "Recovered/Hidden/BG_EnergyCenter/Variant1" {
Properties {

radius ("Radius", Float) = 30.0

height ("Height", Float) = 30.0

ratio ("ratio", Range(0, 1)) = 1.0

[HDR] _Color0 ("Color0", Color) = (1,1,1,1)

[HDR] _Color1 ("Color1", Color) = (1,1,1,1)

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
float radius;
float height;
float ratio;
float3 _Color0;
float3 _Color1;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float2 u_xlat16_0;
float2 u_xlat1;
float u_xlat16_2;
float u_xlat3;
float u_xlat5;

    u_xlat16_0.x = dot(_WorldSpaceCameraPos.xz, _WorldSpaceCameraPos.xz);
    u_xlat16_2 = rsqrt(u_xlat16_0.x);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat1.x = max(u_xlat16_0.x, radius);
    u_xlat1.x = u_xlat1.x + (-radius);
    u_xlat16_0.xy = float2(u_xlat16_2,u_xlat16_2) * _WorldSpaceCameraPos.xz;
    u_xlat3 = dot(u_xlat16_0.xy, input.in_POSITION0.xz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat1.x = u_xlat3 * u_xlat1.x + radius;
    u_xlat1.xy = u_xlat1.xx * input.in_POSITION0.xz;
    u_xlat5 = input.in_POSITION0.y * height;
    u_xlat0 = float4(u_xlat5,u_xlat5,u_xlat5,u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat0;
    output.position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    output.vs_TEXCOORD0.xy = input.in_TEXCOORD0.xy;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float u_xlat16_0;
float3 u_xlat16_1;

    u_xlat16_0 = input.vs_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_0 = (-u_xlat16_0) * u_xlat16_0 + 1.0;
    u_xlat16_1.xyz = (-float3(_Color0.x, _Color0.y, _Color0.z)) + _Color1.xyz;
    outputColor.xyz = float3(u_xlat16_0,u_xlat16_0,u_xlat16_0) * u_xlat16_1.xyz + float3(_Color0.x, _Color0.y, _Color0.z);
    outputColor.w = ratio;
    return outputColor;

return outputColor;
}
ENDCG
}}}
