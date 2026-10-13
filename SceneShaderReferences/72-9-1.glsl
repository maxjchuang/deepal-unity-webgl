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
	UNITY_UNIFORM mediump vec3                _Color;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
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
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM float                radius;
	UNITY_UNIFORM float                height;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump vec3                _Color;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(_Color.x, _Color.y, _Color.z, ratio);
    return;
}

#endif
