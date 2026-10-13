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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerCamera {
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
vec4 ImmCB_0[4];
uniform 	mediump float isDarkTheme;
uniform 	mediump float values[7];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump vec4                color0;
	UNITY_UNIFORM mediump vec4                color1;
	UNITY_UNIFORM mediump vec4                color2;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D texSeats;
UNITY_LOCATION(1) uniform mediump sampler2D texMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat10_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec2 u_xlat16_6;
mediump vec4 u_xlat16_7;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_10;
float u_xlat24;
int u_xlati24;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
void main()
{
ImmCB_0[0] = vec4(1.0,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0,1.0,0.0,0.0);
ImmCB_0[2] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[3] = vec4(0.0,0.0,0.0,1.0);
    u_xlatb0 = abs(values[0])>=0.100000001;
    u_xlat16_1.x = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_1.x = abs(values[0]) * 0.100000001 + u_xlat16_1.x;
    u_xlat10_0 = texture(texMask, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w * u_xlat16_1.x;
    u_xlat16_9 = u_xlat16_1.x * 0.699999988;
    u_xlatb24 = 0.0<values[0];
    u_xlatb2 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(isDarkTheme);
    u_xlat16_3.xyz = (bool(u_xlatb2)) ? color2.xyz : color1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb24)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_10.xy = texture(texSeats, vs_TEXCOORD0.xy).xy;
    u_xlati24 = u_xlatb2 ? 1 : int(0);
    u_xlat24 = dot(u_xlat16_10.xy, ImmCB_0[u_xlati24].xy);
    u_xlat16_5.xyz = (-vec3(u_xlat24)) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_4.xyz + vec3(u_xlat24);
    u_xlat16_4.xyz = vec3(u_xlat16_9) * u_xlat16_5.xyz + vec3(u_xlat24);
    u_xlat16_1.xyz = (bool(u_xlatb2)) ? u_xlat16_4.xyz : u_xlat16_1.xzw;
    u_xlat16_1.xyz = (-vec3(u_xlat24)) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + vec3(u_xlat24);
    u_xlatb24 = 0.0<values[1];
    u_xlat16_4.xyz = (bool(u_xlatb24)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlatb24 = abs(values[1])>=0.100000001;
    u_xlat16_25 = (u_xlatb24) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[1]) * 0.100000001 + u_xlat16_25;
    u_xlatb24 = vs_TEXCOORD0.x<0.5;
    u_xlat16_6.xy = (bool(u_xlatb24)) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    u_xlat16_7 = u_xlat10_0.xxyy * u_xlat16_6.xyxy;
    u_xlat16_6.xy = u_xlat10_0.zz * u_xlat16_6.xy;
    u_xlat16_25 = u_xlat16_25 * u_xlat16_7.x;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[2];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[2])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[2]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_7.y * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[3];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[3])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[3]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_7.z * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[4];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[4])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[4]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_7.w * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[5];
    u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_5.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[5])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[5]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_6.x * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = (bool(u_xlatb2)) ? u_xlat16_5.xyz : u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_4.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlatb0 = 0.0<values[6];
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? u_xlat16_3.xyz : color0.xyz;
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_4.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlatb0 = abs(values[6])>=0.100000001;
    u_xlat16_25 = (u_xlatb0) ? 0.200000003 : 0.0;
    u_xlat16_25 = abs(values[6]) * 0.100000001 + u_xlat16_25;
    u_xlat16_25 = u_xlat16_6.y * u_xlat16_25;
    u_xlat16_27 = u_xlat16_25 * 0.699999988;
    u_xlat16_3.xyz = vec3(u_xlat16_25) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat16_4.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_3.xyz = (bool(u_xlatb2)) ? u_xlat16_4.xyz : u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_3.xyz * vec3(0.699999988, 0.699999988, 0.699999988) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.w = log2(ratio);
    u_xlat16_0 = u_xlat16_0 * vec4(2.20000005, 2.20000005, 2.20000005, 2.20000005);
    SV_Target0 = exp2(u_xlat16_0);
    return;
}

#endif
