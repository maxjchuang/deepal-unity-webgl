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
	UNITY_UNIFORM mediump vec4                _BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_AOPower;
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
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
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
uniform 	mediump float skyRadius;
uniform 	mediump float skyTime;
uniform 	mediump vec4 colorSun;
uniform 	mediump vec2 paramY;
uniform 	mediump vec3 colorBGDefault;
uniform 	mediump vec3 colorBGCarCenter;
uniform 	mediump float ratioCarCenter;
uniform 	float timeDriving;
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
	UNITY_UNIFORM mediump vec4                _BaseMap_ST;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_BumpScale;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_AOPower;
	UNITY_UNIFORM mediump float                _Metallic;
	UNITY_UNIFORM mediump float                _Smoothness;
	UNITY_UNIFORM mediump float Xhlslcc_UnusedX_GSAA_Intensity;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _ReflMapDefault;
UNITY_LOCATION(1) uniform mediump sampler2D _LUT;
UNITY_LOCATION(2) uniform mediump sampler2D skyTex;
UNITY_LOCATION(3) uniform mediump sampler2D _BaseMap;
in mediump vec3 vs_TEXCOORD0;
centroid in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
ivec2 u_xlati3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec2 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat12;
mediump vec2 u_xlat16_19;
ivec2 u_xlati21;
mediump vec2 u_xlat16_22;
mediump vec2 u_xlat16_23;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
float u_xlat30;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_9.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16_28 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_28 = inversesqrt(u_xlat16_28);
    u_xlat16_2.xyz = vec3(u_xlat16_28) * u_xlat16_1.xyz;
    u_xlat16_1.x = (-u_xlat16_1.y) * u_xlat16_28 + 1.0;
    u_xlat16_10.x = dot((-u_xlat16_2.xyz), u_xlat16_9.xyz);
    u_xlat16_10.x = u_xlat16_10.x + u_xlat16_10.x;
    u_xlat16_10.xyz = u_xlat16_9.xyz * (-u_xlat16_10.xxx) + (-u_xlat16_2.xyz);
    u_xlat16_29 = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_29 = inversesqrt(u_xlat16_29);
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(u_xlat16_29);
    u_xlat16_29 = abs(u_xlat16_10.y) + abs(u_xlat16_10.x);
    u_xlat16_29 = abs(u_xlat16_10.z) + u_xlat16_29;
    u_xlat16_10.xyz = u_xlat16_10.xyz / vec3(u_xlat16_29);
    u_xlati3.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat16_10.xzxx).xy) * 0xFFFFFFFFu);
    u_xlati21.xy = ivec2(uvec2(lessThan(u_xlat16_10.xzxz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati3.xy = (-u_xlati3.xy) + u_xlati21.xy;
    u_xlat16_4.xy = vec2(u_xlati3.xy);
    u_xlat16_22.xy = -abs(u_xlat16_10.zx) + vec2(1.0, 1.0);
    u_xlat16_4.xy = u_xlat16_22.xy * u_xlat16_4.xy;
    u_xlatb3 = u_xlat16_10.y>=0.0;
    u_xlat16_10.xy = (bool(u_xlatb3)) ? u_xlat16_10.xz : u_xlat16_4.xy;
    u_xlat16_4.x = u_xlat16_10.x * 0.5 + 0.5;
    u_xlat16_4.y = -abs(u_xlat16_10.y) + 1.0;
    u_xlat3.x = (-timeDriving) * 0.5 + vs_TEXCOORD3.x;
    u_xlat3.y = vs_TEXCOORD3.y + 0.0599999987;
    u_xlat16_10.x = texture(_BaseMap, u_xlat3.xy).x;
    u_xlat16_5.y = u_xlat16_10.x * _Smoothness;
    u_xlat16_19.x = (-u_xlat16_5.y) * 0.699999988 + 1.70000005;
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_5.y;
    u_xlat16_19.x = u_xlat16_19.x * 6.0;
    u_xlat16_4.xyz = textureLod(_ReflMapDefault, u_xlat16_4.xy, u_xlat16_19.x).xyz;
    u_xlat16_19.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_19.x = sqrt(u_xlat16_19.x);
    u_xlat16_19.x = u_xlat16_19.x / skyRadius;
    u_xlat16_19.x = clamp(u_xlat16_19.x, 0.0, 1.0);
    u_xlat16_19.x = (-u_xlat16_19.x) + 1.0;
    u_xlat16_28 = u_xlat16_1.x * u_xlat16_19.x;
    u_xlat16_1.x = (-u_xlat16_19.x) * u_xlat16_1.x + 1.0;
    u_xlat16_19.x = u_xlat16_28 * 0.5;
    u_xlat16_28 = (-u_xlat16_28) * u_xlat16_28 + 1.0;
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_6.z = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_6.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
    u_xlat16_23.xy = u_xlat16_6.xz * vec2(0.5, 6.5) + vec2(-0.5, -0.100000001);
    u_xlat16_19.x = dot(u_xlat16_23.xy, u_xlat16_23.xy);
    u_xlat16_19.x = sqrt(u_xlat16_19.x);
    u_xlat16_19.x = min(u_xlat16_19.x, 1.0);
    u_xlat16_19.x = (-u_xlat16_19.x) + 1.0;
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_19.x = u_xlat16_19.x * u_xlat16_19.x;
    u_xlat16_19.x = u_xlat16_19.x * colorSun.w;
    u_xlat3.x = u_xlat16_28 * u_xlat16_19.x;
    u_xlat16_19.x = skyTime * 2.0 + -1.0;
    u_xlat16_19.x = abs(u_xlat16_19.x) * 0.0900000036 + 0.0599999987;
    u_xlat3.x = u_xlat16_19.x * u_xlat3.x;
    u_xlat16_7.x = 0.649999976;
    u_xlat16_7.y = skyTime;
    u_xlat16_6.xzw = texture(skyTex, u_xlat16_7.xy).xyz;
    u_xlat12.x = dot(u_xlat16_6.xzw, vec3(0.300000012, 0.5, 0.200000003));
    u_xlat12.xyz = (-u_xlat16_6.xzw) + u_xlat12.xxx;
    u_xlat12.xyz = u_xlat12.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xzw;
    u_xlat8.xyz = u_xlat12.xyz * vec3(0.420000017, 0.420000017, 0.420000017);
    u_xlat12.xyz = (-u_xlat12.xyz) * vec3(0.420000017, 0.420000017, 0.420000017) + colorSun.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat12.xyz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat3.xyz + (-_BaseColor.xyz);
    u_xlat16_19.x = u_xlat16_10.x * 0.0149999857 + 0.985000014;
    u_xlat16_10.x = (-u_xlat16_10.x) * _Smoothness + 1.0;
    u_xlat8.xyz = u_xlat16_19.xxx * u_xlat8.xyz + _BaseColor.xyz;
    u_xlat16_6.xzw = u_xlat8.xyz + vec3(-0.0399999991, -0.0399999991, -0.0399999991);
    u_xlat16_6.xzw = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xzw + vec3(0.0399999991, 0.0399999991, 0.0399999991);
    u_xlat16_5.x = dot(u_xlat16_9.xyz, u_xlat16_2.xyz);
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_9.x = dot(u_xlat16_9.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
    u_xlat16_9.xyz = u_xlat16_9.xxx * _LightColor0.xyz;
    u_xlat16_19.xy = textureLod(_LUT, u_xlat16_5.xy, 0.0).xy;
    u_xlat16_5.xyz = u_xlat16_6.xzw * u_xlat16_19.xxx + u_xlat16_19.yyy;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_19.x = (-_Metallic) * 0.959999979 + 0.959999979;
    u_xlat16_5.xyz = u_xlat16_19.xxx * u_xlat8.xyz;
    u_xlat16_9.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat16_0.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_4.xyz = u_xlat16_0.xxx * u_xlat16_4.xyz;
    u_xlat16_0.x = dot(u_xlat16_4.xyz, u_xlat16_2.xyz);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_28 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_28 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_28;
    u_xlat16_2.xyz = max(u_xlat16_10.xxx, u_xlat16_6.xzw);
    u_xlat16_2.xyz = (-u_xlat16_6.xzw) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xxx + u_xlat16_6.xzw;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_10.xyz = u_xlat16_19.xxx * u_xlat16_2.xyz;
    u_xlat16_10.xyz = clamp(u_xlat16_10.xyz, 0.0, 1.0);
    u_xlat16_10.xyz = u_xlat8.xyz * u_xlat16_10.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD1.yyy * _AmbientColor.xyz;
    u_xlat16_0.xyz = u_xlat16_10.xyz * u_xlat16_2.xyz + u_xlat16_9.xyz;
    u_xlat3.xyz = (-u_xlat16_0.xyz) + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat16_1.xxx * u_xlat3.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = (-colorBGDefault.xyz) + colorBGCarCenter.xyz;
    u_xlat16_0.xyz = vec3(vec3(ratioCarCenter, ratioCarCenter, ratioCarCenter)) * u_xlat16_0.xyz + colorBGDefault.xyz;
    u_xlat16_0.xyz = (-u_xlat3.xyz) + u_xlat16_0.xyz;
    u_xlat16_27 = paramY.xxxy.z + -0.699999988;
    u_xlat30 = u_xlat16_27 * -0.5;
    u_xlat30 = u_xlat16_6.y * paramY.xxxy.z + u_xlat30;
    u_xlat30 = paramY.xxxy.z * paramY.xxxy.w + u_xlat30;
    u_xlat16_27 = ratioCarCenter * ratioCarCenter;
    u_xlat16_27 = u_xlat16_27 * 1.80000007 + -0.200000003;
    u_xlat16_1.x = ratioCarCenter * -1.50000012 + 3.4000001;
    u_xlat16_27 = u_xlat30 * u_xlat16_1.x + u_xlat16_27;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat16_27 = (-u_xlat16_27) + 1.0;
    u_xlat16_1.x = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = (-u_xlat16_27) * 2.0 + 3.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.x;
    SV_Target0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz + u_xlat3.xyz;
    SV_Target0.w = _BaseColor.w;
    return;
}

#endif
