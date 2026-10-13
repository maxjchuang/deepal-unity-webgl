Shader "Recovered/CarRP/Unlit/AirConditionApp/Variant1" {
Properties {

[NoScaleOffset] _MainTex ("Texture", 2D) = "white" { }

[HDR] _ColorBright0 ("Color Bright", Color) = (0,0,1,1)

[HDR] _ColorBright1 ("Color Bright", Color) = (1,0,0,1)

[HDR] _ColorDark0 ("Color Dark", Color) = (0,0,1,1)

[HDR] _ColorDark1 ("Color Dark", Color) = (1,0,0,1)

animSpeed ("AnimSpeed", Float) = 1.0

animShift ("AnimShift", Float) = 0.0

ratio ("ratio", Range(0, 1)) = 0.0

value ("value", Range(-1, 1)) = 0.0

}
SubShader {
Tags {"Queue"="Transparent" "RenderType"="Transparent"}
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
float isDarkTheme;
float4 _ColorBright0;
float4 _ColorBright1;
float4 _ColorDark0;
float4 _ColorDark1;
float animSpeed;
float ratio;
float value;
sampler2D _MainTex;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float3 vs_TEXCOORD0:TEXCOORD0;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
int u_xlati0;
float4 u_xlat1;
float4 u_xlat2;
float4 u_xlat3;
float4 u_xlat4;
float3 u_xlat5;
float3 u_xlat6;
float3 u_xlat7;
float4 u_xlat8;
float3 u_xlat9;
float3 u_xlat11;
float2 u_xlat18;
int u_xlati18;
bool u_xlatb18;
int u_xlati27;

    output.vs_TEXCOORD0.xy = input.in_TEXCOORD0.xy;
    output.vs_TEXCOORD0.z = 0.0;
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat9.xyz = input.in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * input.in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * input.in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat9.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.x = u_xlat1.x * 6.28318548 + (-u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat1.w = u_xlat0.x * 0.0199999996 + abs(u_xlat1.z);
    u_xlat0.xy = _Time.yy * float2(0.5, 0.5) + u_xlat1.xw;
    u_xlat18.x = dot(u_xlat0.xy, float2(0.366025418, 0.366025418));
    u_xlat18.xy = u_xlat18.xx + u_xlat0.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat2.xy = u_xlat18.xy * float2(0.00346020772, 0.00346020772);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) * float2(289.0, 289.0) + u_xlat18.xy;
    u_xlat0.xy = (-u_xlat18.xy) + u_xlat0.xy;
    u_xlat18.x = dot(u_xlat18.xy, float2(0.211324871, 0.211324871));
    u_xlat0.xy = u_xlat18.xx + u_xlat0.xy;
    u_xlatb18 = u_xlat0.x>=u_xlat0.y;
    u_xlat3.y = (u_xlatb18) ? 0.0 : 1.0;
    u_xlat3.x = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(1.0);
    u_xlat11.xyz = u_xlat2.yyy + u_xlat3.zyw;
    u_xlat4.xyz = u_xlat11.xyz * float3(34.0, 34.0, 34.0) + float3(1.0, 1.0, 1.0);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat11.xyz * float3(0.00346020772, 0.00346020772, 0.00346020772);
    u_xlat4.xyz = floor(u_xlat4.xyz);
    u_xlat11.xyz = (-u_xlat4.xyz) * float3(289.0, 289.0, 289.0) + u_xlat11.xyz;
    u_xlat2.xyz = u_xlat2.xxx + u_xlat11.xyz;
    u_xlat2.xyz = u_xlat3.zxw + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat2.xyz * float3(34.0, 34.0, 34.0) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xyz * float3(0.00346020772, 0.00346020772, 0.00346020772);
    u_xlat4.xyz = floor(u_xlat4.xyz);
    u_xlat2.xyz = (-u_xlat4.xyz) * float3(289.0, 289.0, 289.0) + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * float3(0.024390243, 0.024390243, 0.024390243);
    u_xlat2.xyz = frac(u_xlat2.xyz);
    u_xlat4.xyz = u_xlat2.xyz * float3(2.0, 2.0, 2.0) + float3(-0.5, -0.5, -0.5);
    u_xlat2.xyz = u_xlat2.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = floor(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat2.xyz = abs(u_xlat2.xzy) + float3(-0.5, -0.5, -0.5);
    u_xlat4.w = u_xlat2.x;
    u_xlat5.xyz = u_xlat2.xzy * u_xlat2.xzy;
    u_xlat5.xyz = u_xlat4.xyz * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) * float3(0.853734732, 0.853734732, 0.853734732) + float3(1.79284286, 1.79284286, 1.79284286);
    u_xlat18.xy = u_xlat4.xw * u_xlat5.xx;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat18.xy);
    u_xlat7.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat8 = u_xlat0.xyxy + float4(0.211324871, 0.211324871, -0.577350259, -0.577350259);
    u_xlat9.xz = (-u_xlat3.xy) + u_xlat8.xy;
    u_xlat7.y = dot(u_xlat9.xz, u_xlat9.xz);
    u_xlat7.z = dot(u_xlat8.zw, u_xlat8.zw);
    u_xlat3.xyz = (-u_xlat7.xyz) + float3(0.5, 0.5, 0.5);
    u_xlat3.xyz = max(u_xlat3.xyz, float3(0.0, 0.0, 0.0));
    u_xlat7.xyz = u_xlat3.xyz * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat7.xyz;
    u_xlat18.x = u_xlat18.x * u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * -6.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat18.x;
    u_xlat2.xw = u_xlat4.zy;
    u_xlat2 = u_xlat2.xywz * u_xlat5.zzyy;
    u_xlat6.y = dot(u_xlat9.xz, u_xlat2.zw);
    u_xlat9.x = u_xlat9.x * u_xlat3.y;
    u_xlat9.y = u_xlat3.z * u_xlat8.z;
    u_xlat6.z = dot(u_xlat8.zw, u_xlat2.xy);
    u_xlat9.xy = u_xlat9.xy * float2(-6.0, -6.0);
    u_xlat0.x = u_xlat9.x * u_xlat6.y + u_xlat0.x;
    u_xlat3.y = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat0.x = u_xlat7.y * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat9.y * u_xlat6.z + u_xlat0.x;
    u_xlat3.x = u_xlat7.z * u_xlat2.x + u_xlat0.x;
    u_xlat0.xy = u_xlat3.xy * float2(1.56000006, 1.56000006) + u_xlat1.xw;
    u_xlati18 = int((0.0<u_xlat1.z) ? 0xFFFFFFFFu : uint(0));
    u_xlati27 = int((u_xlat1.z<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlat1 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlati0 = (-u_xlati18) + u_xlati27;
    u_xlat0.x = float(u_xlati0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat1;
    output.position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float2 u_xlat16_0;
float2 u_xlat1;
float u_xlat16_1;
float4 u_xlat16_2;
float4 u_xlat16_3;
float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
float u_xlat16_8;

    u_xlat16_0.xy = input.vs_TEXCOORD0.yy * float2(1.25, 0.600000024);
    u_xlat16_4 = log2(abs(u_xlat16_0.y));
    u_xlat16_0.x = u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_4 = u_xlat16_4 * 1.29999995;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat1.y = _Time.x * animSpeed + u_xlat16_4;
    u_xlat1.x = input.vs_TEXCOORD0.x;
    u_xlat16_1 = tex2D(_MainTex, u_xlat1.xy).x;
    u_xlatb5 = value>=0.0;
    u_xlat16_4 = (u_xlatb5) ? 1.0 : 0.0;
    u_xlatb5 = float4(0.0, 0.0, 0.0, 0.0)!=float4(isDarkTheme,isDarkTheme,isDarkTheme,isDarkTheme);
    u_xlat16_2 = (bool(u_xlatb5)) ? _ColorDark1 : _ColorBright1;
    u_xlat16_3 = (bool(u_xlatb5)) ? _ColorDark0 : _ColorBright0;
    u_xlat5 = (u_xlatb5) ? 1.0 : 1.39999998;
    u_xlat16_2 = u_xlat16_2 + (-u_xlat16_3);
    u_xlat16_2 = float4(u_xlat16_4,u_xlat16_4,u_xlat16_4,u_xlat16_4) * u_xlat16_2 + u_xlat16_3;
    u_xlat1.x = u_xlat16_1 * u_xlat16_2.w;
    outputColor.xyz = u_xlat16_2.xyz;
    u_xlat16_4 = abs(value) * ratio;
    u_xlat16_4 = u_xlat16_4 * u_xlat1.x;
    u_xlat16_8 = (-input.vs_TEXCOORD0.y) + 1.0;
    u_xlat16_8 = u_xlat16_8 * 5.00000048;
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_0.x;
    u_xlat16_8 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * 2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat16_4 = input.vs_TEXCOORD0.x + -0.5;
    u_xlat16_4 = -abs(u_xlat16_4) * 2.0 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 3.0;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
    outputColor.w = u_xlat5 * u_xlat16_0.x;
    return outputColor;

return outputColor;
}
ENDCG
}}}
