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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DetailAlbedoMap_ST;
uniform 	mediump float _UVSec;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlatb1 = _UVSec==0.0;
    u_xlat1.xy = (bool(u_xlatb1)) ? in_TEXCOORD0.xy : in_TEXCOORD1.xy;
    vs_TEXCOORD0.zw = u_xlat1.xy * _DetailAlbedoMap_ST.xy + _DetailAlbedoMap_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat10 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat2.xyz;
    vs_TEXCOORD1.w = 0.0;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    vs_TEXCOORD2 = u_xlat1.wwwx;
    vs_TEXCOORD3 = u_xlat1.wwwy;
    vs_TEXCOORD4.w = u_xlat1.z;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD4.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD6 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToShadow[16];
uniform 	vec4 _LightShadowData;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	float _Glossiness;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform highp sampler2D _LightTexture0;
UNITY_LOCATION(2) uniform highp sampler2D _LightTextureB0;
UNITY_LOCATION(3) uniform highp sampler2D unity_NHxRoughness;
UNITY_LOCATION(4) uniform highp sampler2D _ShadowMapTexture;
UNITY_LOCATION(5) uniform highp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0 = vs_TEXCOORD5.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD5.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD5.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat12 = texture(_LightTexture0, u_xlat1.xy).w;
    u_xlatb1 = 0.0<u_xlat0.z;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat12 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat0 = vs_TEXCOORD5.yyyy * hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[0] * vs_TEXCOORD5.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_WorldToShadow[2] * vs_TEXCOORD5.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToShadow[3];
    u_xlat0.xyz = u_xlat0.xyz / u_xlat0.www;
    vec3 txVec0 = vec3(u_xlat0.xy,u_xlat0.z);
    u_xlat0.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
    u_xlat4.x = (-_LightShadowData.x) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat4.x + _LightShadowData.x;
    u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat0.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat12) * u_xlat16_2.xyz;
    u_xlat12 = dot((-vs_TEXCOORD1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-vs_TEXCOORD1.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Glossiness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = _Color.xyz * u_xlat16_4.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.959999979 + 0.959999979;
    u_xlat16_3.xyz = u_xlat4.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
