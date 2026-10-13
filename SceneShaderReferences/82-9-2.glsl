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
	UNITY_UNIFORM mediump vec4                _WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4                SH0;
	UNITY_UNIFORM mediump vec4                SH1;
	UNITY_UNIFORM mediump vec4                SH2;
	UNITY_UNIFORM mediump vec4                pointLight;
	UNITY_UNIFORM mediump vec2                carRange;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Scale;
	UNITY_UNIFORM mediump float                valueOverrideAlbedo;
	UNITY_UNIFORM mediump float                ratioOverrideAlbedo;
	UNITY_UNIFORM mediump float                valueOverrideMetallic;
	UNITY_UNIFORM mediump float                ratioOverrideMetallic;
	UNITY_UNIFORM vec4                _Time;
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
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_5;
mediump float u_xlat16_8;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_2.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.z);
    u_xlat16_5 = u_xlat16_5 * SH2.x;
    u_xlat16_2.x = (-u_xlat0.z) * u_xlat0.z + u_xlat16_2.x;
    u_xlat16_1.w = u_xlat16_2.x * 0.31539157;
    u_xlat16_2.xzw = u_xlat0.zyx * u_xlat0.xzy;
    u_xlat16_1.xyz = u_xlat16_2.xzw * vec3(1.09254849, 1.09254849, 1.09254849);
    u_xlat16_2.x = dot(SH1, u_xlat16_1);
    u_xlat16_1.yzw = u_xlat0.xyz * vec3(0.488602519, 0.488602519, 0.488602519);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_1.x = 0.282094806;
    u_xlat16_8 = dot(SH0, u_xlat16_1);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_8;
    vs_TEXCOORD1.y = u_xlat16_5 * 0.546274245 + u_xlat16_2.x;
    u_xlat16_2.x = (-in_COLOR0.x) + 2.0;
    vs_TEXCOORD1.x = u_xlat16_2.x * in_COLOR0.x;
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
uniform 	mediump vec4 colorSun;
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
	UNITY_UNIFORM mediump vec4                pointLight;
	UNITY_UNIFORM mediump vec2                carRange;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Scale;
	UNITY_UNIFORM mediump float                valueOverrideAlbedo;
	UNITY_UNIFORM mediump float                ratioOverrideAlbedo;
	UNITY_UNIFORM mediump float                valueOverrideMetallic;
	UNITY_UNIFORM mediump float                ratioOverrideMetallic;
	UNITY_UNIFORM vec4                _Time;
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
in mediump vec3 vs_TEXCOORD0;
centroid in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_6;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz + (-pointLight.xyz);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.200000003;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_6 = colorSun.w * pointLight.w;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_0.x = u_xlat16_0.x * 4.0;
    u_xlat16_0.xyz = u_xlat16_0.xxx * colorSun.xyz;
    u_xlat16_18 = dot(_BaseColor.xyz, vec3(0.300000012, 0.5, 0.200000003));
    u_xlat16_18 = u_xlat16_18 + 0.699999988;
    u_xlat16_18 = float(1.0) / u_xlat16_18;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_18) + _LightColor0.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_1.xyz = vec3(u_xlat16_18) * vs_TEXCOORD2.xyz;
    u_xlat16_18 = dot(u_xlat16_1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
    u_xlat16_0.xyz = vec3(u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_18 = valueOverrideMetallic + (-_Metallic);
    u_xlat16_18 = ratioOverrideMetallic * u_xlat16_18 + _Metallic;
    u_xlat16_18 = (-u_xlat16_18) * 0.959999979 + 0.959999979;
    u_xlat16_2.xyz = vec3(vec3(valueOverrideAlbedo, valueOverrideAlbedo, valueOverrideAlbedo)) + (-_BaseColor.xyz);
    u_xlat16_2.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_18 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_18 = inversesqrt(u_xlat16_18);
    u_xlat16_2.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_18 = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat5 = _Time.y * 0.5;
    u_xlat5 = fract(u_xlat5);
    u_xlat16_1.x = vs_TEXCOORD0.x * carRange.x + carRange.y;
    u_xlat16_1.x = (-u_xlat5) * 3.0 + u_xlat16_1.x;
    u_xlat16_1.x = -abs(u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_18 = u_xlat16_18 * u_xlat16_1.x;
    SV_Target0.xyz = vec3(u_xlat16_18) * vec3(0.400000006, 0.699999988, 1.60000002) + u_xlat16_0.xyz;
    u_xlat16_0.x = (-_BaseColor.w) + 0.300000012;
    SV_Target0.w = ratioOverrideAlbedo * u_xlat16_0.x + _BaseColor.w;
    return;
}

#endif
