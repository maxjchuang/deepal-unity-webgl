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
	UNITY_UNIFORM mediump vec4                _AOColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_SpecColor;
	UNITY_UNIFORM mediump vec4                _EmissionColor;
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
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
ivec2 u_xlati6;
bool u_xlatb6;
mediump vec2 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec2 u_xlat16_22;
ivec2 u_xlati26;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat16_0.xyz = _EmissionColor.xyz + vec3(-20.0, -20.0, -20.0);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_EmissionColor.xyz);
    u_xlat16_0.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_0.xyz + _EmissionColor.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD0.xyz + (-pointLight.xyz);
    u_xlat16_30 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_30 = sqrt(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * 0.200000003;
    u_xlat16_30 = min(u_xlat16_30, 1.0);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_1.x = colorSun.w * pointLight.w;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_1.x;
    u_xlat16_30 = u_xlat16_30 * 4.0;
    u_xlat16_1.xyz = vec3(u_xlat16_30) * colorSun.xyz;
    u_xlat16_30 = dot(_BaseColor.xyz, vec3(0.300000012, 0.5, 0.200000003));
    u_xlat16_30 = u_xlat16_30 + 0.699999988;
    u_xlat16_30 = float(1.0) / u_xlat16_30;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_30) + _LightColor0.xyz;
    u_xlat16_30 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * vs_TEXCOORD2.xyz;
    u_xlat16_31 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_3.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_31 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_3.xyz = vec3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_31 = dot((-u_xlat16_3.xyz), u_xlat16_2.xyz);
    u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
    u_xlat16_4.xyz = u_xlat16_2.xyz * (-vec3(u_xlat16_31)) + (-u_xlat16_3.xyz);
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_3.xyz);
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_31 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = inversesqrt(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_4.xyz;
    u_xlat16_31 = abs(u_xlat16_4.y) + abs(u_xlat16_4.x);
    u_xlat16_31 = abs(u_xlat16_4.z) + u_xlat16_31;
    u_xlat16_5.xyz = u_xlat16_4.xyz / vec3(u_xlat16_31);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_5.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati26.xy = ivec2(uvec2(lessThan(u_xlat16_5.xzxz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati26.xy;
    u_xlat16_22.xy = vec2(u_xlati6.xy);
    u_xlat16_7.xy = -abs(u_xlat16_5.zx) + vec2(1.0, 1.0);
    u_xlat16_22.xy = u_xlat16_22.xy * u_xlat16_7.xy;
    u_xlatb6 = u_xlat16_5.y>=0.0;
    u_xlat16_22.xy = (bool(u_xlatb6)) ? u_xlat16_5.xz : u_xlat16_22.xy;
    u_xlat16_5.x = u_xlat16_22.x * 0.5 + 0.5;
    u_xlat16_5.y = -abs(u_xlat16_22.y) + 1.0;
    u_xlat16_31 = (-_Smoothness) + 0.400000006;
    u_xlat16_2.y = ratioOverrideAlbedo * u_xlat16_31 + _Smoothness;
    u_xlat16_31 = (-u_xlat16_2.y) * 0.699999988 + 1.70000005;
    u_xlat16_31 = u_xlat16_31 * u_xlat16_2.y;
    u_xlat16_31 = u_xlat16_31 * 6.0;
    u_xlat16_5.xyz = textureLod(_ReflMapDefault, u_xlat16_5.xy, u_xlat16_31).xyz;
    u_xlat16_22.xy = textureLod(_LUT, u_xlat16_2.xy, 0.0).xy;
    u_xlat16_7.xy = (-u_xlat16_2.yx) + vec2(1.0, 1.0);
    u_xlat16_31 = valueOverrideMetallic + (-_Metallic);
    u_xlat16_31 = ratioOverrideMetallic * u_xlat16_31 + _Metallic;
    u_xlat16_8.xyz = vec3(vec3(valueOverrideAlbedo, valueOverrideAlbedo, valueOverrideAlbedo)) + (-_BaseColor.xyz);
    u_xlat16_8.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_8.xyz + _BaseColor.xyz;
    u_xlat16_9.xyz = u_xlat16_8.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_9.xyz = vec3(u_xlat16_31) * u_xlat16_9.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_31 = (-u_xlat16_31) * 0.959999979 + 0.959999979;
    u_xlat16_2.xzw = u_xlat16_9.xyz * u_xlat16_22.xxx + u_xlat16_22.yyy;
    u_xlat16_2.xzw = u_xlat16_2.xzw * u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz + u_xlat16_2.xzw;
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_30) + u_xlat16_3.xyz;
    u_xlat16_30 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_1.xyz = vec3(u_xlat16_30) * u_xlat16_1.xyz;
    u_xlat16_30 = dot(u_xlat16_1.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_30 = (-u_xlat16_30) + 1.0;
    u_xlat16_1.x = u_xlat16_30 * u_xlat16_30;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_1.x;
    u_xlat16_1.xyz = max(u_xlat16_7.xxx, u_xlat16_9.xyz);
    u_xlat16_1.xyz = (-u_xlat16_9.xyz) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_30) + u_xlat16_9.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat16_2.xzw = vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_2.xzw + u_xlat16_0.xyz;
    u_xlat16_1.xy = vs_TEXCOORD1.zw;
    u_xlat16_1.z = vs_TEXCOORD2.w;
    u_xlat16_30 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_1.xyz = vec3(u_xlat16_30) * u_xlat16_1.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_1.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_1.x = (-u_xlat16_30) + 1.0;
    u_xlat16_11 = vs_TEXCOORD1.x * u_xlat16_1.x + u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 + vs_TEXCOORD1.x;
    u_xlat16_30 = u_xlat16_30 + -0.800000012;
    u_xlat16_30 = u_xlat16_30 / u_xlat16_2.y;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_11 = (-u_xlat16_30) + u_xlat16_11;
    u_xlat16_11 = u_xlat16_2.y * u_xlat16_11 + u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_1.x + (-u_xlat16_11);
    u_xlat16_30 = _AOColor.w * u_xlat16_30 + u_xlat16_11;
    u_xlat16_30 = u_xlat16_30 * vs_TEXCOORD1.x;
    u_xlat6 = _Time.y * 0.5;
    u_xlat6 = fract(u_xlat6);
    u_xlat16_1.x = vs_TEXCOORD0.x * carRange.x + carRange.y;
    u_xlat16_1.x = (-u_xlat6) * 3.0 + u_xlat16_1.x;
    u_xlat16_1.x = -abs(u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_30 * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_7.y * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * vec3(0.400000006, 0.699999988, 1.60000002);
    u_xlat16_31 = u_xlat16_30 * u_xlat16_30 + (-u_xlat16_30);
    u_xlat16_30 = _AOPower * u_xlat16_31 + u_xlat16_30;
    u_xlat16_2.xyz = (-_AOColor.xyz) + vec3(0.699999988, 0.699999988, 0.699999988);
    u_xlat16_2.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_2.xyz + _AOColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = (-_BaseColor.w) + 0.300000012;
    SV_Target0.w = ratioOverrideAlbedo * u_xlat16_0.x + _BaseColor.w;
    return;
}

#endif
