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
uniform 	float flipY;
uniform 	vec4 rectRenderClip;
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec2 u_xlat1;
void main()
{
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.x = flipY * -2.0 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * rectRenderClip.zw + rectRenderClip.xy;
    gl_Position.y = u_xlat0.x * u_xlat1.y;
    gl_Position.x = u_xlat1.x;
    u_xlat0.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, -0.5) + u_xlat0.xyxy;
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
uniform 	vec4 _rcpFrameOpt;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_12;
float u_xlat13;
vec2 u_xlat15;
mediump float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat16_0.xyz = textureLod(_MainTex, vs_TEXCOORD1.zy, 0.0).xyz;
    u_xlat1 = dot(u_xlat16_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_0.x = u_xlat1 + 0.00260416674;
    u_xlat16_6.xyz = textureLod(_MainTex, vs_TEXCOORD1.xw, 0.0).xyz;
    u_xlat1 = dot(u_xlat16_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.x = (-u_xlat16_0.x) + u_xlat1;
    u_xlat16_2.xyz = textureLod(_MainTex, vs_TEXCOORD1.xy, 0.0).xyz;
    u_xlat7 = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_12 = u_xlat16_6.x + (-u_xlat7);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat7;
    u_xlat16_2.xyz = textureLod(_MainTex, vs_TEXCOORD1.zw, 0.0).xyz;
    u_xlat13 = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.x = u_xlat16_12 + u_xlat13;
    u_xlat16_2.y = u_xlat16_6.x + (-u_xlat13);
    u_xlat19 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat3.x = inversesqrt(u_xlat19);
    u_xlat19 = sqrt(u_xlat19);
    u_xlatb19 = u_xlat19<9.99999975e-06;
    u_xlat3.xy = u_xlat16_2.xy * u_xlat3.xx;
    u_xlat3.xy = (bool(u_xlatb19)) ? vec2(0.0, 0.0) : u_xlat3.xy;
    u_xlat16_6.x = min(abs(u_xlat3.y), abs(u_xlat3.x));
    u_xlat16_6.x = u_xlat16_6.x * 8.0;
    u_xlat16_6.xy = u_xlat3.xy / u_xlat16_6.xx;
    u_xlat16_6.xy = max(u_xlat16_6.xy, vec2(-2.0, -2.0));
    u_xlat16_6.xy = min(u_xlat16_6.xy, vec2(2.0, 2.0));
    u_xlat15.xy = (-u_xlat16_6.xy) * _rcpFrameOpt.xy + vs_TEXCOORD0.xy;
    u_xlat4.xy = u_xlat16_6.xy * _rcpFrameOpt.xy + vs_TEXCOORD0.xy;
    u_xlat16_6.xyz = textureLod(_MainTex, u_xlat4.xy, 0.0).xyz;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat15.xy, 0.0).xyz;
    u_xlat19 = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat15.x = dot(u_xlat16_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.w = u_xlat19 + u_xlat15.x;
    u_xlat15.xy = (-u_xlat3.xy) * _rcpFrameOpt.zw + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat3.xy * _rcpFrameOpt.zw + vs_TEXCOORD0.xy;
    u_xlat16_6.xyz = textureLod(_MainTex, u_xlat3.xy, 0.0).xyz;
    u_xlat16_5.xyz = textureLod(_MainTex, u_xlat15.xy, 0.0).xyz;
    u_xlat19 = dot(u_xlat16_5.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.x = dot(u_xlat16_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.w = u_xlat19 + u_xlat4.x;
    u_xlat16_3 = u_xlat16_3 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat16_2 = u_xlat16_2 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat16_6.x = min(u_xlat16_0.x, u_xlat13);
    u_xlat16_0.x = max(u_xlat16_0.x, u_xlat13);
    u_xlat16_12 = min(u_xlat1, u_xlat7);
    u_xlat16_18 = max(u_xlat1, u_xlat7);
    u_xlat16_0.x = max(u_xlat16_0.x, u_xlat16_18);
    u_xlatb1 = u_xlat16_0.x<u_xlat16_2.w;
    u_xlat16_0.x = min(u_xlat16_6.x, u_xlat16_12);
    u_xlatb7 = u_xlat16_2.w<u_xlat16_0.x;
    u_xlatb1 = u_xlatb1 || u_xlatb7;
    SV_Target0 = (bool(u_xlatb1)) ? u_xlat16_3 : u_xlat16_2;
    return;
}

#endif
