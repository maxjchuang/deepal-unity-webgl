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
uniform 	int enable;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
vec3 u_xlat1;
uint u_xlatu1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec2 u_xlat16_8;
bool u_xlatb10;
vec3 u_xlat12;
mediump vec3 u_xlat16_15;
mediump float u_xlat16_23;
float u_xlat28;
bool u_xlatb28;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlat1.xz = vec2(uvec2(u_xlatu1));
    u_xlat2 = u_xlat1.zzzz * vec4(0.0973000005, 0.103, 0.109899998, 0.103100002);
    u_xlat2 = fract(u_xlat2);
    u_xlat3 = u_xlat2.zxwy + vec4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat28 = dot(u_xlat2.wyxz, u_xlat3);
    u_xlat2 = vec4(u_xlat28) + u_xlat2;
    u_xlat3 = u_xlat2.yxxz + u_xlat2.wwyx;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = fract(u_xlat2);
    u_xlat28 = u_xlat2.y * 6.28318548;
    u_xlat3.x = sin(u_xlat28);
    u_xlat4.x = cos(u_xlat28);
    u_xlat4.z = u_xlat3.x;
    u_xlat28 = sqrt(u_xlat2.x);
    u_xlat2.xy = vec2(u_xlat28) * u_xlat4.xz;
    u_xlat3.xz = u_xlat2.xy * vec2(10.0, 10.0);
    u_xlat3.y = 0.0;
    u_xlat16_5.xy = u_xlat2.wz * vec2(4.0, 6.28318548);
    u_xlat16_23 = u_xlat2.w * 0.0400000066 + 0.159999996;
    u_xlatb28 = u_xlat16_5.x<time;
    u_xlat2.x = time * 2.0 + u_xlat16_5.y;
    u_xlat16_5.x = sin(u_xlat2.x);
    u_xlat16_6.x = cos(u_xlat2.x);
    u_xlatb2 = enable!=0;
    u_xlatb28 = u_xlatb28 && u_xlatb2;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_0 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_15.xyz = (bool(u_xlatb28)) ? u_xlat3.xyz : u_xlat16_2.xyz;
    u_xlat16_7.x = u_xlat16_5.x * deltaTime;
    u_xlat16_7.z = u_xlat16_6.x * deltaTime;
    u_xlat16_7.y = deltaTime;
    u_xlat16_5.xyw = u_xlat16_7.xyz * vec3(0.300000012, -1.0, 0.300000012) + u_xlat16_0.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyw * vec3(deltaTime) + u_xlat16_2.xyz;
    u_xlat16_8.x = (-deltaTime) * u_xlat16_23 + u_xlat16_2.w;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlatb3 = u_xlat16_8.x==0.0;
    SV_Target0.xyz = (bool(u_xlatb3)) ? u_xlat16_15.xyz : u_xlat16_7.xyz;
    u_xlat1.y = time;
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.103100002, 0.103, 0.0973000005);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat12.xyz = u_xlat1.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
    u_xlat12.x = dot(u_xlat1.xyz, u_xlat12.xyz);
    u_xlat1.xyz = u_xlat1.xyz + u_xlat12.xxx;
    u_xlat12.xy = u_xlat1.yz + u_xlat1.xx;
    u_xlat1.xy = u_xlat1.zy * u_xlat12.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlatb10 = 0.5<u_xlat1.y;
    u_xlat16_23 = u_xlat1.x * 0.100000024 + 0.899999976;
    u_xlat16_23 = u_xlat16_23 * 3.5;
    u_xlat16_6.y = (u_xlatb28) ? u_xlat16_23 : u_xlat16_0.y;
    u_xlat16_7.y = (u_xlatb10) ? 1.0 : 0.0;
    u_xlat16_7.x = 1.0;
    u_xlat16_8.y = u_xlat16_0.w;
    u_xlat16_6.xz = (bool(u_xlatb28)) ? vec2(0.0, 0.0) : u_xlat16_0.xz;
    u_xlat16_7.xy = (bool(u_xlatb28)) ? u_xlat16_7.xy : u_xlat16_8.xy;
    u_xlat16_7.xy = (bool(u_xlatb3)) ? u_xlat16_7.xy : u_xlat16_8.xy;
    SV_Target1.xyz = (bool(u_xlatb3)) ? u_xlat16_6.xyz : u_xlat16_5.xyw;
    SV_Target0.w = u_xlat16_7.x;
    SV_Target1.w = u_xlat16_7.y;
    return;
}

#endif
