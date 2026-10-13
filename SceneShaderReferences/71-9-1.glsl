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
uvec4 u_xlatu0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
vec4 u_xlat3;
float u_xlat12;
void main()
{
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    {
        uint quo = uint(gl_InstanceID) / wParticleRT;
        u_xlatu0.y = quo;
    }
    u_xlatu0.x = (-u_xlatu0.y) * wParticleRT + uint(gl_InstanceID);
    u_xlat16_1 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_2 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).w;
    u_xlat0.xyz = u_xlat16_1.yyy * hlslcc_mtx4x4mtxMV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4mtxMV[0].xyz * u_xlat16_1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4mtxMV[2].xyz * u_xlat16_1.zzz + u_xlat0.xyz;
    u_xlat16_1.x = (-u_xlat16_1.w) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.28318548;
    u_xlat16_1.x = cos(u_xlat16_1.x);
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4mtxMV[3].xyz;
    u_xlat12 = (-u_xlat16_1.x) * 0.5 + 1.5;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 0.5;
    u_xlat12 = u_xlat12 * _Size;
    u_xlat0.xy = in_POSITION0.xy * vec2(u_xlat12) + u_xlat0.xy;
    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4x4mtxP[1];
    u_xlat3 = hlslcc_mtx4x4mtxP[0] * u_xlat0.xxxx + u_xlat3;
    u_xlat0 = hlslcc_mtx4x4mtxP[2] * u_xlat0.zzzz + u_xlat3;
    gl_Position = u_xlat0 + hlslcc_mtx4x4mtxP[3];
    u_xlat16_0 = (-color0) + color1;
    u_xlat16_0 = vec4(u_xlat16_2) * u_xlat16_0 + color0;
    u_xlat3.x = u_xlat16_1.x * u_xlat16_0.w;
    vs_Color0.xyz = u_xlat16_0.xyz;
    vs_Color0.w = u_xlat3.x;
    u_xlat3.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat3.xy;
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
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) * 2.0 + 1.0;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_1 * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * ratio;
    u_xlat16_0.x = u_xlat16_0.x * ratioSpringFestival;
    SV_Target0.w = u_xlat16_0.x * vs_Color0.w;
    SV_Target0.xyz = vs_Color0.xyz;
    return;
}

#endif
