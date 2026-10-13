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
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
bool u_xlatb1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.y>=u_xlat16_0.z;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_7.xy = (-u_xlat16_0.zy) + u_xlat16_0.yz;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat16_7.xy + u_xlat16_0.zy;
    u_xlat16_3.xy = (-u_xlat16_2.xy);
    u_xlat16_3.z = (-u_xlat16_0.x);
    u_xlat16_4.yz = u_xlat16_2.yx + u_xlat16_3.yz;
    u_xlat16_4.x = u_xlat16_0.x + u_xlat16_3.x;
    u_xlatb1 = u_xlat16_0.x>=u_xlat16_2.x;
    u_xlat16_12 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xy = vec2(u_xlat16_12) * u_xlat16_4.xy + u_xlat16_2.xy;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_7.x = min(u_xlat16_2.y, u_xlat16_12);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x + 1.00000001e-10;
    u_xlat16_2.x = u_xlat16_7.x / u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_7.x = dot(u_xlat16_0.xyz, vec3(0.209999993, 0.709999979, 0.0700000003));
    u_xlat16_7.x = u_xlat16_7.x * 10.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz;
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_0.xyz) + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
