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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM float                _Size;
	UNITY_UNIFORM mediump vec4                _Color;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
in mediump vec4 in_POSITION0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_Color0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uvec4 u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = float(uint(gl_InstanceID));
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.103100002, 0.103, 0.0973000005);
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.xyz = vec3(u_xlat9) + u_xlat0.xyz;
    u_xlat0.xw = u_xlat0.yz + u_xlat0.xx;
    u_xlat0.xy = u_xlat0.zy * u_xlat0.xw;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    {
        uint quo = uint(gl_InstanceID) / wParticleRT;
        u_xlatu1.y = quo;
    }
    u_xlatu1.x = (-u_xlatu1.y) * wParticleRT + uint(gl_InstanceID);
    u_xlat16_1 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu1.xy), int(u_xlatu1.w));
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_1.w;
    u_xlat16_2.xy = u_xlat16_2.xx * vec2(6.28318548, 3.14159274);
    u_xlat16_2.xy = sin(u_xlat16_2.xy);
    u_xlat6 = u_xlat16_2.x * _Size;
    u_xlat0.x = u_xlat0.x * u_xlat6;
    u_xlat16_2.x = u_xlat0.y + u_xlat16_1.y;
    u_xlat16_2.x = u_xlat16_2.x * 12.566371;
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + 0.5;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.y;
    vs_Color0.w = u_xlat16_2.x * _Color.w;
    u_xlat3.xyz = u_xlat16_1.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat16_1.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_1.zzz + u_xlat3.xyz;
    u_xlat1.xyz = u_xlat3.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat1.xy = in_POSITION0.xy * u_xlat0.xx + u_xlat1.xy;
    u_xlat0.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat0.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat0.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    u_xlat0.w = hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat1.w = 1.0;
    gl_Position.z = dot(u_xlat0, u_xlat1);
    u_xlat0.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat0.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat0.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    gl_Position.x = dot(u_xlat0.xyz, u_xlat1.xzw);
    u_xlat0.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat0.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat0.z = hlslcc_mtx4x4glstate_matrix_projection[3].y;
    gl_Position.y = dot(u_xlat0.xyz, u_xlat1.yzw);
    u_xlat0.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat0.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    gl_Position.w = dot(u_xlat0.xy, u_xlat1.zw);
    vs_TEXCOORD0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    vs_Color0.xyz = _Color.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_Color0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) * 2.0 + 1.0;
    u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
    SV_Target0.w = u_xlat16_0.x * vs_Color0.w;
    SV_Target0.xyz = vs_Color0.xyz;
    return;
}

#endif
