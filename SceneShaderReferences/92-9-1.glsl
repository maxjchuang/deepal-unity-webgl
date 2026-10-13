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
uniform 	vec2 processRange;
in highp vec4 in_POSITION0;
vec3 u_xlat0;
void main()
{
    u_xlat0.xy = in_POSITION0.yx * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat0.x = max(u_xlat0.x, processRange.x);
    u_xlat0.z = min(u_xlat0.x, processRange.y);
    gl_Position.xy = u_xlat0.yz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    gl_Position.zw = vec2(0.0, 1.0);
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
uniform 	float time;
uniform 	mediump float deltaTime;
uniform 	uint wParticleRT;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
vec3 u_xlat1;
uint u_xlatu1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
mediump float u_xlat16_9;
float u_xlat16;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlat1.x = float(u_xlatu1);
    u_xlat1.xyz = u_xlat1.xxx * vec3(0.0973000005, 0.103, 0.103100002);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat2.xyz = u_xlat1.yxz + vec3(33.3300018, 33.3300018, 33.3300018);
    u_xlat16 = dot(u_xlat1.zyx, u_xlat2.xyz);
    u_xlat1.xyz = vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat2.xyz = u_xlat1.yxx + u_xlat1.zzy;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = u_xlat1.x * 0.600000024 + 0.600000024;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6 = u_xlat1.y * 6.28318548;
    u_xlat2.x = sin(u_xlat6);
    u_xlat3.x = cos(u_xlat6);
    u_xlat3.y = u_xlat2.x;
    u_xlat1.xy = u_xlat1.xx * u_xlat3.xy;
    u_xlat16_2.x = u_xlat1.x * 3.0;
    u_xlat16_2.z = u_xlat1.y + u_xlat1.y;
    u_xlat16_4 = u_xlat1.z * 4.0;
    u_xlat16_9 = u_xlat1.z * 0.300000012 + 0.200000003;
    u_xlat16_9 = u_xlat16_9 * deltaTime;
    u_xlatb1 = u_xlat16_4<time;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_0.xzw = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).xzw;
    u_xlat16_0.w = (-u_xlat16_9) * 1.5 + u_xlat16_0.w;
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
    u_xlat16_2.w = (u_xlatb1) ? 1.0 : u_xlat16_0.w;
    u_xlat16_4 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_0.y = u_xlat16_4 * 1.5;
    u_xlatb1 = u_xlat16_0.w==0.0;
    u_xlat16_2.y = 0.0;
    SV_Target0 = (bool(u_xlatb1)) ? u_xlat16_2 : u_xlat16_0;
    return;
}

#endif
