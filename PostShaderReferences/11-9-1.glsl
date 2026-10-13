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
uniform 	vec2 _rcpFrame;
uniform 	float sharpness;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec2 u_xlat5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + _rcpFrame.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat0 = _rcpFrame.xyxy * vec4(-1.0, 1.0, 0.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat0.zw).xyz;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat4.xyz = u_xlat16_0.xyz * vec3(9.0, 9.0, 9.0) + (-u_xlat16_3.xyz);
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat1 = _rcpFrame.xyxy * vec4(-1.0, 0.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat1.zw).xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat16_3.xyz) + u_xlat4.xyz;
    u_xlat5.xy = vs_TEXCOORD0.xy + (-_rcpFrame.xy);
    u_xlat16_2.xyz = texture(_MainTex, u_xlat5.xy).xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat1 = _rcpFrame.xyxy * vec4(0.0, -1.0, 1.0, -1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = texture(_MainTex, u_xlat1.zw).xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat16_3.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
    u_xlat4.xyz = (-u_xlat16_0.xyz) + u_xlat4.xyz;
    u_xlat4.xyz = vec3(sharpness) * u_xlat4.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    SV_Target0.xyz = u_xlat4.xyz;
    return;
}

#endif
