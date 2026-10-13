#ifdef VERTEX
#version 300 es

in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    vs_TEXCOORD0.xy = in_POSITION0.xy;
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(0.0, 1.0);
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
uniform 	mediump float isDarkTheme;
uniform 	mediump vec4 skyColorOverride;
uniform 	int mipmap;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3                _AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_WorldSpaceCameraPos;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump samplerCube _MainTexCube;
UNITY_LOCATION(1) uniform mediump sampler2D skyTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec3 SV_Target0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0.y = skyTime;
    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(-1.0, 1.0);
    u_xlat1.z = -1.0;
    u_xlat16_6 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16_6 = inversesqrt(u_xlat16_6);
    u_xlat16_0.x = (-vs_TEXCOORD0.y) * u_xlat16_6 + 0.899999976;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_6 = vs_TEXCOORD0.y * u_xlat16_6 + 1.0;
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
    u_xlat16_6 = u_xlat16_6 * u_xlat16_6;
    u_xlat16_2.xyz = texture(skyTex, u_xlat16_0.xy).xyz;
    u_xlat16_0.x = u_xlat16_0.x * 0.200000018 + 0.100000001;
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_3.x = u_xlat16_2.y + u_xlat16_2.x;
    u_xlat16_3.x = u_xlat16_2.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * 0.333000004 + 9.99999975e-05;
    u_xlat16_3.xyz = u_xlat16_2.xyz / u_xlat16_3.xxx;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) + skyColorOverride.xyz;
    u_xlat16_3.xyz = skyColorOverride.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_AmbientColor.yyy) * vec3(0.899999976, 0.899999976, 0.899999976) + u_xlat16_3.xyz;
    u_xlat16_2.x = _AmbientColor.y * 0.899999976;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat16_2.xxx;
    u_xlat16_0.w = u_xlat16_0.z * 1.05999994;
    u_xlat16_0.xyz = log2(abs(u_xlat16_0.xyw));
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.45449999, 0.45449999, 0.45449999);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat10 = float(mipmap);
    u_xlat16_1.xyz = textureLod(_MainTexCube, u_xlat1.xyz, u_xlat10).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_1.xyz + (-u_xlat16_1.xyz);
    u_xlat16_9 = (-skyColorOverride.w) + 1.0;
    u_xlat16_9 = u_xlat16_9 * 0.200000003;
    u_xlat16_2.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlatb10 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(isDarkTheme);
    u_xlat16_2.xyz = (bool(u_xlatb10)) ? u_xlat16_2.xyz : u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    return;
}

#endif
