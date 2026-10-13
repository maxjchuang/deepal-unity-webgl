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
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4                _LightColor0;
	UNITY_UNIFORM mediump vec3                _AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4                _Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec3 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    gl_Position = u_xlat1 + hlslcc_mtx4x4unity_MatrixVP[3];
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = max(u_xlat6, 1.17549435e-38);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
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
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4                _LightColor0;
	UNITY_UNIFORM mediump vec3                _AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4                _Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec2 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_4;
mediump vec2 u_xlat16_7;
void main()
{
    u_xlat0 = _Time.y * 0.159154937;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * 6.28318548;
    u_xlat16_1.x = vs_TEXCOORD0.x * 1.89999998 + u_xlat0;
    u_xlat16_1.x = sin(u_xlat16_1.x);
    u_xlat16_1.y = u_xlat16_1.x + vs_TEXCOORD0.z;
    u_xlat16_7.x = u_xlat16_1.y * 2.0999999 + u_xlat0;
    u_xlat16_7.x = cos(u_xlat16_7.x);
    u_xlat16_1.x = u_xlat16_7.x + vs_TEXCOORD0.x;
    u_xlat0 = fract(_Time.x);
    u_xlat16_7.xy = u_xlat16_1.xy * vec2(0.100000001, 0.100000001) + (-vec2(u_xlat0));
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(0.100000001, 0.100000001) + vec2(u_xlat0);
    u_xlat16_1.x = texture(_MainTex, u_xlat16_1.xy).x;
    u_xlat16_4.x = texture(_MainTex, u_xlat16_7.xy).x;
    u_xlat16_4.x = u_xlat16_4.x * 9.0 + -2.5999999;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * 3.0 + (-u_xlat16_4.x);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_4.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_2 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_2);
    u_xlat16_4.x = dot(u_xlat16_4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_4.y = (-u_xlat16_4.x) + 1.0;
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(1.42857146, 3.33333325);
    u_xlat16_4.xy = min(u_xlat16_4.xy, vec2(1.0, 1.0));
    u_xlat16_4.x = u_xlat16_4.y * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_4.x;
    u_xlat16_2 = vs_TEXCOORD0.y * 0.5;
    u_xlat16_2 = u_xlat16_2;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_4.x = u_xlat16_2 * u_xlat16_2;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 0.100000001;
    u_xlat16_4.xyz = (-_LightColor0.xyz) + _AmbientColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5) + _LightColor0.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * u_xlat16_1.xxx;
    SV_Target0.w = 0.0;
    return;
}

#endif
