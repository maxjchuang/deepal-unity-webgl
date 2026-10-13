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
	UNITY_UNIFORM mediump vec4                _LightColor0;
	UNITY_UNIFORM mediump vec3                _AmbientColor;
	UNITY_UNIFORM mediump vec4                _WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4                SH0;
	UNITY_UNIFORM mediump vec4                SH1;
	UNITY_UNIFORM mediump vec4                SH2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXpointLight;
	UNITY_UNIFORM mediump vec2 Xhlslcc_UnusedXcarRange;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Scale;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXvalueOverrideAlbedo;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXratioOverrideAlbedo;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXvalueOverrideMetallic;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXratioOverrideMetallic;
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
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
out mediump vec3 vs_TEXCOORD0;
centroid out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec2 u_xlat16_4;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0 = dot(_WorldSpaceCameraPos.xz, _WorldSpaceCameraPos.xz);
    u_xlat16_4.x = inversesqrt(u_xlat16_0);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_0 = max(u_xlat16_0, skyRadius);
    u_xlat16_0 = u_xlat16_0 + (-skyRadius);
    u_xlat16_4.xy = u_xlat16_4.xx * _WorldSpaceCameraPos.xz;
    u_xlat16_4.x = dot(u_xlat16_4.xy, in_POSITION0.xz);
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.x * u_xlat16_0 + skyRadius;
    u_xlat1.xyz = vec3(u_xlat16_0) * in_POSITION0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    vs_TEXCOORD0.xyz = u_xlat1.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat16_2.x = u_xlat16_2.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_6 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.z);
    u_xlat16_6 = u_xlat16_6 * SH2.x;
    u_xlat16_2.x = (-u_xlat1.z) * u_xlat1.z + u_xlat16_2.x;
    u_xlat16_3.w = u_xlat16_2.x * 0.31539157;
    u_xlat16_2.xzw = u_xlat1.zyx * u_xlat1.xzy;
    u_xlat16_3.xyz = u_xlat16_2.xzw * vec3(1.09254849, 1.09254849, 1.09254849);
    u_xlat16_2.x = dot(SH1, u_xlat16_3);
    u_xlat16_3.yzw = u_xlat1.xyz * vec3(0.488602519, 0.488602519, 0.488602519);
    vs_TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat16_3.x = 0.282094806;
    u_xlat16_10 = dot(SH0, u_xlat16_3);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_10;
    vs_TEXCOORD1.y = u_xlat16_6 * 0.546274245 + u_xlat16_2.x;
    u_xlat16_2.x = (-in_COLOR0.x) + 2.0;
    vs_TEXCOORD1.x = u_xlat16_2.x * in_COLOR0.x;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD6 = u_xlat0;
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
	UNITY_UNIFORM mediump vec4                _LightColor0;
	UNITY_UNIFORM mediump vec3                _AmbientColor;
	UNITY_UNIFORM mediump vec4                _WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4                SH0;
	UNITY_UNIFORM mediump vec4                SH1;
	UNITY_UNIFORM mediump vec4                SH2;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXpointLight;
	UNITY_UNIFORM mediump vec2 Xhlslcc_UnusedXcarRange;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Scale;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXvalueOverrideAlbedo;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXratioOverrideAlbedo;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXvalueOverrideMetallic;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXratioOverrideMetallic;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_FresnelColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_FresnelColorBlend;
	UNITY_UNIFORM mediump vec4                _BaseColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_AOColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_SpecColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatParam;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatBlend;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BumpMap_ST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_AOPower;
	UNITY_UNIFORM mediump float                _Metallic;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_Smoothness;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Intensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D skyTex;
in mediump vec3 vs_TEXCOORD0;
centroid in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
vec3 u_xlat7;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
float u_xlat17;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x / skyRadius;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_5.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.x = (-u_xlat16_5.y) * u_xlat16_5.x + 1.0;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_10 * 0.5;
    u_xlat16_10 = (-u_xlat16_10) * u_xlat16_10 + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1.z = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat16_5.xz = u_xlat16_1.xz * vec2(0.5, 6.5) + vec2(-0.5, -0.100000001);
    u_xlat16_5.x = dot(u_xlat16_5.xz, u_xlat16_5.xz);
    u_xlat16_5.x = sqrt(u_xlat16_5.x);
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * colorSun.w;
    u_xlat2.x = u_xlat16_10 * u_xlat16_5.x;
    u_xlat16_5.x = skyTime * 2.0 + -1.0;
    u_xlat16_5.x = abs(u_xlat16_5.x) * 0.0900000036 + 0.0599999987;
    u_xlat2.x = u_xlat16_5.x * u_xlat2.x;
    u_xlat16_3.x = 0.649999976;
    u_xlat16_3.y = skyTime;
    u_xlat16_5.xyz = texture(skyTex, u_xlat16_3.xy).xyz;
    u_xlat7.x = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.5, 0.200000003));
    u_xlat7.xyz = (-u_xlat16_5.xyz) + u_xlat7.xxx;
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat7.xyz * vec3(0.420000017, 0.420000017, 0.420000017);
    u_xlat7.xyz = (-u_xlat7.xyz) * vec3(0.420000017, 0.420000017, 0.420000017) + colorSun.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat7.xyz + u_xlat4.xyz;
    u_xlat16_5.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_5.x = inversesqrt(u_xlat16_5.x);
    u_xlat16_5.xyz = u_xlat16_5.xxx * vs_TEXCOORD2.xyz;
    u_xlat16_5.x = dot(u_xlat16_5.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xxx * _LightColor0.xyz;
    u_xlat16_1.x = (-_Metallic) * 0.959999979 + 0.959999979;
    u_xlat16_1.xzw = u_xlat16_1.xxx * _BaseColor.xyz;
    u_xlat16_3.xyz = vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * _BaseColor.xyz;
    u_xlat16_5.xyz = u_xlat16_1.xzw * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = (-u_xlat16_5.xyz) + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat16_0.xxx * u_xlat2.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = (-colorBGDefault.xyz) + colorBGCarCenter.xyz;
    u_xlat16_0.xyz = vec3(vec3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_0.xyz + colorBGDefault.xyz;
    u_xlat16_0.xyz = (-u_xlat2.xyz) + u_xlat16_0.xyz;
    u_xlat16_15 = paramY.xxxy.z + -0.699999988;
    u_xlat17 = u_xlat16_15 * -0.5;
    u_xlat17 = u_xlat16_1.y * paramY.xxxy.z + u_xlat17;
    u_xlat17 = paramY.xxxy.z * paramY.xxxy.w + u_xlat17;
    u_xlat16_15 = ratioCarCenter * ratioCarCenter;
    u_xlat16_15 = u_xlat16_15 * 1.80000007 + -0.200000003;
    u_xlat16_1.x = ratioCarCenter * -1.50000012 + 3.4000001;
    u_xlat16_15 = u_xlat17 * u_xlat16_1.x + u_xlat16_15;
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
    u_xlat16_15 = (-u_xlat16_15) + 1.0;
    u_xlat16_1.x = u_xlat16_15 * u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) * 2.0 + 3.0;
    u_xlat16_15 = u_xlat16_15 * u_xlat16_1.x;
    SV_Target0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = _BaseColor.w;
    return;
}

#endif
