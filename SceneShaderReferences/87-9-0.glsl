RM
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
	UNITY_UNIFORM float                radius;
	UNITY_UNIFORM float                height;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                value;
	UNITY_UNIFORM mediump vec3                _Color;
	UNITY_UNIFORM mediump vec3                _ColorBackLight;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
float u_xlat7;
void main()
{
    u_xlat16_0.x = dot(_WorldSpaceCameraPos.xz, _WorldSpaceCameraPos.xz);
    u_xlat16_3 = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat1.x = max(u_xlat16_0.x, radius);
    u_xlat1.x = u_xlat1.x + (-radius);
    u_xlat16_0.xy = vec2(u_xlat16_3) * _WorldSpaceCameraPos.xz;
    u_xlat4 = dot(u_xlat16_0.xy, in_POSITION0.xz);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat1.x = u_xlat4 * u_xlat1.x + radius;
    u_xlat1.xy = u_xlat1.xx * in_POSITION0.xz;
    u_xlat7 = in_POSITION0.y * height;
    u_xlat2.xyz = vec3(u_xlat7) * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xzw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat1.yyy + u_xlat1.xzw;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
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
uniform 	vec4 _ScreenParams;
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
	UNITY_UNIFORM mediump float                value;
	UNITY_UNIFORM mediump vec3                _Color;
	UNITY_UNIFORM mediump vec3                _ColorBackLight;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D texDots;
in highp vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
float u_xlat6;
mediump vec2 u_xlat16_9;
mediump float u_xlat16_13;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = abs(u_xlat0.x) + abs(u_xlat0.x);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.x = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * 3.5999999;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0.x = (-value) * 1.60000002 + u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat0.x = u_xlat0.x * 1.66666663 + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * 2.0 + -1.0;
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_9.x = (-u_xlat0.x) * 2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_9.x * u_xlat16_5.x;
    u_xlat0.x = _ScreenParams.y / _ScreenParams.x;
    u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat2.w = u_xlat0.x * u_xlat2.y;
    u_xlat0.xy = u_xlat2.xw * vec2(26.0, 26.0);
    u_xlat16_5.y = texture(texDots, u_xlat0.xy).x;
    u_xlat16_13 = value * 3.14159274;
    u_xlat16_5.z = sin(u_xlat16_13);
    u_xlat16_5.xz = u_xlat16_5.yz * u_xlat16_5.xz;
    u_xlat16_9.x = u_xlat16_5.y * u_xlat16_5.z;
    u_xlat16_9.x = u_xlat16_9.x * 0.0299999993;
    u_xlat0.x = vs_TEXCOORD0.y * 2.0 + -0.860000014;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_5.x = u_xlat16_5.x * u_xlat0.x + u_xlat16_9.x;
    u_xlat16_9.xy = u_xlat0.xx * vec2(2.5, 3.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_3.xyz = u_xlat16_1.xxx * _Color.xyz;
    u_xlat0.yw = u_xlat16_9.xx;
    u_xlat16_1.x = min(u_xlat16_9.y, 1.0);
    u_xlat6 = u_xlat2.x + -0.5;
    u_xlat0.x = u_xlat6 * 1.39999998;
    u_xlat0.z = u_xlat0.x;
    u_xlat16_5.x = dot(u_xlat0.xy, u_xlat0.zw);
    u_xlat16_5.x = sqrt(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_1.y = (-u_xlat16_5.x) + 1.0;
    u_xlat16_1.xz = u_xlat16_1.xy * u_xlat16_1.xy;
    u_xlat16_5.x = u_xlat16_1.z * u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ColorBackLight.xyz + u_xlat16_3.xyz;
    u_xlat2.z = vs_TEXCOORD0.y;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat2.xz).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-colorBGDefault.xyz) + colorBGCarCenter.xyz;
    u_xlat16_3.xyz = vec3(vec3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_3.xyz + colorBGDefault.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + u_xlat16_3.xyz;
    u_xlat16_13 = paramY.x + -0.699999988;
    u_xlat0.x = u_xlat16_13 * -0.5;
    u_xlat16_13 = vs_TEXCOORD2.y / vs_TEXCOORD2.w;
    u_xlat0.x = u_xlat16_13 * paramY.x + u_xlat0.x;
    u_xlat0.x = paramY.x * paramY.y + u_xlat0.x;
    u_xlat16_13 = ratioCarCenter * ratioCarCenter;
    u_xlat16_13 = u_xlat16_13 * 1.80000007 + -0.200000003;
    u_xlat16_15 = ratioCarCenter * -1.50000012 + 3.4000001;
    u_xlat16_13 = u_xlat0.x * u_xlat16_15 + u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_15 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = (-u_xlat16_13) * 2.0 + 3.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_15;
    SV_Target0.xyz = vec3(u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_1.xyz;
    SV_Target0.w = ratio;
    return;
}

#endif
        
