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
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
float u_xlat0;
vec2 u_xlat1;
void main()
{
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0 = flipY * -2.0 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * rectRenderClip.zw + rectRenderClip.xy;
    gl_Position.y = u_xlat0 * u_xlat1.y;
    gl_Position.x = u_xlat1.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

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
uniform 	mediump vec2 _MainTex_TexelSize;
uniform 	mediump float _PrefilterOffs;
uniform 	mediump float _BloomThreshold;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.xy = _MainTex_TexelSize.xy * vec2(vec2(_PrefilterOffs, _PrefilterOffs)) + vs_TEXCOORD0.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_10 = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_10 = max(u_xlat16_1.z, u_xlat16_10);
    u_xlat16_2 = u_xlat16_10 + (-_BloomThreshold);
    u_xlat16_10 = max(u_xlat16_10, 0.00100000005);
    u_xlat16_10 = u_xlat16_2 / u_xlat16_10;
    SV_Target0.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
