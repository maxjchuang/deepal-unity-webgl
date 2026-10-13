Shader "Recovered/Hidden/InteriorUI/Variant1" {
Properties {

[NoScaleOffset] texSeats ("texSeats", 2D) = "white" { }

[NoScaleOffset] texMask ("texMask", 2D) = "white" { }

ratio ("ratio", Range(0, 1)) = 0.0

color0 ("color0", Color) = (1,1,1,1)

color1 ("color1", Color) = (1,1,1,1)

color2 ("color2", Color) = (1,1,1,1)

}
SubShader {
Tags {"Queue"="Overlay" "RenderType"="Transparent"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
ZWrite Off
ZTest Off
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float values[7];
float isDarkTheme;
float ratio;
float4 color0;
float4 color1;
float4 color2;
sampler2D texSeats;
sampler2D texMask;
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
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);float4 ImmCB_0[4];
float4 u_xlat16_0;
float4 u_xlat10_0;
bool u_xlatb0;
float4 u_xlat16_1;
bool u_xlatb2;
float3 u_xlat16_3;
float3 u_xlat16_4;
float3 u_xlat16_5;
float2 u_xlat16_6;
float4 u_xlat16_7;
float u_xlat16_9;
float2 u_xlat16_10;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
float u_xlat16_25;
float u_xlat16_27;

ImmCB_0[0] = float4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = float4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = float4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = float4(0.0,0.0,0.0,1.0);
    u_xlatb0 = abs(values[0])>=0.100000001;
    u_xlat16_1.x = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_1.x = abs(values[0]) * 0.100000001 + u_xlat16_1.x;
    u_xlat10_0 = tex2D(texMask, input.vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat16_9 = u_xlat16_1.x * 0.699999988;
    u_xlatb24 = 0.0<values[0];
    u_xlatb2 = float4(0.0, 0.0, 0.0, 0.0)!=float4(isDarkTheme,isDarkTheme,isDarkTheme,isDarkTheme);
    u_xlat16_3.xyz = (bool(u_xlatb2)) ? color2.xyz : color1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb24)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_10.xy = tex2D(texSeats, input.vs_TEXCOORD0.xy).xy;
    u_xlati24 = u_xlatb2 ? 1 : int(0);
    u_xlat24 = dot(u_xlat16_10.xy, ImmCB_0[u_xlati24].xy);
    u_xlat16_5.xyz = (-float3(u_xlat24,u_xlat24,u_xlat24)) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + float3(-1.0, -1.0, -1.0);
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_4.xyz + float3(u_xlat24,u_xlat24,u_xlat24);
    u_xlat16_4.xyz = float3(u_xlat16_9,u_xlat16_9,u_xlat16_9) * u_xlat16_5.xyz + float3(u_xlat24,u_xlat24,u_xlat24);
    u_xlat16_1.xyz = (bool(u_xlatb2)) ? u_xlat16_4.xyz : u_xlat16_1.xzw;
    u_xlat16_1.xyz = (-float3(u_xlat24,u_xlat24,u_xlat24)) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * float3(0.699999988, 0.699999988, 0.699999988) + float3(u_xlat24,u_xlat24,u_xlat24);
    u_xlatb24 = 0.0<values[1];
    u_xlat16_4.xyz = (bool(u_xlatb24)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + float3(-1.0, -1.0, -1.0);
    u_xlatb24 = abs(values[1])>=0.100000001;
    u_xlat16_25 = (u_xlatb24) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[1]) * 0.100000001 + u_xlat16_25;
    u_xlatb24 = input.vs_TEXCOORD0.x<0.5;
    u_xlat16_6.xy = (bool(u_xlatb24)) ? float2(1.0, 0.0) : float2(0.0, 1.0);
    u_xlat16_7 = u_xlat10_0.xxyy * u_xlat16_6.xyxy;
    u_xlat16_6.xy = u_xlat10_0.zz * u_xlat16_6.xy;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_7.x;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = float3(u_xlat16_25,u_xlat16_25,u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * float3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[2];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + float3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[2])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[2]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_7.y * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = float3(u_xlat16_25,u_xlat16_25,u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * float3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[3];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + float3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[3])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[3]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_7.z * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = float3(u_xlat16_25,u_xlat16_25,u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * float3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[4];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + float3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[4])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[4]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_7.w * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = float3(u_xlat16_25,u_xlat16_25,u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * float3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[5];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + float3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[5])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[5]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_6.x * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = float3(u_xlat16_25,u_xlat16_25,u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * float3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[6];
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * float3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + float3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[6])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[6]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_6.y * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_3.xyz = float3(u_xlat16_25,u_xlat16_25,u_xlat16_25) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = float3(u_xlat16_27,u_xlat16_27,u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb2)) ? u_xlat16_4.xyz : u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * float3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.w = log2(ratio);
    u_xlat16_0 = u_xlat16_0 * float4(2.20000005, 2.20000005, 2.20000005, 2.20000005);
    outputColor = exp2(u_xlat16_0);
    return outputColor;

return outputColor;
}
ENDCG
}}}
