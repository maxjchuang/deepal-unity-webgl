Shader "Recovered/Hidden/BG_Blank/Variant1" {
Properties {

radius ("Radius", Float) = 30.0

height ("Height", Float) = 30.0

ratio ("ratio", Range(0, 1)) = 1.0

[HDR] _Color ("Color", Color) = (1,1,1,1)

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
float3 _Color;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
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
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);


    outputColor = float4(_Color.x, _Color.y, _Color.z, ratio);
    return outputColor;

return outputColor;
}
ENDCG
}}}
