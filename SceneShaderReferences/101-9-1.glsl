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
uniform 	uint wParticleExRT;
uniform 	uint numParticleEx;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
UNITY_LOCATION(2) uniform mediump sampler2D ParticleExBufferRT0;
UNITY_LOCATION(3) uniform mediump sampler2D ParticleExBufferRT1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
float u_xlat1;
int u_xlati1;
uint u_xlatu1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
uvec4 u_xlatu3;
mediump vec4 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat10;
int u_xlati10;
float u_xlat19;
float u_xlat28;
int u_xlati28;
bool u_xlatb28;
mediump float u_xlat16_29;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_0 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat10.x = float(u_xlatu1);
    u_xlat19 = u_xlat10.x * 0.103100002;
    u_xlat19 = fract(u_xlat19);
    u_xlat28 = u_xlat19 + 33.3300018;
    u_xlat19 = u_xlat28 * u_xlat19;
    u_xlat19 = dot(vec2(u_xlat19), vec2(u_xlat19));
    u_xlat19 = fract(u_xlat19);
    u_xlat19 = u_xlat19 * 0.486111164 + 0.625;
    u_xlat19 = (-deltaTime) * u_xlat19 + u_xlat16_2.w;
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
    u_xlatb28 = u_xlat19==0.0;
    if(u_xlatb28){
        {
            uint rem = u_xlatu1 % numParticleEx;
            u_xlatu1 = rem;
        }
        {
            uint quo = u_xlatu1 / wParticleExRT;
            u_xlatu3.y = quo;
        }
        u_xlatu3.x = (-u_xlatu3.y) * wParticleExRT + u_xlatu1;
        u_xlatu3.z = uint(uint(0u));
        u_xlatu3.w = uint(uint(0u));
        u_xlat16_4 = texelFetch(ParticleExBufferRT0, ivec2(u_xlatu3.xy), int(u_xlatu3.w));
        u_xlat16_5.xy = texelFetch(ParticleExBufferRT1, ivec2(u_xlatu3.xy), int(u_xlatu3.w)).wy;
        u_xlat16_29 = u_xlat16_4.w + -0.300000012;
        u_xlati1 = int((0.0<u_xlat16_5.y) ? 0xFFFFFFFFu : uint(0));
        u_xlati28 = int((u_xlat16_5.y<0.0) ? 0xFFFFFFFFu : uint(0));
        u_xlati1 = (-u_xlati1) + u_xlati28;
        u_xlati1 = max((-u_xlati1), u_xlati1);
        u_xlat1 = float(u_xlati1);
        u_xlat1 = u_xlat1 * 0.0199999996;
        u_xlatb1 = abs(u_xlat16_29)<u_xlat1;
        u_xlat3.xz = u_xlat10.xx * vec2(0.0973000005, 0.103100002);
        u_xlat3.y = time * 0.103;
        u_xlat3.xyz = fract(u_xlat3.xyz);
        u_xlat6.xyz = u_xlat3.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
        u_xlat10.x = dot(u_xlat3.zyx, u_xlat6.xyz);
        u_xlat3.xyz = u_xlat10.xxx + u_xlat3.xyz;
        u_xlat6.xyz = u_xlat3.yxx + u_xlat3.zzy;
        u_xlat3.xyz = u_xlat3.xyz * u_xlat6.xyz;
        u_xlat3.xyz = fract(u_xlat3.xyz);
        u_xlat10.xz = u_xlat3.yy * vec2(2.0, 2.0) + vec2(-1.0, -0.999999881);
        u_xlat10.x = sqrt(abs(u_xlat10.x));
        u_xlat10.x = u_xlat10.x * 1.57079637;
        u_xlat6.x = sin(u_xlat10.x);
        u_xlat7.x = cos(u_xlat10.x);
        u_xlati10 = int((0.0<u_xlat10.z) ? 0xFFFFFFFFu : uint(0));
        u_xlati28 = int((u_xlat10.z<0.0) ? 0xFFFFFFFFu : uint(0));
        u_xlati10 = (-u_xlati10) + u_xlati28;
        u_xlat10.x = float(u_xlati10);
        u_xlat7.y = u_xlat10.x * u_xlat7.x;
        u_xlat10.x = u_xlat3.x * 6.28318548;
        u_xlat3.x = sin(u_xlat10.x);
        u_xlat8.x = cos(u_xlat10.x);
        u_xlat8.z = u_xlat3.x;
        u_xlat7.xz = u_xlat6.xx * u_xlat8.xz;
        u_xlat16_29 = u_xlat3.z * u_xlat3.z;
        u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
        u_xlat16_29 = u_xlat16_29 * 0.5 + 1.0;
        u_xlat3.xyz = vec3(u_xlat16_29) * u_xlat7.xyz;
        u_xlat16_4.xyz = (bool(u_xlatb1)) ? u_xlat16_4.xyz : u_xlat16_2.xyz;
        u_xlat16_0.xyz = (bool(u_xlatb1)) ? u_xlat3.xyz : u_xlat16_0.xyz;
        u_xlat16_29 = 1.0;
        u_xlat16_4.w = (u_xlatb1) ? u_xlat16_29 : 0.0;
        u_xlat16_0.w = (u_xlatb1) ? u_xlat16_5.x : u_xlat16_0.w;
    } else {
        u_xlat0.xyz = vec3(deltaTime) * vec3(0.0, -0.5, 0.0) + u_xlat16_0.xyz;
        u_xlat16_4.xyz = u_xlat0.xyz * vec3(deltaTime) + u_xlat16_2.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
        u_xlat16_4.w = u_xlat19;
    }
    SV_Target0 = u_xlat16_4;
    SV_Target1 = u_xlat16_0;
    return;
}

#endif
