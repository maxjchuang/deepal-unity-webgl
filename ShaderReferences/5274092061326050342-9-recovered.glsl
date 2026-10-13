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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixVP[4];
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM float                fixMirror;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_NORMAL0.xy;
    u_xlat1.xy = in_POSITION0.xy;
    u_xlat9 = fixMirror * -2.0 + 1.0;
    u_xlat1.z = u_xlat9 * in_POSITION0.z;
    u_xlat0.z = u_xlat9 * in_NORMAL0.z;
    u_xlat0.xyw = u_xlat0.xyz * vec3(9.99999975e-05, 9.99999975e-05, 9.99999975e-05) + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xyw = u_xlat0.xyw + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    vs_TEXCOORD0.xz = u_xlat0.xw;
    vs_TEXCOORD0.y = (-u_xlat0.y);
    u_xlat1 = (-u_xlat0.yyyy) * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xyw = (-u_xlat0.xyw) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyw;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.xyw = u_xlat1.xzw + vec3(0.0, 0.00100000005, 0.0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat2.zw = hlslcc_mtx4x4glstate_matrix_projection[3].xz;
    gl_Position.x = dot(u_xlat2.xyz, u_xlat0.xyw);
    u_xlat0.xyw = u_xlat1.yzw + vec3(0.0, 0.00100000005, 0.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 0.0, 0.00100000005, 0.0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].y;
    gl_Position.y = dot(u_xlat2.xyz, u_xlat0.xyw);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    gl_Position.z = dot(u_xlat2, u_xlat1);
    u_xlat0.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat0.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    gl_Position.w = dot(u_xlat0.xy, u_xlat1.zw);
    u_xlat0.xyw = (-in_NORMAL0.yyy) * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 1.17549435e-38);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM float                fixMirror;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat16_6 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6 = inversesqrt(u_xlat16_6);
    u_xlat16_1.xyz = vec3(u_xlat16_6) * vs_TEXCOORD1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_1.y * 0.800000012;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_4 = min(abs(vs_TEXCOORD0.y), 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_6 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_4 = u_xlat16_6 * u_xlat16_4;
    u_xlat16_6 = u_xlat16_4 * 4.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_6 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_2 * u_xlat16_6 + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat16_0.x = u_xlat16_0.x * ratio;
    SV_Target0.w = u_xlat16_0.x * 1.5;
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
