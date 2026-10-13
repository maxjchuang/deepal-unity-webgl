#ifdef VERTEX
#version 300 es

in highp vec4 in_POSITION0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
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
uniform 	float ratioHighlight;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4                _Color;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
void main()
{
    u_xlat0 = ratioHighlight * _Color.w;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = _Color.xyz;
    return;
}

#endif
