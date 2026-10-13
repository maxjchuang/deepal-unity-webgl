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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	uint wParticleRT;
uniform 	mediump vec3 skyColor;
uniform 	mediump float densitySkySystem;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4                _Color;
	UNITY_UNIFORM mediump float                _Size;
	UNITY_UNIFORM mediump float                _Alpha;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
in mediump vec4 in_POSITION0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
uvec4 u_xlatu0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    {
        uint quo = uint(gl_InstanceID) / wParticleRT;
        u_xlatu0.y = quo;
    }
    u_xlatu0.x = (-u_xlatu0.y) * wParticleRT + uint(gl_InstanceID);
    u_xlat16_1 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).w;
    u_xlat16_0 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_1 = u_xlat16_1 * 3.14159274;
    u_xlat16_1 = sin(u_xlat16_1);
    u_xlat16_5.xyz = u_xlat16_0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = sqrt(u_xlat16_5.x);
    u_xlat16_5.x = (-u_xlat16_5.x) * 0.0599999987 + 1.20000005;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_5.x = u_xlat16_5.x + 0.200000003;
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_9 = u_xlat16_0.w * 0.5;
    u_xlat16_1 = u_xlat16_5.x * u_xlat16_1 + (-u_xlat16_9);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat16_1 = u_xlat16_1 * densitySkySystem;
    vs_TEXCOORD1.w = u_xlat16_1 * _Color.w;
    u_xlat16_1 = skyColor.y * 0.400000006;
    u_xlat16_1 = min(u_xlat16_1, 2.0);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    vs_TEXCOORD1.xyz = vec3(u_xlat16_1) * _Color.xyz;
    u_xlat2.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat16_0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat2.x = float(uint(gl_InstanceID));
    u_xlat1 = u_xlat2.xxxx * vec4(0.103100002, 0.103, 0.0973000005, 0.109899998);
    u_xlat1 = fract(u_xlat1);
    u_xlat2 = u_xlat1.wzxy + vec4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat2.x = dot(u_xlat1, u_xlat2);
    u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xxx;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat16_3 = u_xlat2.x * 0.300000072 + 0.899999976;
    u_xlat16_3 = u_xlat16_3 * _Size;
    u_xlat0.xy = in_POSITION0.xy * vec2(u_xlat16_3) + u_xlat0.xy;
    u_xlat1.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat1.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat1.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    u_xlat1.w = hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat0.w = 1.0;
    gl_Position.z = dot(u_xlat1, u_xlat0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    gl_Position.x = dot(u_xlat2.xyz, u_xlat0.xzw);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].y;
    gl_Position.y = dot(u_xlat2.xyz, u_xlat0.yzw);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    gl_Position.w = dot(u_xlat2.xy, u_xlat0.zw);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    SV_Target0.w = u_xlat16_0.x * vs_TEXCOORD1.w;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
