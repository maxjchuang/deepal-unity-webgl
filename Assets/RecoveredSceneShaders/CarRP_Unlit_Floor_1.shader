Shader "Recovered/CarRP/Unlit/Floor/Variant1" {
Properties {

[HDR] _BaseColor ("Base Color", Color) = (0.5,0.5,0.5,1)

}
SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
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
float skyRadius;
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
float skyTime;
float4 colorSun;
float2 paramY;
float3 colorBGDefault;
float3 colorBGCarCenter;
float ratioCarCenter;
float4 _BaseColor;
sampler2D skyTex;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
float3 in_NORMAL0:NORMAL0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD1:TEXCOORD0;
float4 vs_TEXCOORD2:TEXCOORD1;
float2 vs_TEXCOORD0:TEXCOORD2;
float3 vs_NORMAL0:TEXCOORD3;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float2 u_xlat16_0;
float4 u_xlat1;
float u_xlat16_2;
float u_xlat3;

    u_xlat16_0.x = dot(_WorldSpaceCameraPos.xz, _WorldSpaceCameraPos.xz);
    u_xlat16_2 = rsqrt(u_xlat16_0.x);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, skyRadius);
    u_xlat1.x = u_xlat16_0.x + (-skyRadius);
    u_xlat16_0.xy = float2(u_xlat16_2,u_xlat16_2) * _WorldSpaceCameraPos.xz;
    u_xlat3 = dot(u_xlat16_0.xy, input.in_POSITION0.xz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat1.x = u_xlat3 * u_xlat1.x + skyRadius;
    u_xlat1.xyz = u_xlat1.xxx * input.in_POSITION0.xyz;
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
    output.vs_NORMAL0.xyz = input.in_NORMAL0.xyz;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat0;
float3 u_xlat1;
float4 u_xlat16_2;
float3 u_xlat16_3;
float3 u_xlat4;
float u_xlat16_6;
float u_xlat8;
float u_xlat16_10;
float u_xlat12;

    u_xlat0.xyz = input.vs_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = rsqrt(u_xlat12);
    u_xlat0.xyz = float3(u_xlat12,u_xlat12,u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(input.vs_TEXCOORD1.xyz, input.vs_TEXCOORD1.xyz);
    u_xlat1.x = rsqrt(u_xlat12);
    u_xlat4.z = sqrt(u_xlat12);
    u_xlat1.xyz = u_xlat1.xxx * input.vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = (-u_xlat4.z) + skyRadius;
    u_xlat4.xy = u_xlat4.xz / float2(skyRadius,skyRadius);
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
    u_xlat8 = (-u_xlat4.y) + 1.0;
    u_xlat16_2.x = u_xlat8 * 0.400000006;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.z = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat4.x = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.899999976 + 0.100000001;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.100000001;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_3.x = 0.649999976;
    u_xlat16_3.y = skyTime;
    u_xlat16_3.xyz = tex2D(skyTex, u_xlat16_3.xy).xyz;
    u_xlat4.x = dot(u_xlat16_3.xyz, float3(0.300000012, 0.5, 0.200000003));
    u_xlat4.xyz = (-u_xlat16_3.xyz) + u_xlat4.xxx;
    u_xlat4.xyz = u_xlat4.xyz * float3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-_BaseColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _BaseColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * float3(0.699999988, 0.699999988, 0.699999988);
    u_xlat0.xyz = (-u_xlat0.xyz) * float3(0.699999988, 0.699999988, 0.699999988) + colorSun.xyz;
    u_xlat16_2.xy = input.vs_TEXCOORD2.xy / input.vs_TEXCOORD2.ww;
    u_xlat16_2.xz = u_xlat16_2.xz * float2(0.5, 6.5) + float2(-0.5, -0.100000001);
    u_xlat16_2.x = dot(u_xlat16_2.xz, u_xlat16_2.xz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * colorSun.w;
    u_xlat16_10 = skyTime * 2.0 + -1.0;
    u_xlat16_10 = abs(u_xlat16_10) * 0.075000003 + 0.075000003;
    u_xlat12 = u_xlat16_10 * u_xlat16_2.x;
    u_xlat0.xyz = float3(u_xlat12,u_xlat12,u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat16_2.xzw = (-colorBGDefault.xyz) + colorBGCarCenter.xyz;
    u_xlat16_2.xzw = float3(float3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_2.xzw + colorBGDefault.xyz;
    u_xlat16_2.xzw = (-u_xlat0.xyz) + u_xlat16_2.xzw;
    u_xlat16_3.x = paramY.xxxy.z + -0.699999988;
    u_xlat12 = u_xlat16_3.x * -0.5;
    u_xlat12 = u_xlat16_2.y * paramY.xxxy.z + u_xlat12;
    u_xlat12 = paramY.xxxy.z * paramY.xxxy.w + u_xlat12;
    u_xlat16_6 = ratioCarCenter * ratioCarCenter;
    u_xlat16_6 = u_xlat16_6 * 1.80000007 + -0.200000003;
    u_xlat16_3.x = ratioCarCenter * -1.50000012 + 3.4000001;
    u_xlat16_6 = u_xlat12 * u_xlat16_3.x + u_xlat16_6;
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_3.x = u_xlat16_6 * u_xlat16_6;
    u_xlat16_6 = (-u_xlat16_6) * 2.0 + 3.0;
    u_xlat16_6 = u_xlat16_6 * u_xlat16_3.x;
    outputColor.xyz = float3(u_xlat16_6,u_xlat16_6,u_xlat16_6) * u_xlat16_2.xzw + u_xlat0.xyz;
    outputColor.w = 1.0;
    return outputColor;

return outputColor;
}
ENDCG
}}}
