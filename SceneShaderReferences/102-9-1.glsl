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
uniform 	uint numParticle;
uniform 	uint wParticleRT;
uniform 	uint wParticleExRT;
uniform 	uint numParticleEx;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
UNITY_LOCATION(2) uniform mediump sampler2D ParticleExBufferRT0;
UNITY_LOCATION(3) uniform mediump sampler2D ParticleExBufferRT1;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
uint u_xlatu1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
uint u_xlatu4;
mediump vec2 u_xlat16_5;
uvec4 u_xlatu5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat9;
mediump vec2 u_xlat16_10;
vec3 u_xlat12;
int u_xlati17;
float u_xlat23;
int u_xlati23;
uint u_xlatu23;
bool u_xlatb23;
mediump vec2 u_xlat16_27;
float u_xlat34;
uint u_xlatu34;
mediump float u_xlat16_35;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_0 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat12.x = float(u_xlatu1);
    u_xlat23 = u_xlat12.x * 0.103100002;
    u_xlat23 = fract(u_xlat23);
    u_xlat34 = u_xlat23 + 33.3300018;
    u_xlat23 = u_xlat34 * u_xlat23;
    u_xlat23 = dot(vec2(u_xlat23), vec2(u_xlat23));
    u_xlat23 = fract(u_xlat23);
    u_xlat16_3.x = u_xlat23 * 0.399999976 + 0.600000024;
    u_xlat16_3.w = (-deltaTime) * u_xlat16_3.x + u_xlat16_2.w;
    u_xlat16_3.w = clamp(u_xlat16_3.w, 0.0, 1.0);
    u_xlatb23 = u_xlat16_3.w==0.0;
    if(u_xlatb23){
        {
            uint quo = u_xlatu1 / numParticleEx;
            uint rem = u_xlatu1 % numParticleEx;
            u_xlatu1 = quo;
            u_xlatu4 = rem;
        }
        {
            uint quo = u_xlatu4 / wParticleExRT;
            u_xlatu5.y = quo;
        }
        u_xlatu5.x = (-u_xlatu5.y) * wParticleExRT + u_xlatu4;
        u_xlatu5.z = uint(uint(0u));
        u_xlatu5.w = uint(uint(0u));
        u_xlat16_4 = texelFetch(ParticleExBufferRT0, ivec2(u_xlatu5.xy), int(u_xlatu5.w));
        u_xlat16_5.y = texelFetch(ParticleExBufferRT1, ivec2(u_xlatu5.xy), int(u_xlatu5.w)).w;
        u_xlat16_35 = u_xlat16_4.w * 100.0;
        u_xlat16_35 = roundEven(u_xlat16_35);
        u_xlatu23 = uint(u_xlat16_35);
        {
            uint quo = numParticle / numParticleEx;
            u_xlatu34 = quo;
        }
        {
            uint rem = u_xlatu23 % u_xlatu34;
            u_xlatu23 = rem;
        }
        u_xlatb1 = int(u_xlatu1)==int(u_xlatu23);
        u_xlatb23 = 0.0<u_xlat16_4.w;
        u_xlatb1 = u_xlatb23 && u_xlatb1;
        u_xlat6.xz = u_xlat12.xx * vec2(0.0973000005, 0.103100002);
        u_xlat6.y = time * 0.103;
        u_xlat12.xyz = fract(u_xlat6.xyz);
        u_xlat6.xyz = u_xlat12.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
        u_xlat6.x = dot(u_xlat12.zyx, u_xlat6.xyz);
        u_xlat12.xyz = u_xlat12.xyz + u_xlat6.xxx;
        u_xlat6.xyz = u_xlat12.yxx + u_xlat12.zzy;
        u_xlat12.xyz = u_xlat12.xyz * u_xlat6.xyz;
        u_xlat12.xyz = fract(u_xlat12.xyz);
        u_xlat6.xy = u_xlat12.yy * vec2(2.0, 2.0) + vec2(-1.0, -0.999999881);
        u_xlat12.y = sqrt(abs(u_xlat6.x));
        u_xlat12.xy = u_xlat12.xy * vec2(6.28318548, 1.57079637);
        u_xlat6.x = sin(u_xlat12.y);
        u_xlat7.x = cos(u_xlat12.y);
        u_xlati23 = int((0.0<u_xlat6.y) ? 0xFFFFFFFFu : uint(0));
        u_xlati17 = int((u_xlat6.y<0.0) ? 0xFFFFFFFFu : uint(0));
        u_xlati23 = (-u_xlati23) + u_xlati17;
        u_xlat23 = float(u_xlati23);
        u_xlat7.y = u_xlat23 * u_xlat7.x;
        u_xlat8 = sin(u_xlat12.x);
        u_xlat9.x = cos(u_xlat12.x);
        u_xlat9.z = u_xlat8;
        u_xlat7.xz = u_xlat6.xx * u_xlat9.xz;
        u_xlat16_35 = u_xlat12.z * u_xlat12.z;
        u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
        u_xlat16_35 = u_xlat16_35 * 0.0500000045 + 0.100000001;
        u_xlat12.xyz = vec3(u_xlat16_35) * u_xlat7.xyz;
        u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_4.xyz : u_xlat16_2.xyz;
        u_xlat16_0.xyz = (bool(u_xlatb1)) ? u_xlat12.xyz : u_xlat16_0.xyz;
        u_xlat16_5.x = float(1.0);
        u_xlat16_27.x = float(0.0);
        u_xlat16_27.y = u_xlat16_0.w;
        u_xlat16_10.xy = (bool(u_xlatb1)) ? u_xlat16_5.xy : u_xlat16_27.xy;
        u_xlat16_3.w = u_xlat16_10.x;
        u_xlat16_0.w = u_xlat16_10.y;
    } else {
        u_xlat16_0.xyz = vec3(deltaTime) * vec3(0.0, -0.5, 0.0) + u_xlat16_0.xyz;
        u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(deltaTime) + u_xlat16_2.xyz;
    }
    SV_Target0 = u_xlat16_3;
    SV_Target1 = u_xlat16_0;
    return;
}

#endif
