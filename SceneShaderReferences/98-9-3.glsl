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
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXpointLight;
	UNITY_UNIFORM mediump vec2 Xhlslcc_UnusedXcarRange;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Scale;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXvalueOverrideAlbedo;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXratioOverrideAlbedo;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXvalueOverrideMetallic;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedXratioOverrideMetallic;
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_FresnelColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_FresnelColorBlend;
	UNITY_UNIFORM mediump vec4                _BaseColor;
	UNITY_UNIFORM mediump vec4                _AOColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_SpecColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatParam;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatBlend;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BumpMap_ST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float                _AOPower;
	UNITY_UNIFORM mediump float                _Metallic;
	UNITY_UNIFORM mediump float                _Smoothness;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Intensity;
	UNITY_UNIFORM mediump vec3                colorChargerStop;
	UNITY_UNIFORM mediump vec3                colorChargerStart;
	UNITY_UNIFORM mediump float                ratioCharger;
	UNITY_UNIFORM mediump float                lineOffset;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump float vs_TEXCOORD6;
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
    u_xlat0.x = in_POSITION0.y + 0.5;
    u_xlat0.x = u_xlat0.x * 1000.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = (-u_xlat0.x) * lineOffset + in_POSITION0.y;
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_TEXCOORD6 = (-in_TEXCOORD0.x) + 1.0;
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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
	UNITY_UNIFORM mediump vec4                _AOColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_SpecColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatParam;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatBlend;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BumpMap_ST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float                _AOPower;
	UNITY_UNIFORM mediump float                _Metallic;
	UNITY_UNIFORM mediump float                _Smoothness;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Intensity;
	UNITY_UNIFORM mediump vec3                colorChargerStop;
	UNITY_UNIFORM mediump vec3                colorChargerStart;
	UNITY_UNIFORM mediump float                ratioCharger;
	UNITY_UNIFORM mediump float                lineOffset;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _ReflMapDefault;
UNITY_LOCATION(1) uniform mediump sampler2D _LUT;
in mediump vec3 vs_TEXCOORD0;
in mediump float vs_TEXCOORD6;
centroid in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
ivec2 u_xlati4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_10;
ivec2 u_xlati18;
mediump vec2 u_xlat16_19;
mediump float u_xlat16_21;
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_21 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_0.xyz = vec3(u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_21 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_1.xyz = vec3(u_xlat16_21) * vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_21) + u_xlat16_0.xyz;
    u_xlat16_21 = dot((-u_xlat16_0.xyz), u_xlat16_1.xyz);
    u_xlat16_21 = u_xlat16_21 + u_xlat16_21;
    u_xlat16_3.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_21)) + (-u_xlat16_0.xyz);
    u_xlat16_21 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_3.xyz = vec3(u_xlat16_21) * u_xlat16_3.xyz;
    u_xlat16_21 = abs(u_xlat16_3.y) + abs(u_xlat16_3.x);
    u_xlat16_21 = abs(u_xlat16_3.z) + u_xlat16_21;
    u_xlat16_3.xyz = u_xlat16_3.xyz / vec3(u_xlat16_21);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_3.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati18.xy = ivec2(uvec2(lessThan(u_xlat16_3.xzxz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati18.xy;
    u_xlat16_5.xy = vec2(u_xlati4.xy);
    u_xlat16_19.xy = -abs(u_xlat16_3.zx) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_19.xy * u_xlat16_5.xy;
    u_xlatb4 = u_xlat16_3.y>=0.0;
    u_xlat16_3.xy = (bool(u_xlatb4)) ? u_xlat16_3.xz : u_xlat16_5.xy;
    u_xlat16_5.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_5.y = -abs(u_xlat16_3.y) + 1.0;
    u_xlat16_3.xy = (-vec2(_Metallic, _Smoothness)) * vec2(0.959999979, 0.699999988) + vec2(0.959999979, 1.70000005);
    u_xlat16_21 = u_xlat16_3.y * _Smoothness;
    u_xlat16_21 = u_xlat16_21 * 6.0;
    u_xlat16_10.xyz = textureLod(_ReflMapDefault, u_xlat16_5.xy, u_xlat16_21).xyz;
    u_xlat16_5.x = dot(u_xlat16_1.xyz, u_xlat16_0.xyz);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_21 = dot(u_xlat16_1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_21) * _LightColor0.xyz;
    u_xlat16_5.y = _Smoothness;
    u_xlat16_5.xy = textureLod(_LUT, u_xlat16_5.xy, 0.0).xy;
    u_xlat16_6.xyz = _BaseColor.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.xyz = u_xlat16_6.xyz * u_xlat16_5.xxx + u_xlat16_5.yyy;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xxx * _BaseColor.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz + u_xlat16_10.xyz;
    u_xlat16_21 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_2.xyz = vec3(u_xlat16_21) * u_xlat16_2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_7.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_7.x * u_xlat16_0.x;
    u_xlat16_7.x = (-_Smoothness) + 1.0;
    u_xlat16_7.xyz = max(u_xlat16_6.xyz, u_xlat16_7.xxx);
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_0.xxx + u_xlat16_6.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_3.xxx * u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _BaseColor.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat4 = _Time.y * 4.0;
    u_xlat4 = vs_TEXCOORD6 * 12.0 + (-u_xlat4);
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = u_xlat4 * 0.5 + 0.5;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat16_1.xyz = colorChargerStart.xyz * vec3(u_xlat4) + (-vec3(colorChargerStop.x, colorChargerStop.y, colorChargerStop.z));
    u_xlat16_1.xyz = vec3(vec3(ratioCharger, ratioCharger, ratioCharger)) * u_xlat16_1.xyz + vec3(colorChargerStop.x, colorChargerStop.y, colorChargerStop.z);
    u_xlat16_21 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.x);
    u_xlat16_21 = _AOPower * u_xlat16_21 + vs_TEXCOORD1.x;
    u_xlat16_2.xyz = (-_AOColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_21) * u_xlat16_2.xyz + _AOColor.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = vs_TEXCOORD6 + 0.300000012;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_7.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_7.x * u_xlat16_0.x;
    SV_Target0.w = u_xlat16_0.x * _BaseColor.w;
    return;
}

#endif
