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
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	uint wParticleRT;
uniform 	uint startID;
uniform 	uint endID;
uniform 	mediump vec4 timePeriod;
uniform 	mediump float driving;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
UNITY_LOCATION(2) uniform mediump sampler2D texCollision;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
mediump vec4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat10;
float u_xlat12;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_24;
mediump float u_xlat16_33;
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
    u_xlat10.xyz = u_xlat10.xxx * vec3(0.0973000005, 0.103, 0.103100002);
    u_xlat10.xyz = fract(u_xlat10.xyz);
    u_xlat3.xyz = u_xlat10.yxz + vec3(33.3300018, 33.3300018, 33.3300018);
    u_xlat3.x = dot(u_xlat10.zyx, u_xlat3.xyz);
    u_xlat10.xyz = u_xlat10.xyz + u_xlat3.xxx;
    u_xlat3.xyz = u_xlat10.yxx + u_xlat10.zzy;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xyz;
    u_xlat10.xyz = fract(u_xlat10.xyz);
    u_xlat16_0.w = (-deltaTime) * 0.150000006 + u_xlat16_0.w;
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
    u_xlatb3 = u_xlat16_0.w==0.0;
    if(u_xlatb3){
        u_xlatb3 = u_xlatu1>=startID;
        u_xlatb1 = u_xlatu1<endID;
        u_xlatb1 = u_xlatb1 && u_xlatb3;
        u_xlat3.x = sqrt(u_xlat10.y);
        u_xlat12 = u_xlat10.z * 6.28318548;
        u_xlat4 = sin(u_xlat12);
        u_xlat5.x = cos(u_xlat12);
        u_xlat5.z = u_xlat4;
        u_xlat3.xy = u_xlat3.xx * u_xlat5.xz;
        u_xlat16_6.x = driving * -6.0;
        u_xlat16_6.y = float(4.0);
        u_xlat16_6.z = float(0.0);
        u_xlat16_6.xz = u_xlat3.xy * vec2(7.5, 7.5) + u_xlat16_6.xz;
        u_xlat16_2.xyz = (bool(u_xlatb1)) ? u_xlat16_6.xyz : u_xlat16_2.xyz;
        u_xlat16_0.w = 0.0;
        u_xlat16_0 = (bool(u_xlatb1)) ? vec4(0.0, -0.100000001, 0.0, 1.0) : u_xlat16_0;
        u_xlat16_2.w = 0.0;
    } else {
        u_xlatb1 = u_xlat16_2.y<0.100000001;
        if(u_xlatb1){
            u_xlat16_6.x = deltaTime * driving;
            u_xlat16_2.x = u_xlat16_6.x * 10.0 + u_xlat16_2.x;
            u_xlat16_2.w = u_xlat16_2.w + deltaTime;
        } else {
            u_xlat16_6.x = u_xlat16_2.x;
            u_xlat16_6.y = 1.0;
            u_xlat16_6.x = dot(vec2(0.125, 0.473749995), u_xlat16_6.xy);
            u_xlat16_7.xy = u_xlat16_2.yz;
            u_xlat16_7.z = 1.0;
            u_xlat16_6.y = dot(vec3(1.49011603e-08, 0.25, 0.5), u_xlat16_7.xyz);
            u_xlat16_24 = dot(vec3(-0.333333403, 1.98682208e-08, 0.833333373), u_xlat16_7.xyz);
            u_xlat16_6.x = textureLod(texCollision, u_xlat16_6.xy, 0.0).w;
            u_xlatb1 = u_xlat16_6.x<u_xlat16_24;
            u_xlat16_3.x = u_xlat16_2.w + deltaTime;
            u_xlat10.xyz = u_xlat16_0.www + u_xlat10.xyz;
            u_xlat10.xyz = u_xlat10.xyz * vec3(6.28318548, 6.28318548, 6.28318548);
            u_xlat10.xyz = u_xlat16_2.xyz * vec3(16.3999996, 16.7999992, 17.6000004) + u_xlat10.xyz;
            u_xlat16_6.xyz = u_xlat10.xyz + timePeriod.yyy;
            u_xlat16_16.x = cos(u_xlat16_6.x);
            u_xlat16_6.xy = sin(u_xlat16_6.yz);
            u_xlat16_17.x = driving * 1.5 + 0.150000006;
            u_xlat16_17.y = float(-0.800000012);
            u_xlat16_17.z = float(0.0);
            u_xlat16_16.yz = u_xlat16_6.xy * vec2(0.699999988, 1.0);
            u_xlat16_6.xyz = u_xlat16_16.xyz + u_xlat16_17.xyz;
            u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(deltaTime) + u_xlat16_0.xyz;
            u_xlat16_33 = (-deltaTime) + 1.0;
            u_xlat16_4.yzw = vec3(u_xlat16_33) * u_xlat16_6.xyz;
            u_xlat16_6.xyz = u_xlat16_4.yzw * vec3(deltaTime) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_6.xyz;
            u_xlat16_3.y = float(0.0);
            u_xlat16_3.z = float(0.0);
            u_xlat16_3.w = float(0.0);
            u_xlat16_4.x = u_xlat16_2.w;
            u_xlat16_1 = (bool(u_xlatb1)) ? u_xlat16_3 : u_xlat16_4;
            u_xlat16_0.xyz = u_xlat16_1.yzw;
            u_xlat16_2.w = u_xlat16_1.x;
        }
    }
    SV_Target0 = u_xlat16_2;
    SV_Target1 = u_xlat16_0;
    return;
}

#endif
