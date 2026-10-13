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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DetailAlbedoMap_ST;
uniform 	mediump float _UVSec;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlatb0 = _UVSec==0.0;
    u_xlat0.xy = (bool(u_xlatb0)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat0.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    vs_TEXCOORD8.xyz = u_xlat0.xyz;
    vs_TEXCOORD1.w = 0.0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
uniform 	mediump float _OcclusionStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _OcclusionMap;
UNITY_LOCATION(2) uniform highp sampler2D unity_NHxRoughness;
UNITY_LOCATION(3) uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_9;
float u_xlat16;
mediump float u_xlat16_17;
mediump float u_xlat16_25;
mediump float u_xlat16_29;
void main()
{
    u_xlat16_0 = texture(_OcclusionMap, vs_TEXCOORD0.xy).y;
    u_xlat16_1.x = (-_OcclusionStrength) + 1.0;
    u_xlat16_1.x = u_xlat16_0 * _OcclusionStrength + u_xlat16_1.x;
    u_xlat0.xw = (-vec2(_Glossiness)) + vec2(1.0, 1.0);
    u_xlat16_9.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_9.x = u_xlat0.x * u_xlat16_9.x;
    u_xlat16_9.x = u_xlat16_9.x * 6.0;
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_17 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = u_xlat3.xyz * (-vec3(u_xlat16_17)) + u_xlat2.xyz;
    u_xlat16_4 = textureLod(unity_SpecCube0, u_xlat16_4.xyz, u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_4.w + -1.0;
    u_xlat16_9.x = unity_SpecCube0_HDR.w * u_xlat16_9.x + 1.0;
    u_xlat16_9.x = log2(u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_9.x * unity_SpecCube0_HDR.y;
    u_xlat16_9.x = exp2(u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_9.x * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat16_4.xyz * u_xlat16_9.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat0.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
    u_xlat16 = u_xlat0.x;
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat2.xyz = u_xlat3.xyz * (-u_xlat0.xxx) + (-u_xlat2.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat0.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.yw).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_25 = (-u_xlat16) + 1.0;
    u_xlat8 = u_xlat16_25 * u_xlat16_25;
    u_xlat8 = u_xlat16_25 * u_xlat8;
    u_xlat8 = u_xlat16_25 * u_xlat8;
    u_xlat16_25 = (-_Metallic) * 0.959999979 + 0.959999979;
    u_xlat16_29 = (-u_xlat16_25) + 1.0;
    u_xlat16_29 = u_xlat16_29 + _Glossiness;
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = _Color.xyz * u_xlat16_2.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_7.xyz = vec3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat2.xyz * vec3(u_xlat16_25) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
