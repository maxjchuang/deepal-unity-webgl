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
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
uint u_xlatu1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
uvec4 u_xlatu3;
mediump vec4 u_xlat16_4;
uint u_xlatu4;
vec3 u_xlat5;
uint u_xlatu5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat11;
int u_xlati11;
float u_xlat21;
float u_xlat31;
int u_xlati31;
uint u_xlatu31;
bool u_xlatb31;
mediump float u_xlat16_32;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_0 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat11.x = float(u_xlatu1);
    u_xlat21 = u_xlat11.x * 0.103100002;
    u_xlat21 = fract(u_xlat21);
    u_xlat31 = u_xlat21 + 33.3300018;
    u_xlat21 = u_xlat31 * u_xlat21;
    u_xlat21 = dot(vec2(u_xlat21), vec2(u_xlat21));
    u_xlat21 = fract(u_xlat21);
    u_xlat16_3.x = u_xlat21 * 0.399999976 + 1.60000002;
    u_xlat21 = (-deltaTime) * u_xlat16_3.x + u_xlat16_2.w;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlatb31 = u_xlat21==0.0;
    if(u_xlatb31){
        {
            uint quo = u_xlatu1 / numParticleEx;
            uint rem = u_xlatu1 % numParticleEx;
            u_xlatu1 = quo;
            u_xlatu4 = rem;
        }
        {
            uint quo = u_xlatu4 / wParticleExRT;
            u_xlatu3.y = quo;
        }
        u_xlatu3.x = (-u_xlatu3.y) * wParticleExRT + u_xlatu4;
        u_xlatu3.z = uint(uint(0u));
        u_xlatu3.w = uint(uint(0u));
        u_xlat16_4 = texelFetch(ParticleExBufferRT0, ivec2(u_xlatu3.xy), int(u_xlatu3.w));
        u_xlat16_3 = texelFetch(ParticleExBufferRT1, ivec2(u_xlatu3.xy), int(u_xlatu3.w)).wxyz;
        u_xlat16_32 = u_xlat16_4.w * 100.0;
        u_xlat16_32 = roundEven(u_xlat16_32);
        u_xlatu31 = uint(u_xlat16_32);
        {
            uint quo = numParticle / numParticleEx;
            u_xlatu5 = quo;
        }
        {
            uint rem = u_xlatu31 % u_xlatu5;
            u_xlatu31 = rem;
        }
        u_xlatb1 = int(u_xlatu1)==int(u_xlatu31);
        u_xlatb31 = 0.0<u_xlat16_4.w;
        u_xlatb1 = u_xlatb31 && u_xlatb1;
        u_xlat5.xz = u_xlat11.xx * vec2(0.0973000005, 0.103100002);
        u_xlat5.y = time * 0.103;
        u_xlat5.xyz = fract(u_xlat5.xyz);
        u_xlat6.xyz = u_xlat5.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
        u_xlat11.x = dot(u_xlat5.zyx, u_xlat6.xyz);
        u_xlat5.xyz = u_xlat11.xxx + u_xlat5.xyz;
        u_xlat6.xyz = u_xlat5.yxx + u_xlat5.zzy;
        u_xlat5.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat5.xyz = fract(u_xlat5.xyz);
        u_xlat11.xz = u_xlat5.yy * vec2(2.0, 2.0) + vec2(-1.0, -0.999999881);
        u_xlat11.x = sqrt(abs(u_xlat11.x));
        u_xlat11.x = u_xlat11.x * 1.57079637;
        u_xlat6.x = sin(u_xlat11.x);
        u_xlat7.x = cos(u_xlat11.x);
        u_xlati11 = int((0.0<u_xlat11.z) ? 0xFFFFFFFFu : uint(0));
        u_xlati31 = int((u_xlat11.z<0.0) ? 0xFFFFFFFFu : uint(0));
        u_xlati11 = (-u_xlati11) + u_xlati31;
        u_xlat11.x = float(u_xlati11);
        u_xlat7.y = u_xlat11.x * u_xlat7.x;
        u_xlat11.x = u_xlat5.x * 6.28318548;
        u_xlat5.x = sin(u_xlat11.x);
        u_xlat8.x = cos(u_xlat11.x);
        u_xlat8.z = u_xlat5.x;
        u_xlat7.xz = u_xlat6.xx * u_xlat8.xz;
        u_xlat16_32 = u_xlat5.z * u_xlat5.z;
        u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
        u_xlat16_32 = u_xlat16_32 * 0.0250000022 + 0.0500000007;
        u_xlat16_9.xyz = u_xlat16_3.yzw * vec3(0.400000006, 0.400000006, 0.400000006);
        u_xlat5.xyz = u_xlat7.xyz * vec3(u_xlat16_32) + u_xlat16_9.xyz;
        u_xlat16_4.xyz = (bool(u_xlatb1)) ? u_xlat16_4.xyz : u_xlat16_2.xyz;
        u_xlat16_0.xyz = (bool(u_xlatb1)) ? u_xlat5.xyz : u_xlat16_0.xyz;
        u_xlat16_32 = 1.0;
        u_xlat16_4.w = (u_xlatb1) ? u_xlat16_32 : 0.0;
        u_xlat16_0.w = (u_xlatb1) ? u_xlat16_3.x : u_xlat16_0.w;
    } else {
        u_xlat0.xyz = vec3(deltaTime) * vec3(0.0, -0.5, 0.0) + u_xlat16_0.xyz;
        u_xlat16_4.xyz = u_xlat0.xyz * vec3(deltaTime) + u_xlat16_2.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
        u_xlat16_4.w = u_xlat21;
    }
    SV_Target0 = u_xlat16_4;
    SV_Target1 = u_xlat16_0;
    return;
}

#endif
