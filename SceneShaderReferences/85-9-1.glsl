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
uniform 	float time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4                _Color;
	UNITY_UNIFORM mediump float                _Size0;
	UNITY_UNIFORM mediump float                _Size1;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                radius;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump vec4 in_POSITION0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0.x = float(uint(gl_InstanceID));
    u_xlat0 = u_xlat0.xxxx * vec4(0.0973000005, 0.103, 0.109899998, 0.103100002);
    u_xlat0 = fract(u_xlat0);
    u_xlat1 = u_xlat0.zxwy + vec4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat1.x = dot(u_xlat0.wyxz, u_xlat1);
    u_xlat0 = u_xlat0 + u_xlat1.xxxx;
    u_xlat1 = u_xlat0.yxxz + u_xlat0.wwyx;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat0 = fract(u_xlat0);
    u_xlat1.x = dot(vec2(time), u_xlat0.zz);
    u_xlat15 = u_xlat0.w * 6.28318548 + u_xlat1.x;
    u_xlat15 = cos(u_xlat15);
    u_xlat15 = u_xlat15 * 0.400000006 + 0.600000024;
    u_xlat1.z = u_xlat15 * ratio;
    u_xlat1.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    phase0_Output0_0.xyz = u_xlat1.xyz;
    u_xlat0.y = sqrt(u_xlat0.y);
    u_xlat0.xy = u_xlat0.xy * vec2(6.28318548, 1.57079637);
    u_xlat1.x = sin(u_xlat0.y);
    u_xlat2.x = cos(u_xlat0.y);
    u_xlat3.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.z = u_xlat0.x;
    u_xlat1.xz = u_xlat1.xx * u_xlat3.xz;
    u_xlat1.y = u_xlat2.x;
    u_xlat0.xyw = u_xlat1.xyz * vec3(vec3(radius, radius, radius));
    u_xlat16_4.x = u_xlat0.y * 0.5 + 1.0;
    u_xlat1.xyz = u_xlat16_4.xxx * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.www + u_xlat1.xyz;
    u_xlat0.xyw = u_xlat0.xyw + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat16_4.x = (-_Size0) + _Size1;
    u_xlat16_4.x = u_xlat0.z * u_xlat16_4.x + _Size0;
    u_xlat16_4.xy = u_xlat16_4.xx * in_POSITION0.xy;
    u_xlat16_4.z = 0.0;
    u_xlat16_0.xyz = u_xlat0.xyw + u_xlat16_4.xyz;
    u_xlat16_4.xy = u_xlat16_0.xz;
    u_xlat1.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat1.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat1.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    u_xlat16_4.z = 1.0;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_4.xyz);
    u_xlat16_4.xy = u_xlat16_0.yz;
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat2.zw = hlslcc_mtx4x4glstate_matrix_projection[3].yz;
    u_xlat16_4.z = 1.0;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_4.xyz);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    u_xlat16_0.w = 1.0;
    u_xlat1.z = dot(u_xlat2, u_xlat16_0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    u_xlat1.w = dot(u_xlat2.xy, u_xlat16_0.zw);
    gl_Position = u_xlat1;
vs_TEXCOORD0 = phase0_Output0_0.xy;
vs_TEXCOORD1 = phase0_Output0_0.z;
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
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4                _Color;
	UNITY_UNIFORM mediump float                _Size0;
	UNITY_UNIFORM mediump float                _Size1;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                radius;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * vs_TEXCOORD1;
    SV_Target0.w = u_xlat16_0.x * _Color.w;
    SV_Target0.xyz = _Color.xyz;
    return;
}

#endif
