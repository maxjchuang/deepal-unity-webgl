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
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4                _WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
uniform 	mediump float skyTime;
uniform 	mediump vec3 skyColor;
uniform 	mediump float isDarkTheme;
uniform 	mediump float densitySkySystem;
uniform 	float _GlobalTime;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4                _WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4                _Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4                _FlatCloudsParams;
	UNITY_UNIFORM vec4                _FlatCloudsTiling;
	UNITY_UNIFORM vec4                _FlatCloudsAnimation;
	UNITY_UNIFORM mediump vec4                _FlatCloudsLightingParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D skyTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FlatCloudsBaseTexture;
UNITY_LOCATION(2) uniform mediump sampler2D _FlatCloudsDetailTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_14;
mediump float u_xlat16_21;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_21 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_0.xyz = vec3(u_xlat16_21) * u_xlat16_0.xyz;
    u_xlat16_21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_21 = inversesqrt(u_xlat16_21);
    u_xlat16_1.xyz = vec3(u_xlat16_21) * _WorldSpaceLightPos0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, (-u_xlat16_0.xyz));
    u_xlat16_7.x = u_xlat16_0.x * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = dot(u_xlat16_0.xx, _FlatCloudsLightingParams.ww);
    u_xlat16_14.x = (-_FlatCloudsLightingParams.w) * _FlatCloudsLightingParams.w + 1.0;
    u_xlat2.x = u_xlat16_14.x * 0.119366206;
    u_xlat16_14.xy = _FlatCloudsLightingParams.ww * _FlatCloudsLightingParams.ww + vec2(2.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat16_14.x;
    u_xlat16_0.x = (-u_xlat16_0.x) + u_xlat16_14.y;
    u_xlat16_0.x = log2(abs(u_xlat16_0.x));
    u_xlat16_0.x = u_xlat16_0.x * 1.5;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat16_7.x / u_xlat16_0.x;
    u_xlat16_7.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
    u_xlat16_1 = (-vs_TEXCOORD2.zyzy) * u_xlat16_7.xxxx + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * vec4(0.0250000004, -0.0250000004, 0.0250000004, -0.0250000004);
    u_xlat2.x = vs_TEXCOORD0.y;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * 0.800000012;
    u_xlat2.yw = exp2(u_xlat2.xx);
    u_xlat3.x = _Time.y * 0.300000012;
    u_xlat3.x = _GlobalTime * 20.0 + u_xlat3.x;
    u_xlat3 = u_xlat3.xxxx * _FlatCloudsAnimation;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat4 = u_xlat2.zwzw * _FlatCloudsTiling.xxyy + u_xlat3;
    u_xlat16_5 = textureLod(_FlatCloudsBaseTexture, u_xlat4.xy, 0.0);
    u_xlat4.xy = u_xlat4.zw + u_xlat4.zw;
    u_xlat16_7.xyz = textureLod(_FlatCloudsDetailTexture, u_xlat4.xy, 0.0).xyz;
    u_xlat16_7.x = dot(u_xlat16_7.xyz, vec3(0.625, 0.25, 0.125));
    u_xlat16_14.x = dot(u_xlat16_5.yzw, vec3(0.625, 0.25, 0.125));
    u_xlat16_21 = (-u_xlat16_14.x) + u_xlat16_5.x;
    u_xlat16_14.x = (-u_xlat16_14.x) + 2.0;
    u_xlat16_21 = u_xlat16_21 + 1.0;
    u_xlat16_14.x = u_xlat16_21 / u_xlat16_14.x;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_21 = (-u_xlat16_7.x) * 0.5 + 1.0;
    u_xlat16_7.x = log2(abs(u_xlat16_7.x));
    u_xlat16_7.x = u_xlat16_7.x * 0.400000006;
    u_xlat16_7.x = exp2(u_xlat16_7.x);
    u_xlat16_14.x = u_xlat16_14.x * _FlatCloudsParams.x + (-u_xlat16_21);
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat16_14.x = u_xlat16_14.x / u_xlat16_21;
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_14.x;
    u_xlat16_7.x = u_xlat16_7.x * _FlatCloudsParams.y;
    u_xlat16_14.x = u_xlat16_7.x * 0.199999988 + 0.800000012;
    u_xlat1 = (-u_xlat16_1) * u_xlat16_14.xxxx + u_xlat2;
    u_xlat1 = u_xlat1 * _FlatCloudsTiling.xxyy + u_xlat3;
    u_xlat16_2 = textureLod(_FlatCloudsBaseTexture, u_xlat1.xy, 0.0);
    u_xlat3.xy = u_xlat1.zw + u_xlat1.zw;
    u_xlat16_5.xyz = textureLod(_FlatCloudsDetailTexture, u_xlat3.xy, 0.0).xyz;
    u_xlat16_14.x = dot(u_xlat16_5.xyz, vec3(0.625, 0.25, 0.125));
    u_xlat16_21 = dot(u_xlat16_2.yzw, vec3(0.625, 0.25, 0.125));
    u_xlat16_5.x = (-u_xlat16_21) + u_xlat16_2.x;
    u_xlat16_21 = (-u_xlat16_21) + 2.0;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
    u_xlat16_21 = u_xlat16_5.x / u_xlat16_21;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_14.x) * 0.5 + 1.0;
    u_xlat16_14.x = log2(abs(u_xlat16_14.x));
    u_xlat16_14.x = u_xlat16_14.x * 0.400000006;
    u_xlat16_14.x = exp2(u_xlat16_14.x);
    u_xlat16_21 = u_xlat16_21 * _FlatCloudsParams.x + (-u_xlat16_5.x);
    u_xlat16_5.x = (-u_xlat16_5.x) + 1.0;
    u_xlat16_21 = u_xlat16_21 / u_xlat16_5.x;
    u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
    u_xlat16_14.x = u_xlat16_14.x * u_xlat16_21;
    u_xlat16_14.x = u_xlat16_14.x * _FlatCloudsParams.y + 3.0;
    u_xlat16_14.x = u_xlat16_14.x * 0.166666672;
    u_xlat16_21 = u_xlat16_14.x * _FlatCloudsLightingParams.z;
    u_xlat16_21 = exp2((-u_xlat16_21));
    u_xlat16_0.x = dot(u_xlat16_0.xx, vec2(u_xlat16_21));
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_21;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_14.x;
    u_xlat16_0.x = u_xlat16_0.x * 32.0;
    u_xlat3.x = vs_TEXCOORD0.y * 4.80000019;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat3.x = (-u_xlat3.x) + 1.0;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.y = skyTime;
    u_xlat16_5.xyz = texture(skyTex, u_xlat3.xy).xyz;
    u_xlat16_14.x = isDarkTheme * -0.5 + 1.0;
    u_xlat16_6.xyz = u_xlat16_14.xxx * skyColor.xyz;
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(6.0, 6.0, 6.0));
    u_xlat3.x = dot(u_xlat16_6.xyz, vec3(0.330000013, 0.330000013, 0.330000013));
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + u_xlat3.xxx;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = (-u_xlat3.xxx) + u_xlat16_6.xyz;
    u_xlat16_14.x = skyTime * 2.0 + -1.0;
    u_xlat16_6.xyz = abs(u_xlat16_14.xxx) * u_xlat16_6.xyz + u_xlat3.xxx;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_0.xxx + u_xlat16_5.xyz;
    u_xlat16_0.x = vs_TEXCOORD2.y * 0.100000001;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_14.x = u_xlat16_0.x * u_xlat16_7.x;
    u_xlat16_0.x = u_xlat16_7.x * u_xlat16_0.x + 0.200000003;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_14.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    SV_Target0.w = u_xlat16_0.x * densitySkySystem;
    return;
}

#endif
