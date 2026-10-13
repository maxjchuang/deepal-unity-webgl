Shader "Recovered/Hidden/BG_CarCenter/Variant1" {
Properties {

radius ("Radius", Float) = 30.0

height ("Height", Float) = 30.0

ratio ("ratio", Range(0, 1)) = 1.0

}
SubShader {
Tags {"IsEmissive"="true" "Queue"="Geometry+2" "RenderType"="Opaque"}
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
float2 paramY;
float3 colorBGDefault;
float3 colorBGCarCenter;
float ratioCarCenter;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
float4 vs_TEXCOORD2:TEXCOORD0;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float2 u_xlat16_0;
float4 u_xlat1;
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
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    output.position = u_xlat0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * float2(0.5, 0.5);
    output.vs_TEXCOORD2.zw = u_xlat0.zw;
    output.vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float u_xlat16_0;
float u_xlat1;
float3 u_xlat16_2;

    u_xlat16_0 = paramY.x + -0.699999988;
    u_xlat1 = u_xlat16_0 * -0.5;
    u_xlat16_0 = input.vs_TEXCOORD2.y / input.vs_TEXCOORD2.w;
    u_xlat1 = u_xlat16_0 * paramY.x + u_xlat1;
    u_xlat1 = paramY.x * paramY.y + u_xlat1;
    u_xlat16_0 = ratioCarCenter * ratioCarCenter;
    u_xlat16_0 = u_xlat16_0 * 1.80000007 + -0.200000003;
    u_xlat16_2.x = ratioCarCenter * -1.50000012 + 3.4000001;
    u_xlat16_0 = u_xlat1 * u_xlat16_2.x + u_xlat16_0;
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat16_2.x = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = (-u_xlat16_0) * 2.0 + 3.0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2.x;
    u_xlat16_2.xyz = (-colorBGDefault.xyz) + colorBGCarCenter.xyz;
    u_xlat16_2.xyz = float3(float3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_2.xyz + colorBGDefault.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-colorBGCarCenter.xyz);
    outputColor.xyz = float3(u_xlat16_0,u_xlat16_0,u_xlat16_0) * u_xlat16_2.xyz + colorBGCarCenter.xyz;
    outputColor.w = ratio;
    return outputColor;

return outputColor;
}
ENDCG
}}}
