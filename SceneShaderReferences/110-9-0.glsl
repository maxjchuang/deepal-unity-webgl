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
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
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
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_NORMAL0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
void main()
{
    u_xlat16_0.x = dot(_WorldSpaceCameraPos.xz, _WorldSpaceCameraPos.xz);
    u_xlat16_2 = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, skyRadius);
    u_xlat1.x = u_xlat16_0.x + (-skyRadius);
    u_xlat16_0.xy = vec2(u_xlat16_2) * _WorldSpaceCameraPos.xz;
    u_xlat3 = dot(u_xlat16_0.xy, in_POSITION0.xz);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat1.x = u_xlat3 * u_xlat1.x + skyRadius;
    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
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
uniform 	mediump float skyRadius;
uniform 	mediump float skyTime;
uniform 	mediump vec4 colorSun;
uniform 	mediump vec2 paramY;
uniform 	mediump vec3 colorBGDefault;
uniform 	mediump vec3 colorBGCarCenter;
uniform 	mediump float ratioCarCenter;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
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
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM vec4                _BaseColor;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D skyTex;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
mediump float u_xlat16_10;
float u_xlat12;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = inversesqrt(u_xlat12);
    u_xlat4.z = sqrt(u_xlat12);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4.x = (-u_xlat4.z) + skyRadius;
    u_xlat4.xy = u_xlat4.xz / vec2(skyRadius);
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
    u_xlat16_3.xyz = texture(skyTex, u_xlat16_3.xy).xyz;
    u_xlat4.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.5, 0.200000003));
    u_xlat4.xyz = (-u_xlat16_3.xyz) + u_xlat4.xxx;
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-_BaseColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz + _BaseColor.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(0.699999988, 0.699999988, 0.699999988);
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(0.699999988, 0.699999988, 0.699999988) + colorSun.xyz;
    u_xlat16_2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat16_2.xz = u_xlat16_2.xz * vec2(0.5, 6.5) + vec2(-0.5, -0.100000001);
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
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat16_2.xzw = (-colorBGDefault.xyz) + colorBGCarCenter.xyz;
    u_xlat16_2.xzw = vec3(vec3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_2.xzw + colorBGDefault.xyz;
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
    SV_Target0.xyz = vec3(u_xlat16_6) * u_xlat16_2.xzw + u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
