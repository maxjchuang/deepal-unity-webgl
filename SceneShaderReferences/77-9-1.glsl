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
uniform 	uint wParticleRT;
uniform 	vec4 hlslcc_mtx4x4mtxMV[4];
uniform 	vec4 hlslcc_mtx4x4mtxP[4];
uniform 	mediump vec4 color0;
uniform 	mediump vec4 color1;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump float                _Size;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
in highp vec4 in_POSITION0;
out mediump vec4 vs_Color0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
uvec4 u_xlatu1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.x = float(uint(gl_InstanceID));
    u_xlat0.x = u_xlat0.x * 0.103100002;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4.x = u_xlat0.x + 33.3300018;
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlat0.x = dot(u_xlat0.xx, u_xlat0.xx);
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 0.800000012 + 0.200000003;
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    {
        uint quo = uint(gl_InstanceID) / wParticleRT;
        u_xlatu1.y = quo;
    }
    u_xlatu1.x = (-u_xlatu1.y) * wParticleRT + uint(gl_InstanceID);
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu1.xy), int(u_xlatu1.w));
    u_xlat16_3 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu1.xy), int(u_xlatu1.w)).w;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.w;
    u_xlat0.x = u_xlat0.x * _Size;
    u_xlat4.xyz = u_xlat16_2.yyy * hlslcc_mtx4x4mtxMV[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4mtxMV[0].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4mtxMV[2].xyz * u_xlat16_2.zzz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz + hlslcc_mtx4x4mtxMV[3].xyz;
    u_xlat0.xy = in_POSITION0.xy * u_xlat0.xx + u_xlat4.xy;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4mtxP[1];
    u_xlat1 = hlslcc_mtx4x4mtxP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4mtxP[2] * u_xlat4.zzzz + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4mtxP[3];
    u_xlat16_0 = (-color0) + color1;
    vs_Color0 = vec4(u_xlat16_3) * u_xlat16_0 + color0;
    u_xlat1.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat1.xy;
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
uniform 	mediump float ratio;
uniform 	mediump float ratioSpringFestival;
in mediump vec4 vs_Color0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) * 2.0 + 1.0;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlat16_0.x = u_xlat16_0.x * ratio;
    u_xlat16_0.x = u_xlat16_0.x * ratioSpringFestival;
    SV_Target0.w = u_xlat16_0.x * vs_Color0.w;
    SV_Target0.xyz = vs_Color0.xyz;
    return;
}

#endif
