Shader "Recovered/Hidden/Sky/Variant1" {
Properties {

_MainTex ("Texture", 2D) = "white" { }

}
SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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
float isDarkTheme;
float4 colorSun;
sampler2D skyTex;
sampler2D _MainTex;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD0:TEXCOORD0;
float2 vs_TEXCOORD1:TEXCOORD1;
float4 vs_TEXCOORD3:TEXCOORD2;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;
float u_xlat2;

    u_xlat0.xyz = input.in_POSITION0.xyz * float3(skyRadius,skyRadius,skyRadius);
    output.vs_TEXCOORD0.xyz = u_xlat0.xyz;
    output.vs_TEXCOORD1.xy = input.in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.z = max(u_xlat0.z, 0.00100000005);
    output.position = u_xlat0;
    output.vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * float2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    output.vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float2 u_xlat16_0;
float u_xlat1;
float4 u_xlat16_2;
float4 u_xlat16_3;
float4 u_xlat16_4;
float2 u_xlat16_5;
float3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
float u_xlat16_8;
float u_xlat16_14;
float u_xlat16_20;

    u_xlat16_0.x = input.vs_TEXCOORD3.x / input.vs_TEXCOORD3.w;
    u_xlat16_0.y = input.vs_TEXCOORD1.y;
    u_xlat16_0.xy = u_xlat16_0.xy * float2(0.5, 6.5) + float2(-0.5, -0.100000001);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * colorSun.w;
    u_xlat1 = input.vs_TEXCOORD3.x / input.vs_TEXCOORD3.w;
    u_xlat1 = u_xlat1 * 3.14159274;
    u_xlat1 = sin(u_xlat1);
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = u_xlat1 * 0.100000024 + 1.0;
    u_xlat7 = log2(abs(input.vs_TEXCOORD1.y));
    u_xlat1 = u_xlat7 * u_xlat1;
    u_xlat1 = exp2(u_xlat1);
    u_xlat16_6.x = u_xlat1 * 4.80000019;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_2.x = (-u_xlat16_6.x) + 1.0;
    u_xlatb7 = 0.0392156877<input.vs_TEXCOORD1.y;
    if(u_xlatb7){
        u_xlat16_2.y = skyTime;
        u_xlat16_6.xyz = tex2D(skyTex, u_xlat16_2.xy).xyz;
    } else {
        u_xlat16_8 = input.vs_TEXCOORD1.x * 1.99899995;
        u_xlat16_3.x = frac(u_xlat16_8);
        u_xlat16_8 = input.vs_TEXCOORD1.y * 12.75 + 0.5;
        u_xlatb7 = 0.500100017<input.vs_TEXCOORD1.x;
        u_xlat16_14 = (-u_xlat16_8) + 1.0;
        u_xlat16_3.y = (u_xlatb7) ? u_xlat16_14 : u_xlat16_8;
        u_xlat16_4 = tex2D(_MainTex, u_xlat16_3.xy);
        u_xlat16_8 = u_xlat16_4.w + u_xlat16_4.w;
        u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
        u_xlat16_14 = u_xlat16_8 * -0.350000024 + 1.0;
        u_xlat16_5.x = u_xlat16_14 * u_xlat16_2.x;
        u_xlat16_5.y = skyTime;
        u_xlat16_2.xzw = tex2D(skyTex, u_xlat16_5.xy).xyz;
        u_xlat16_3.x = dot(u_xlat16_2.xzw, float3(0.300000012, 0.5, 0.200000003));
        u_xlat16_3.xzw = (-u_xlat16_2.xzw) + u_xlat16_3.xxx;
        u_xlat16_3.xzw = u_xlat16_3.xzw * float3(0.5, 0.5, 0.5) + u_xlat16_2.xzw;
        u_xlat16_3.xzw = u_xlat16_3.xzw * float3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_2.xzw);
        u_xlat16_2.xyz = float3(u_xlat16_8,u_xlat16_8,u_xlat16_8) * u_xlat16_3.xzw + u_xlat16_2.xzw;
        u_xlat16_20 = log2(abs(u_xlat16_4.w));
        u_xlat16_20 = u_xlat16_20 * 0.699999988;
        u_xlat16_20 = exp2(u_xlat16_20);
        u_xlat1 = u_xlat1 * 15.0;
        u_xlat1 = min(u_xlat1, 1.0);
        u_xlat1 = (-u_xlat1) + 1.0;
        u_xlat1 = (-u_xlat1) * u_xlat1 + 1.0;
        u_xlat1 = (-u_xlat16_20) * u_xlat1 + 1.0;
        u_xlat16_20 = (-u_xlat16_4.w) + 1.0;
        u_xlat16_3.x = skyTime * 2.0 + -1.0;
        u_xlat16_3.x = abs(u_xlat16_3.x) * 0.0900000036 + 0.0599999987;
        u_xlat16_3.x = u_xlat16_4.w * u_xlat16_3.x;
        u_xlat16_3.x = u_xlat1 * u_xlat16_3.x;
        u_xlat16_20 = u_xlat16_20 * u_xlat16_20 + u_xlat16_3.x;
        u_xlat16_0.x = u_xlat16_0.x * u_xlat16_20;
        u_xlat16_2.xyz = (-u_xlat16_4.xyz) + u_xlat16_2.xyz;
        u_xlat16_2.xyz = float3(u_xlat1,u_xlat1,u_xlat1) * u_xlat16_2.xyz + u_xlat16_4.xyz;
        u_xlat16_20 = u_xlat16_3.y * 2.0 + -1.0;
        u_xlat16_20 = min(abs(u_xlat16_20), 1.0);
        u_xlat16_20 = u_xlat16_20 + -1.0;
        u_xlat16_20 = isDarkTheme * u_xlat16_20 + 1.0;
        u_xlat16_3.xyz = float3(u_xlat16_20,u_xlat16_20,u_xlat16_20) * u_xlat16_2.xyz;
        u_xlat16_3.xyz = u_xlat16_3.xyz * float3(0.399999976, 0.399999976, 0.399999976);
        u_xlat16_6.xyz = u_xlat16_2.xyz * float3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_3.xyz;
    }
    u_xlat16_2.xyz = (-u_xlat16_6.xyz) + colorSun.xyz;
    outputColor.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    outputColor.w = 1.0;
    return outputColor;

return outputColor;
}
ENDCG
}}}
