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
uniform 	mediump float angleShootingStars[3];
uniform 	mediump float timeShootingStar;
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
	UNITY_UNIFORM mediump vec4                _Color;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                radius;
	UNITY_UNIFORM mediump float                sizeX;
	UNITY_UNIFORM mediump float                sizeY;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump vec4 in_POSITION0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
int u_xlati1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
mediump float u_xlat16_18;
mediump float u_xlat16_20;
void main()
{
    u_xlat16_0.x = timeShootingStar * 3.14159274;
    u_xlat16_0.x = sin(u_xlat16_0.x);
    vs_TEXCOORD1 = u_xlat16_0.x * ratio;
    vs_TEXCOORD0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    u_xlat1.x = float(uint(gl_InstanceID));
    u_xlat1.x = u_xlat1.x * 0.103100002;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat7 = u_xlat1.x + 33.3300018;
    u_xlat1.x = u_xlat7 * u_xlat1.x;
    u_xlat1.x = dot(u_xlat1.xx, u_xlat1.xx);
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat16_0.x = u_xlat1.x * 0.200000003;
    u_xlat16_0.x = timeShootingStar * timeShootingStar + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_2.y = 0.660000026;
    u_xlati1 = gl_InstanceID;
    u_xlat16_3.x = sin(angleShootingStars[u_xlati1]);
    u_xlat16_2.x = cos(angleShootingStars[u_xlati1]);
    u_xlat16_6.x = 1.0 + angleShootingStars[u_xlati1];
    u_xlat16_4.x = sin(u_xlat16_6.x);
    u_xlat16_5.x = cos(u_xlat16_6.x);
    u_xlat16_2.z = u_xlat16_3.x;
    u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(vec3(radius, radius, radius));
    u_xlat16_5.y = 0.159999996;
    u_xlat16_5.z = u_xlat16_4.x;
    u_xlat16_2.xyz = u_xlat16_5.xyz * vec3(vec3(radius, radius, radius)) + (-u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.zxy) + _WorldSpaceCameraPos.zxy;
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_18 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_4.xyz = u_xlat16_2.yzx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.zxy * u_xlat16_2.zxy + (-u_xlat16_4.xyz);
    u_xlat16_18 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(sizeX, sizeX, sizeX));
    u_xlat16_3.xyz = u_xlat16_3.xyz * in_POSITION0.xxx;
    u_xlat16_18 = in_POSITION0.y + 0.5;
    u_xlat16_20 = u_xlat16_18 * sizeY;
    u_xlat16_18 = (-u_xlat16_18) + 2.0;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_20) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat16_0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat16_0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
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
	UNITY_UNIFORM mediump vec4                _Color;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                radius;
	UNITY_UNIFORM mediump float                sizeX;
	UNITY_UNIFORM mediump float                sizeY;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vs_TEXCOORD1;
    SV_Target0.w = u_xlat16_0 * _Color.w;
    SV_Target0.xyz = _Color.xyz;
    return;
}

#endif
