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
uniform 	uint numParticle;
uniform 	uint wParticleRT;
uniform 	uint rateNum;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
float u_xlat1;
uint u_xlatu1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat11;
uint u_xlatu16;
bool u_xlatb16;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlat6.x = float(u_xlatu1);
    u_xlat6.xyz = u_xlat6.xxx * vec3(0.103100002, 0.103, 0.0973000005);
    u_xlat6.xyz = fract(u_xlat6.xyz);
    u_xlat2.xyz = u_xlat6.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat6.xyz = u_xlat6.xyz + u_xlat2.xxx;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.yx * u_xlat2.xy;
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat11 = u_xlat6.y * 6.28318548;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat2.x = sin(u_xlat11);
    u_xlat3.x = cos(u_xlat11);
    u_xlat3.z = u_xlat2.x;
    u_xlat6.xy = u_xlat6.xx * u_xlat3.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(7.5, 7.5);
    u_xlatu16 = numParticle + (-rateNum);
    u_xlatb16 = u_xlatu16<u_xlatu1;
    u_xlatb2 = u_xlatu1<numParticle;
    u_xlatu1 = (-u_xlatu1) + numParticle;
    u_xlat1 = float(u_xlatu1);
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).wxyz;
    u_xlat16_0 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).wxyz;
    SV_Target0.xz = (bool(u_xlatb16)) ? u_xlat6.xy : u_xlat16_2.yw;
    u_xlat6.x = float(rateNum);
    u_xlat1 = u_xlat1 / u_xlat6.x;
    u_xlat1 = min(u_xlat1, 1.0);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat16_4.x = u_xlat1 * 4.0;
    SV_Target0.y = (u_xlatb16) ? u_xlat16_4.x : u_xlat16_2.z;
    SV_Target0.w = (u_xlatb16) ? 0.0 : u_xlat16_2.x;
    u_xlat16_4.x = (-u_xlat1) + 1.0;
    u_xlat16_4.y = u_xlat16_4.x * -2.5 + -0.100000001;
    u_xlat16_4.x = float(0.0);
    u_xlat16_4.z = float(0.0);
    SV_Target1.xyz = (bool(u_xlatb16)) ? u_xlat16_4.xyz : u_xlat16_0.yzw;
    SV_Target1.w = (u_xlatb16) ? u_xlat1 : u_xlat16_0.x;
    return;
}

#endif
