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
uniform 	float textX[9];
uniform 	float textY[9];
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
	UNITY_UNIFORM mediump vec4                _BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float                _AOPower;
	UNITY_UNIFORM mediump float                _Metallic;
	UNITY_UNIFORM mediump float                _Smoothness;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Intensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
centroid out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_6;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = min(in_POSITION0.x, 0.00100000005);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
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
    u_xlat16_6 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.z);
    u_xlat16_6 = u_xlat16_6 * SH2.x;
    u_xlat16_2.x = (-u_xlat0.z) * u_xlat0.z + u_xlat16_2.x;
    u_xlat16_1.w = u_xlat16_2.x * 0.31539157;
    u_xlat16_2.xzw = u_xlat0.zyx * u_xlat0.xzy;
    u_xlat16_1.xyz = u_xlat16_2.xzw * vec3(1.09254849, 1.09254849, 1.09254849);
    u_xlat16_2.x = dot(SH1, u_xlat16_1);
    u_xlat16_1.yzw = u_xlat0.xyz * vec3(0.488602519, 0.488602519, 0.488602519);
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat16_1.x = 0.282094806;
    u_xlat16_10 = dot(SH0, u_xlat16_1);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_10;
    vs_TEXCOORD1.y = u_xlat16_6 * 0.546274245 + u_xlat16_2.x;
    u_xlat16_2.x = (-in_COLOR0.x) + 2.0;
    vs_TEXCOORD1.x = u_xlat16_2.x * in_COLOR0.x;
    u_xlat0.x = in_POSITION0.x + -0.00999999978;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x * 100.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlati0 = int(u_xlat0.x);
    u_xlat3.x = textX[u_xlati0] * 0.125 + in_TEXCOORD0.x;
    u_xlat3.y = (-textY[u_xlati0]) * 0.111111112 + in_TEXCOORD0.y;
    vs_TEXCOORD3.xy = u_xlat3.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
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
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_EmissionColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatParam;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_ClearCoatBlend;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_BumpMap_ST;
	UNITY_UNIFORM mediump vec4                _BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float                _AOPower;
	UNITY_UNIFORM mediump float                _Metallic;
	UNITY_UNIFORM mediump float                _Smoothness;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Intensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _ReflMapDefault;
UNITY_LOCATION(1) uniform mediump sampler2D _LUT;
UNITY_LOCATION(2) uniform mediump sampler2D _BaseMap;
in mediump vec3 vs_TEXCOORD0;
centroid in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
ivec2 u_xlati4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec2 u_xlat16_21;
ivec2 u_xlati24;
mediump vec2 u_xlat16_25;
mediump float u_xlat16_30;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_30 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_0.xyz = vec3(u_xlat16_30) * u_xlat16_0.xyz;
    u_xlat16_30 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_1.xyz = vec3(u_xlat16_30) * vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.xyz * vec3(u_xlat16_30) + u_xlat16_0.xyz;
    u_xlat16_30 = dot((-u_xlat16_0.xyz), u_xlat16_1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_3.xyz = u_xlat16_1.xyz * (-vec3(u_xlat16_30)) + (-u_xlat16_0.xyz);
    u_xlat16_30 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_3.xyz = vec3(u_xlat16_30) * u_xlat16_3.xyz;
    u_xlat16_30 = abs(u_xlat16_3.y) + abs(u_xlat16_3.x);
    u_xlat16_30 = abs(u_xlat16_3.z) + u_xlat16_30;
    u_xlat16_3.xyz = u_xlat16_3.xyz / vec3(u_xlat16_30);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_3.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati24.xy = ivec2(uvec2(lessThan(u_xlat16_3.xzxz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati24.xy;
    u_xlat16_5.xy = vec2(u_xlati4.xy);
    u_xlat16_25.xy = -abs(u_xlat16_3.zx) + vec2(1.0, 1.0);
    u_xlat16_5.xy = u_xlat16_25.xy * u_xlat16_5.xy;
    u_xlatb4 = u_xlat16_3.y>=0.0;
    u_xlat16_3.xy = (bool(u_xlatb4)) ? u_xlat16_3.xz : u_xlat16_5.xy;
    u_xlat16_5.x = u_xlat16_3.x * 0.5 + 0.5;
    u_xlat16_5.y = -abs(u_xlat16_3.y) + 1.0;
    u_xlat16_30 = (-_Smoothness) + 0.400000006;
    u_xlat16_3.y = ratioOverrideAlbedo * u_xlat16_30 + _Smoothness;
    u_xlat16_30 = (-u_xlat16_3.y) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_3.y;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_5.xyz = textureLod(_ReflMapDefault, u_xlat16_5.xy, u_xlat16_30).xyz;
    u_xlat16_3.x = dot(u_xlat16_1.xyz, u_xlat16_0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_30 = dot(u_xlat16_1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_1.xy = textureLod(_LUT, u_xlat16_3.xy, 0.0).xy;
    u_xlat16_21.xy = (-u_xlat16_3.yx) + vec2(1.0, 1.0);
    u_xlat16_32 = valueOverrideMetallic + (-_Metallic);
    u_xlat16_32 = ratioOverrideMetallic * u_xlat16_32 + _Metallic;
    u_xlat16_3 = texture(_BaseMap, vs_TEXCOORD3.xy);
    u_xlat16_6.xyz = (-_BaseColor.xyz) * u_xlat16_3.xyz + vec3(vec3(valueOverrideAlbedo, valueOverrideAlbedo, valueOverrideAlbedo));
    u_xlat16_4 = u_xlat16_3 * _BaseColor;
    u_xlat16_3.x = (-_BaseColor.w) * u_xlat16_3.w + 0.300000012;
    SV_Target0.w = ratioOverrideAlbedo * u_xlat16_3.x + u_xlat16_4.w;
    u_xlat16_3.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_33 = dot(u_xlat16_4.xyz, vec3(0.300000012, 0.5, 0.200000003));
    u_xlat16_33 = u_xlat16_33 + 0.699999988;
    u_xlat16_33 = float(1.0) / u_xlat16_33;
    u_xlat16_6.xyz = u_xlat16_3.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xyz = vec3(u_xlat16_32) * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_32 = (-u_xlat16_32) * 0.959999979 + 0.959999979;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + u_xlat16_1.yyy;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vs_TEXCOORD0.xyz + (-pointLight.xyz);
    u_xlat16_1.x = dot(u_xlat16_7.xyz, u_xlat16_7.xyz);
    u_xlat16_1.x = sqrt(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * 0.200000003;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_11 = colorSun.w * pointLight.w;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_11;
    u_xlat16_1.x = u_xlat16_1.x * 4.0;
    u_xlat16_7.xyz = u_xlat16_1.xxx * colorSun.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(u_xlat16_33) + _LightColor0.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_10.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_0.x = u_xlat16_10.x * u_xlat16_0.x;
    u_xlat16_10.xyz = max(u_xlat16_21.xxx, u_xlat16_6.xyz);
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + u_xlat16_10.xyz;
    u_xlat16_0.xyz = u_xlat16_10.xyz * u_xlat16_0.xxx + u_xlat16_6.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = vec3(u_xlat16_32) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_30 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-vs_TEXCOORD1.x);
    u_xlat16_30 = _AOPower * u_xlat16_30 + vs_TEXCOORD1.x;
    u_xlat16_1.xyz = (-_AOColor.xyz) + vec3(0.699999988, 0.699999988, 0.699999988);
    u_xlat16_1.xyz = vec3(ratioOverrideAlbedo) * u_xlat16_1.xyz + _AOColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat9 = _Time.y * 0.5;
    u_xlat9 = fract(u_xlat9);
    u_xlat16_30 = vs_TEXCOORD0.x * carRange.x + carRange.y;
    u_xlat16_30 = (-u_xlat9) * 3.0 + u_xlat16_30;
    u_xlat16_30 = -abs(u_xlat16_30) + 1.0;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * vs_TEXCOORD1.x;
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_21.y * u_xlat16_30;
    u_xlat16_2.xyz = vec3(u_xlat16_30) * vec3(0.400000006, 0.699999988, 1.60000002);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    return;
}

#endif
