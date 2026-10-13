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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM float                radius;
	UNITY_UNIFORM float                height;
	UNITY_UNIFORM mediump float                ratio;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat16_0.x = dot(_WorldSpaceCameraPos.xz, _WorldSpaceCameraPos.xz);
    u_xlat16_2 = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat1.x = max(u_xlat16_0.x, radius);
    u_xlat1.x = u_xlat1.x + (-radius);
    u_xlat16_0.xy = vec2(u_xlat16_2) * _WorldSpaceCameraPos.xz;
    u_xlat3 = dot(u_xlat16_0.xy, in_POSITION0.xz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat1.x = u_xlat3 * u_xlat1.x + radius;
    u_xlat1.xy = u_xlat1.xx * in_POSITION0.xz;
    u_xlat5 = in_POSITION0.y * height;
    u_xlat0 = vec4(u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec2 paramY;
uniform 	mediump vec3 colorBGDefault;
uniform 	mediump vec3 colorBGCarCenter;
uniform 	mediump float ratioCarCenter;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM float                radius;
	UNITY_UNIFORM float                height;
	UNITY_UNIFORM mediump float                ratio;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
float u_xlat1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0 = paramY.x + -0.699999988;
    u_xlat1 = u_xlat16_0 * -0.5;
    u_xlat16_0 = vs_TEXCOORD2.y / vs_TEXCOORD2.w;
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
    u_xlat16_2.xyz = vec3(vec3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_2.xyz + colorBGDefault.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-colorBGCarCenter.xyz);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz + colorBGCarCenter.xyz;
    SV_Target0.w = ratio;
    return;
}

#endif
