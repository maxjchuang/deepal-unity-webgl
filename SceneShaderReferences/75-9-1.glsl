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
uniform 	mediump float isDarkTheme;
uniform 	float time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4                _Color;
	UNITY_UNIFORM mediump float                _Size;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                value;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump vec4 in_POSITION0;
out mediump vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec2 u_xlat6;
bool u_xlatb6;
float u_xlat12;
float u_xlat13;
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
    u_xlat1 = u_xlat0.wwww * vec4(0.0973000005, 0.103, 0.109899998, 0.103100002);
    u_xlat1 = fract(u_xlat1);
    u_xlat2 = u_xlat1.zxwy + vec4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat2.x = dot(u_xlat1.wyxz, u_xlat2);
    u_xlat1 = u_xlat1 + u_xlat2.xxxx;
    u_xlat2 = u_xlat1.yxxz + u_xlat1.wwyx;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = fract(u_xlat1);
    u_xlat1 = u_xlat1 * vec4(6.28318548, 6.28318548, 6.28318548, 6.28318548);
    u_xlat2.x = u_xlat0.w * 0.150000006 + 0.0500000007;
    u_xlat1 = vec4(time) * u_xlat2.xxxx + u_xlat1;
    u_xlat2.xy = u_xlat1.ww * vec2(4.0, 1.27323949);
    u_xlat13 = sin(u_xlat2.x);
    u_xlat2.x = fract(u_xlat2.y);
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat16_3.x = value * ratio;
    u_xlat13 = u_xlat13 * u_xlat16_3.x;
    u_xlatb6 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(isDarkTheme);
    u_xlat6.x = (u_xlatb6) ? 0.300000012 : 1.0;
    vs_TEXCOORD1 = u_xlat13 * u_xlat6.x;
    u_xlat6.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat0.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(1.0, 0.5, 0.600000024) + vec3(0.300000012, 1.0, 0.0);
    u_xlat0.y = cos(u_xlat1.y);
    u_xlat0.xz = sin(u_xlat1.xz);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat0.x = u_xlat2.x * 0.800000012 + u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_3.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat1.x = u_xlat0.w * u_xlat0.w;
    u_xlat12 = u_xlat0.w * u_xlat1.x;
    u_xlat12 = u_xlat12 * 0.699999988 + 0.300000012;
    u_xlat12 = u_xlat12 * _Size;
    u_xlat16_3.xy = vec2(u_xlat12) * in_POSITION0.xy;
    u_xlat16_3.z = 0.0;
    u_xlat16_0.xyz = u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xy = u_xlat16_0.xz;
    u_xlat1.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat1.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat1.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    u_xlat16_3.z = 1.0;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat16_3.xyz);
    u_xlat16_3.xy = u_xlat16_0.yz;
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat2.zw = hlslcc_mtx4x4glstate_matrix_projection[3].yz;
    u_xlat16_3.z = 1.0;
    u_xlat1.y = dot(u_xlat2.xyz, u_xlat16_3.xyz);
    u_xlat2.xz = hlslcc_mtx4x4glstate_matrix_projection[2].wz;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    u_xlat16_0.w = 1.0;
    u_xlat1.w = dot(u_xlat2.xy, u_xlat16_0.zw);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat1.z = dot(u_xlat2, u_xlat16_0);
    gl_Position = u_xlat1;
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
	UNITY_UNIFORM mediump float                _Size;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                value;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * _Color.w;
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * 2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_1;
    SV_Target0.w = u_xlat16_0.x * vs_TEXCOORD1;
    SV_Target0.xyz = _Color.xyz;
    return;
}

#endif
