#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _ProjectionParams;
uniform 	mediump float skyRadius;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.xyz * vec3(skyRadius);
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.z = max(u_xlat0.z, 0.00100000005);
    gl_Position = u_xlat0;
    vs_TEXCOORD3.zw = u_xlat0.zw;
    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.w = u_xlat2 * 0.5;
    vs_TEXCOORD3.xy = u_xlat0.zz + u_xlat0.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump float skyTime;
uniform 	mediump float isDarkTheme;
uniform 	mediump vec4 colorSun;
UNITY_LOCATION(0) uniform mediump sampler2D skyTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_8;
mediump float u_xlat16_14;
mediump float u_xlat16_20;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD3.x / vs_TEXCOORD3.w;
    u_xlat16_0.y = vs_TEXCOORD1.y;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(0.5, 6.5) + vec2(-0.5, -0.100000001);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * colorSun.w;
    u_xlat1 = vs_TEXCOORD3.x / vs_TEXCOORD3.w;
    u_xlat1 = u_xlat1 * 3.14159274;
    u_xlat1 = sin(u_xlat1);
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = u_xlat1 * 0.100000024 + 1.0;
    u_xlat7 = log2(abs(vs_TEXCOORD1.y));
    u_xlat1 = u_xlat7 * u_xlat1;
    u_xlat1 = exp2(u_xlat1);
    u_xlat16_6.x = u_xlat1 * 4.80000019;
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_2.x = (-u_xlat16_6.x) + 1.0;
    u_xlatb7 = 0.0392156877<vs_TEXCOORD1.y;
    if(u_xlatb7){
        u_xlat16_2.y = skyTime;
        u_xlat16_6.xyz = texture(skyTex, u_xlat16_2.xy).xyz;
    } else {
        u_xlat16_8 = vs_TEXCOORD1.x * 1.99899995;
        u_xlat16_3.x = fract(u_xlat16_8);
        u_xlat16_8 = vs_TEXCOORD1.y * 12.75 + 0.5;
        u_xlatb7 = 0.500100017<vs_TEXCOORD1.x;
        u_xlat16_14 = (-u_xlat16_8) + 1.0;
        u_xlat16_3.y = (u_xlatb7) ? u_xlat16_14 : u_xlat16_8;
        u_xlat16_4 = texture(_MainTex, u_xlat16_3.xy);
        u_xlat16_8 = u_xlat16_4.w + u_xlat16_4.w;
        u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
        u_xlat16_14 = u_xlat16_8 * -0.350000024 + 1.0;
        u_xlat16_5.x = u_xlat16_14 * u_xlat16_2.x;
        u_xlat16_5.y = skyTime;
        u_xlat16_2.xzw = texture(skyTex, u_xlat16_5.xy).xyz;
        u_xlat16_3.x = dot(u_xlat16_2.xzw, vec3(0.300000012, 0.5, 0.200000003));
        u_xlat16_3.xzw = (-u_xlat16_2.xzw) + u_xlat16_3.xxx;
        u_xlat16_3.xzw = u_xlat16_3.xzw * vec3(0.5, 0.5, 0.5) + u_xlat16_2.xzw;
        u_xlat16_3.xzw = u_xlat16_3.xzw * vec3(0.699999988, 0.699999988, 0.699999988) + (-u_xlat16_2.xzw);
        u_xlat16_2.xyz = vec3(u_xlat16_8) * u_xlat16_3.xzw + u_xlat16_2.xzw;
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
        u_xlat16_2.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat16_4.xyz;
        u_xlat16_20 = u_xlat16_3.y * 2.0 + -1.0;
        u_xlat16_20 = min(abs(u_xlat16_20), 1.0);
        u_xlat16_20 = u_xlat16_20 + -1.0;
        u_xlat16_20 = isDarkTheme * u_xlat16_20 + 1.0;
        u_xlat16_3.xyz = vec3(u_xlat16_20) * u_xlat16_2.xyz;
        u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.399999976, 0.399999976, 0.399999976);
        u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(0.600000024, 0.600000024, 0.600000024) + u_xlat16_3.xyz;
    }
    u_xlat16_2.xyz = (-u_xlat16_6.xyz) + colorSun.xyz;
    SV_Target0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
