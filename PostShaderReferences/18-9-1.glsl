#ifdef VERTEX
#version 300 es

in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_POSITION0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
uniform 	float alphaExtra;
UNITY_LOCATION(0) uniform mediump sampler2D rtExtra;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = texture(rtExtra, vs_TEXCOORD0.xy).xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = alphaExtra;
    return;
}

#endif
