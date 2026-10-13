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
uniform 	mediump float driving;
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
UNITY_LOCATION(2) uniform mediump sampler2D texCollision;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_22;
bool u_xlatb24;
mediump float u_xlat16_25;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlatu0.xy = uvec2(hlslcc_FragCoord.xy);
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_1 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_2 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_3.w = (-deltaTime) * 0.25 + u_xlat16_2.w;
    u_xlat16_3.w = clamp(u_xlat16_3.w, 0.0, 1.0);
    u_xlatb16 = u_xlat16_3.w==0.0;
    if(u_xlatb16){
        u_xlatu0.x = u_xlatu0.y * wParticleRT + u_xlatu0.x;
        u_xlat8.x = float(u_xlatu0.x);
        u_xlat8.xyz = u_xlat8.xxx * vec3(0.103100002, 0.103, 0.0973000005);
        u_xlat8.xyz = fract(u_xlat8.xyz);
        u_xlat4.xyz = u_xlat8.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
        u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
        u_xlat8.xyz = u_xlat8.xyz + u_xlat4.xxx;
        u_xlat4.xy = u_xlat8.zz + u_xlat8.xy;
        u_xlat8.xy = u_xlat8.yx * u_xlat4.xy;
        u_xlat8.xy = fract(u_xlat8.xy);
        u_xlatb24 = u_xlatu0.x>=startID;
        u_xlatb0 = u_xlatu0.x<endID;
        u_xlatb0 = u_xlatb0 && u_xlatb24;
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat16 = u_xlat8.y * 6.28318548;
        u_xlat4.x = sin(u_xlat16);
        u_xlat5.x = cos(u_xlat16);
        u_xlat5.z = u_xlat4.x;
        u_xlat8.xy = u_xlat8.xx * u_xlat5.xz;
        u_xlat16_6.x = driving * -2.0 + 0.5;
        u_xlat16_6.y = float(4.0);
        u_xlat16_6.z = float(0.0);
        u_xlat16_6.xz = u_xlat8.xy * vec2(7.5, 7.5) + u_xlat16_6.xz;
        u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_1.xyz;
        u_xlat16_2.w = 0.0;
        u_xlat16_3 = (bool(u_xlatb0)) ? vec4(0.0, -0.100000001, 0.0, 1.0) : u_xlat16_2;
        u_xlat16_4.w = 0.0;
    } else {
        u_xlat16_6.x = u_xlat16_1.x;
        u_xlat16_6.y = 1.0;
        u_xlat16_6.x = dot(vec2(0.125, 0.473749995), u_xlat16_6.xy);
        u_xlat16_7.xy = u_xlat16_1.yz;
        u_xlat16_7.z = 1.0;
        u_xlat16_6.y = dot(vec3(1.49011603e-08, 0.25, 0.5), u_xlat16_7.xyz);
        u_xlat16_22 = dot(vec3(-0.333333403, 1.98682208e-08, 0.833333373), u_xlat16_7.xyz);
        u_xlat16_0 = textureLod(texCollision, u_xlat16_6.xy, 0.0);
        u_xlat16_6.xyw = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_7.x = dot(u_xlat16_6.xyw, u_xlat16_6.xyw);
        u_xlat16_7.x = inversesqrt(u_xlat16_7.x);
        u_xlat16_6.xyw = u_xlat16_6.xyw * u_xlat16_7.xxx;
        u_xlatb5 = u_xlat16_0.w<u_xlat16_22;
        u_xlat16_22 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
        u_xlat16_22 = sqrt(u_xlat16_22);
        u_xlat16_7.xyz = vec3(u_xlat16_22) * u_xlat16_6.xyw;
        u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(deltaTime) + u_xlat16_1.xyz;
        u_xlat16_6.xyz = u_xlat16_6.xyw * vec3(0.5, 0.5, 0.5);
        u_xlat16_0.yzw = u_xlat16_2.xyz * vec3(0.400000006, 0.400000006, 0.400000006) + u_xlat16_6.xyz;
        u_xlat16_0.x = u_xlat16_1.w + deltaTime;
        u_xlat16_1.xyz = (bool(u_xlatb5)) ? u_xlat16_7.xyz : u_xlat16_1.xyz;
        u_xlat16_2.w = u_xlat16_1.w;
        u_xlat16_4 = (bool(u_xlatb5)) ? u_xlat16_0.yzwx : u_xlat16_2;
        u_xlat16_25 = driving * 4.0 + 1.0;
        u_xlat16_2.x = u_xlat16_25 * deltaTime;
        u_xlat16_2.yz = vec2(deltaTime);
        u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.5, -2.5, 0.0) + u_xlat16_4.xyz;
        u_xlat16_25 = (-deltaTime) + 1.0;
        u_xlat16_3.xyz = vec3(u_xlat16_25) * u_xlat16_2.xyz;
        u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(deltaTime) + u_xlat16_1.xyz;
    }
    SV_Target0 = u_xlat16_4;
    SV_Target1 = u_xlat16_3;
    return;
}

#endif
