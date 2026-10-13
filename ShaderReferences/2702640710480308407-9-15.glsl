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
	UNITY_UNIFORM mediump float                _GSAA_Scale;
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
centroid out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
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
    u_xlat0.xyz = in_COLOR0.yzw * vec3(2.0, 2.0, 2.0) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat16_2.xyz = u_xlat0.xyw * u_xlat0.xyw;
    u_xlat16_2.x = u_xlat16_2.y * 2.0 + (-u_xlat16_2.x);
    u_xlat16_6 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.z);
    u_xlat16_6 = u_xlat16_6 * SH2.x;
    u_xlat16_2.x = (-u_xlat0.w) * u_xlat0.w + u_xlat16_2.x;
    u_xlat16_1.w = u_xlat16_2.x * 0.31539157;
    u_xlat16_2.xzw = u_xlat0.wyx * u_xlat0.xwy;
    u_xlat16_1.xyz = u_xlat16_2.xzw * vec3(1.09254849, 1.09254849, 1.09254849);
    u_xlat16_2.x = dot(SH1, u_xlat16_1);
    u_xlat16_1.yzw = u_xlat0.xyw * vec3(0.488602519, 0.488602519, 0.488602519);
    u_xlat16_1.x = 0.282094806;
    u_xlat16_10 = dot(SH0, u_xlat16_1);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_10;
    vs_TEXCOORD1.y = u_xlat16_6 * 0.546274245 + u_xlat16_2.x;
    u_xlat16_2.x = (-in_COLOR0.x) + 2.0;
    vs_TEXCOORD1.x = u_xlat16_2.x * in_COLOR0.x;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    u_xlat3.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat3.xyz;
    vs_TEXCOORD2 = u_xlat0;
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
	UNITY_UNIFORM mediump float                _GSAA_Scale;
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
	UNITY_UNIFORM mediump vec4                _FresnelColor;
	UNITY_UNIFORM mediump vec4                _FresnelColorBlend;
	UNITY_UNIFORM mediump vec4                _BaseColor;
	UNITY_UNIFORM mediump vec4                _AOColor;
	UNITY_UNIFORM mediump vec4                _SpecColor;
	UNITY_UNIFORM mediump vec4                _EmissionColor;
	UNITY_UNIFORM mediump vec4                _ClearCoatParam;
	UNITY_UNIFORM mediump vec4                _ClearCoatColor;
	UNITY_UNIFORM mediump vec4                _ClearCoatBlend;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BumpMap_ST;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float                _AOPower;
	UNITY_UNIFORM mediump float                _Metallic;
	UNITY_UNIFORM mediump float                _Smoothness;
	UNITY_UNIFORM mediump float                _GSAA_Intensity;
	UNITY_UNIFORM int Xhlslcc_UnusedXHighlight;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _ReflMapDefault;
UNITY_LOCATION(1) uniform mediump sampler2D _LUT;
in mediump vec3 vs_TEXCOORD0;
centroid in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
ivec2 u_xlati6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec4 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat12;
ivec2 u_xlati12;
bool u_xlatb12;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_20;
mediump float u_xlat16_26;
mediump float u_xlat16_27;
ivec2 u_xlati32;
mediump vec2 u_xlat16_33;
mediump vec2 u_xlat16_34;
ivec2 u_xlati38;
mediump float u_xlat16_39;
mediump float u_xlat16_40;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
mediump float u_xlat16_43;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_39 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_39 = inversesqrt(u_xlat16_39);
    u_xlat16_1.xyz = vec3(u_xlat16_39) * u_xlat16_1.xyz;
    u_xlat16_39 = dot(u_xlat16_0.xyz, u_xlat16_1.xyz);
    u_xlat16_39 = clamp(u_xlat16_39, 0.0, 1.0);
    u_xlat16_39 = (-u_xlat16_39) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_39) * u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.25, 0.25, 0.25) + u_xlat16_0.xyz;
    u_xlat16_40 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_3.xyz = vec3(u_xlat16_40) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_40) + u_xlat16_1.xyz;
    u_xlat16_40 = dot((-u_xlat16_1.xyz), u_xlat16_3.xyz);
    u_xlat16_40 = u_xlat16_40 + u_xlat16_40;
    u_xlat16_4.xyz = u_xlat16_3.xyz * (-vec3(u_xlat16_40)) + (-u_xlat16_1.xyz);
    u_xlat16_40 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_4.xyz = vec3(u_xlat16_40) * u_xlat16_4.xyz;
    u_xlat16_40 = abs(u_xlat16_4.y) + abs(u_xlat16_4.x);
    u_xlat16_40 = abs(u_xlat16_4.z) + u_xlat16_40;
    u_xlat16_5.xyz = u_xlat16_4.xyz / vec3(u_xlat16_40);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_5.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati32.xy = ivec2(uvec2(lessThan(u_xlat16_5.xzxz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati32.xy;
    u_xlat16_7.xy = vec2(u_xlati6.xy);
    u_xlat16_33.xy = -abs(u_xlat16_5.zx) + vec2(1.0, 1.0);
    u_xlat16_7.xy = u_xlat16_33.xy * u_xlat16_7.xy;
    u_xlatb6 = u_xlat16_5.y>=0.0;
    u_xlat16_5.xy = (bool(u_xlatb6)) ? u_xlat16_5.xz : u_xlat16_7.xy;
    u_xlat16_7.x = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_7.y = -abs(u_xlat16_5.y) + 1.0;
    u_xlat16_40 = (-_Smoothness) + 0.400000006;
    u_xlat16_5.y = ratioOverrideAlbedo * u_xlat16_40 + _Smoothness;
    u_xlat16_40 = (-u_xlat16_5.y) * 0.699999988 + 1.70000005;
    u_xlat16_40 = u_xlat16_40 * u_xlat16_5.y;
    u_xlat16_40 = u_xlat16_40 * 6.0;
    u_xlat16_7.xyz = textureLod(_ReflMapDefault, u_xlat16_7.xy, u_xlat16_40).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + (-_SpecColor.www);
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(ratioOverrideAlbedo) * (-_SpecColor.xyz) + _SpecColor.xyz;
    u_xlat16_40 = valueOverrideMetallic + (-_Metallic);
    u_xlat16_40 = ratioOverrideMetallic * u_xlat16_40 + _Metallic;
    u_xlat16_6 = _FresnelColor + (-_BaseColor);
    u_xlat16_41 = u_xlat16_39 * _FresnelColorBlend.x + _FresnelColorBlend.y;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_42 = (-u_xlat16_41) + 1.0;
    u_xlat16_42 = (-u_xlat16_42) * u_xlat16_42 + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41 + (-u_xlat16_42);
    u_xlat16_41 = _FresnelColorBlend.z * u_xlat16_41 + u_xlat16_42;
    u_xlat16_6 = vec4(u_xlat16_41) * u_xlat16_6 + _BaseColor;
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(vec3(valueOverrideAlbedo, valueOverrideAlbedo, valueOverrideAlbedo));
    u_xlat16_10.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_11.xyz = u_xlat16_10.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_11.xyz = vec3(u_xlat16_40) * u_xlat16_11.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_40 = (-u_xlat16_40) * 0.959999979 + 0.959999979;
    u_xlat16_9.xyz = u_xlat16_9.xyz + (-u_xlat16_11.xyz);
    u_xlat16_8.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_11.xyz;
    u_xlat16_5.x = dot(u_xlat16_3.xyz, u_xlat16_1.xyz);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_41 = dot(u_xlat16_3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_3.xy = textureLod(_LUT, u_xlat16_5.xy, 0.0).xy;
    u_xlat16_3.xyz = u_xlat16_8.xyz * u_xlat16_3.xxx + u_xlat16_3.yyy;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_5.xzw = vs_TEXCOORD0.xyz + (-pointLight.xyz);
    u_xlat16_42 = dot(u_xlat16_5.xzw, u_xlat16_5.xzw);
    u_xlat16_42 = sqrt(u_xlat16_42);
    u_xlat16_42 = u_xlat16_42 * 0.200000003;
    u_xlat16_42 = min(u_xlat16_42, 1.0);
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_43 = colorSun.w * pointLight.w;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_43;
    u_xlat16_42 = u_xlat16_42 * 4.0;
    u_xlat16_5.xzw = vec3(u_xlat16_42) * colorSun.xyz;
    u_xlat16_42 = dot(u_xlat16_6.xyz, vec3(0.300000012, 0.5, 0.200000003));
    u_xlat16_42 = u_xlat16_42 + 0.699999988;
    u_xlat16_42 = float(1.0) / u_xlat16_42;
    u_xlat16_5.xzw = u_xlat16_5.xzw * vec3(u_xlat16_42) + _LightColor0.xyz;
    u_xlat16_5.xzw = vec3(u_xlat16_41) * u_xlat16_5.xzw;
    u_xlat16_41 = dot(u_xlat16_4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_42 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * _ClearCoatParam.z + (-_ClearCoatParam.w);
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * 4.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_42;
    u_xlat16_42 = log2(u_xlat16_42);
    u_xlat16_43 = (-u_xlat16_5.y) + 1.0;
    u_xlat16_7.x = u_xlat16_43 * u_xlat16_43;
    u_xlat16_7.x = u_xlat16_7.x * 20.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_7.x;
    u_xlat16_42 = exp2(u_xlat16_42);
    u_xlat16_7.x = (-u_xlat16_43) * 10.0 + 10.5;
    u_xlat16_20.xyz = max(u_xlat16_11.xyz, vec3(u_xlat16_43));
    u_xlat16_20.xyz = (-u_xlat16_11.xyz) + u_xlat16_20.xyz;
    u_xlat16_43 = float(1.0) / u_xlat16_7.x;
    u_xlat16_43 = u_xlat16_43 + -1.07000005;
    u_xlat16_43 = -abs(u_xlat16_43) + 1.0;
    u_xlat16_42 = u_xlat16_42 * u_xlat16_43;
    u_xlat16_41 = u_xlat16_42 * 8.0 + u_xlat16_41;
    u_xlat16_8.xyz = u_xlat16_11.xyz * vec3(u_xlat16_41);
    u_xlat16_8.xyz = u_xlat16_10.xyz * vec3(u_xlat16_40) + u_xlat16_8.xyz;
    u_xlat16_3.xyz = u_xlat16_8.xyz * u_xlat16_5.xzw + u_xlat16_3.xyz;
    u_xlat16_41 = dot((-u_xlat16_1.xyz), u_xlat16_0.xyz);
    u_xlat16_41 = u_xlat16_41 + u_xlat16_41;
    u_xlat16_5.xzw = u_xlat16_0.xyz * (-vec3(u_xlat16_41)) + (-u_xlat16_1.xyz);
    u_xlat16_41 = dot(u_xlat16_5.xzw, u_xlat16_5.xzw);
    u_xlat16_41 = inversesqrt(u_xlat16_41);
    u_xlat16_5.xzw = vec3(u_xlat16_41) * u_xlat16_5.xzw;
    u_xlat16_41 = abs(u_xlat16_5.z) + abs(u_xlat16_5.x);
    u_xlat16_41 = abs(u_xlat16_5.w) + u_xlat16_41;
    u_xlat16_5.xzw = u_xlat16_5.xzw / vec3(u_xlat16_41);
    u_xlati12.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_5.xwxx).xy) * 0xFFFFFFFFu);
    u_xlati38.xy = ivec2(uvec2(lessThan(u_xlat16_5.xwxw, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati12.xy = (-u_xlati12.xy) + u_xlati38.xy;
    u_xlat16_8.xy = vec2(u_xlati12.xy);
    u_xlat16_34.xy = -abs(u_xlat16_5.wx) + vec2(1.0, 1.0);
    u_xlat16_8.xy = u_xlat16_34.xy * u_xlat16_8.xy;
    u_xlatb12 = u_xlat16_5.z>=0.0;
    u_xlat16_5.xz = (bool(u_xlatb12)) ? u_xlat16_5.xw : u_xlat16_8.xy;
    u_xlat16_8.x = u_xlat16_5.x * 0.5 + 0.5;
    u_xlat16_8.y = -abs(u_xlat16_5.z) + 1.0;
    u_xlat16_5.xz = vec2(ratioOverrideAlbedo) * (-_ClearCoatParam.xy) + _ClearCoatParam.xy;
    u_xlat16_8.xyz = textureLod(_ReflMapDefault, u_xlat16_8.xy, u_xlat16_5.x).xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz * u_xlat16_8.xyz + (-u_xlat16_8.xyz);
    u_xlat16_5.xzw = u_xlat16_5.zzz * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8 = (-_ClearCoatColor) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_8 = vec4(ratioOverrideAlbedo) * u_xlat16_8 + _ClearCoatColor;
    u_xlat16_5.xzw = u_xlat16_5.xzw * u_xlat16_8.xyz;
    u_xlat16_8.xyz = vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_5.xzw = u_xlat16_5.xzw * u_xlat16_8.xyz;
    u_xlat16_41 = u_xlat16_39 * _ClearCoatBlend.x + _ClearCoatBlend.y;
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
    u_xlat16_42 = (-u_xlat16_41) + 1.0;
    u_xlat16_42 = (-u_xlat16_42) * u_xlat16_42 + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41 + (-u_xlat16_42);
    u_xlat16_41 = _ClearCoatBlend.z * u_xlat16_41 + u_xlat16_42;
    u_xlat16_42 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = (-u_xlat16_41) * 2.0 + 3.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_42;
    u_xlat16_42 = (-u_xlat16_8.w) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_42 + u_xlat16_8.w;
    u_xlat16_3.xyz = u_xlat16_5.xzw * vec3(u_xlat16_41) + u_xlat16_3.xyz;
    u_xlat16_5.xzw = _EmissionColor.xyz + vec3(-20.0, -20.0, -20.0);
    u_xlat16_5.xzw = max(u_xlat16_5.xzw, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xzw = u_xlat16_5.xzw + (-_EmissionColor.xyz);
    u_xlat16_5.xzw = vec3(ratioOverrideAlbedo) * u_xlat16_5.xzw + _EmissionColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xzw;
    u_xlat16_5.xzw = dFdx(u_xlat16_0.xyz);
    u_xlat16_0.xyz = dFdy(u_xlat16_0.xyz);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_13 = dot(u_xlat16_5.xzw, u_xlat16_5.xzw);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_13;
    u_xlat16_0.x = u_xlat16_0.x * _GSAA_Intensity;
    u_xlat16_0.x = u_xlat16_0.x * _GSAA_Scale;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.333000004;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_13 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_13 = inversesqrt(u_xlat16_13);
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz;
    u_xlat16_13 = dot(u_xlat16_2.xyz, u_xlat16_1.xyz);
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat16_26 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_26 = u_xlat16_26 * u_xlat16_26;
    u_xlat16_13 = u_xlat16_26 * u_xlat16_13;
    u_xlat16_1.xyz = u_xlat16_20.xyz * vec3(u_xlat16_13) + u_xlat16_11.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_40) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_10.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xy = vs_TEXCOORD1.zw;
    u_xlat16_1.z = vs_TEXCOORD2.w;
    u_xlat16_40 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_40 = inversesqrt(u_xlat16_40);
    u_xlat16_1.xyz = vec3(u_xlat16_40) * u_xlat16_1.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_1.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_14.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_27 = vs_TEXCOORD1.x * u_xlat16_14.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x + vs_TEXCOORD1.x;
    u_xlat16_1.x = u_xlat16_1.x + -0.800000012;
    u_xlat16_1.x = u_xlat16_1.x / u_xlat16_5.y;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_14.x;
    u_xlat16_14.x = (-u_xlat16_14.x) * u_xlat16_14.x + 1.0;
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_14.x;
    u_xlat16_27 = (-u_xlat16_1.x) + u_xlat16_27;
    u_xlat16_27 = u_xlat16_5.y * u_xlat16_27 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_14.x + (-u_xlat16_27);
    u_xlat16_1.x = _AOColor.w * u_xlat16_1.x + u_xlat16_27;
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat12 = _Time.y * 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_14.x = vs_TEXCOORD0.x * carRange.x + carRange.y;
    u_xlat16_14.x = (-u_xlat12) * 3.0 + u_xlat16_14.x;
    u_xlat16_14.x = -abs(u_xlat16_14.x) + 1.0;
    u_xlat16_14.x = max(u_xlat16_14.x, 0.0);
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_14.x;
    u_xlat16_14.x = u_xlat16_1.x * u_xlat16_14.x;
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_14.x;
    u_xlat16_39 = u_xlat16_39 * u_xlat16_14.x;
    u_xlat16_14.xyz = vec3(u_xlat16_39) * vec3(0.400000006, 0.699999988, 1.60000002);
    u_xlat16_39 = u_xlat16_1.x * u_xlat16_1.x + (-u_xlat16_1.x);
    u_xlat16_39 = _AOPower * u_xlat16_39 + u_xlat16_1.x;
    u_xlat16_2.xyz = (-_AOColor.xyz) + vec3(0.699999988, 0.699999988, 0.699999988);
    u_xlat16_2.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_2.xyz + _AOColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_39) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat16_14.xyz;
    u_xlat16_0.x = (-u_xlat16_6.w) + 0.600000024;
    SV_Target0.w = ratioOverrideAlbedo * u_xlat16_0.x + u_xlat16_6.w;
    return;
}

#endif
