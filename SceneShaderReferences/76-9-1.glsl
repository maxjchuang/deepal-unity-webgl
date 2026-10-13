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
uniform 	mediump float deltaTime;
uniform 	uint numParticle;
uniform 	uint wParticleRT;
uniform 	uint wParticleExRT;
uniform 	uint indexFramePeriod;
uniform 	mediump float driving;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
UNITY_LOCATION(2) uniform mediump sampler2D ParticleExBufferRT0;
UNITY_LOCATION(3) uniform mediump sampler2D texCollision;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
uvec4 u_xlatu3;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat8;
bool u_xlatb11;
float u_xlat15;
mediump float u_xlat16_23;
mediump float u_xlat16_26;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_0 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat8 = float(u_xlatu1);
    u_xlat8 = u_xlat8 * 0.103100002;
    u_xlat8 = fract(u_xlat8);
    u_xlat15 = u_xlat8 + 33.3300018;
    u_xlat8 = u_xlat15 * u_xlat8;
    u_xlat8 = dot(vec2(u_xlat8), vec2(u_xlat8));
    u_xlat8 = fract(u_xlat8);
    u_xlat16_3 = (-u_xlat8) + 3.0;
    u_xlat16_23 = (-deltaTime) * u_xlat16_3 + u_xlat16_2.w;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlatu1 = numParticle * indexFramePeriod + u_xlatu1;
    {
        uint quo = u_xlatu1 / wParticleExRT;
        u_xlatu3.y = quo;
    }
    u_xlatu3.x = (-u_xlatu3.y) * wParticleExRT + u_xlatu1;
    u_xlatu3.z = uint(uint(0u));
    u_xlatu3.w = uint(uint(0u));
    u_xlat16_1 = texelFetch(ParticleExBufferRT0, ivec2(u_xlatu3.xy), int(u_xlatu3.w));
    u_xlatb4 = u_xlat16_23==0.0;
    u_xlatb11 = 0.0<u_xlat16_1.w;
    u_xlatb4 = u_xlatb11 && u_xlatb4;
    if(u_xlatb4){
        u_xlat16_5.x = u_xlat16_1.x;
        u_xlat16_5.y = 1.0;
        u_xlat16_5.x = dot(vec2(0.125, 0.473749995), u_xlat16_5.xy);
        u_xlat16_6.xy = u_xlat16_1.yz;
        u_xlat16_6.z = 1.0;
        u_xlat16_5.y = dot(vec3(1.49011603e-08, 0.25, 0.5), u_xlat16_6.xyz);
        u_xlat16_5.xyz = texture(texCollision, u_xlat16_5.xy).xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
        u_xlat16_26 = inversesqrt(u_xlat16_26);
        u_xlat16_5.xyz = vec3(u_xlat16_26) * u_xlat16_5.xyz;
        SV_Target0.xyz = u_xlat16_5.xyz * vec3(0.00300000003, 0.00300000003, 0.00300000003) + u_xlat16_1.xyz;
        u_xlat16_0.xyz = u_xlat16_5.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
        SV_Target0.w = 1.0;
    } else {
        u_xlatb4 = u_xlat16_2.y<0.100000001;
        u_xlat16_5.x = deltaTime * driving;
        u_xlat16_5.x = u_xlat16_5.x * 10.0 + u_xlat16_2.x;
        SV_Target0.x = (u_xlatb4) ? u_xlat16_5.x : u_xlat16_2.x;
        SV_Target0.yz = u_xlat16_2.yz;
        SV_Target0.w = u_xlat16_23;
    }
    SV_Target1 = u_xlat16_0;
    return;
}

#endif
