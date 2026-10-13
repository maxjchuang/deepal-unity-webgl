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
uniform 	mediump vec3 skyColor;
uniform 	mediump float densitySkySystem;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3                _WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
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
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(2) uniform mediump sampler2D ParticleBufferRT1;
in mediump vec4 in_POSITION0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
uvec4 u_xlatu1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump float u_xlat16_16;
mediump float u_xlat16_24;
float u_xlat27;
void main()
{
    u_xlat16_0.xy = in_POSITION0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat16_0.xy;
    u_xlat16_0.x = skyColor.y * 0.400000006;
    u_xlat16_0.x = min(u_xlat16_0.x, 2.0);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    vs_TEXCOORD1.xyz = u_xlat16_0.xxx * _Color.xyz;
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    {
        uint quo = uint(gl_InstanceID) / wParticleRT;
        u_xlatu1.y = quo;
    }
    u_xlatu1.x = (-u_xlatu1.y) * wParticleRT + uint(gl_InstanceID);
    u_xlat16_2 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu1.xy), int(u_xlatu1.w));
    u_xlat16_1 = texelFetch(ParticleBufferRT1, ivec2(u_xlatu1.xy), int(u_xlatu1.w));
    u_xlat16_0.xzw = u_xlat16_2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_0.x = dot(u_xlat16_0.xzw, u_xlat16_0.xzw);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) * 0.0599999987 + 1.10000002;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_16 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.200000003;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_16 = (-u_xlat16_1.w) + 1.0;
    u_xlat16_16 = u_xlat16_16 * 6.28318548;
    u_xlat16_16 = cos(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * -0.5 + 0.5;
    u_xlat16_24 = u_xlat16_2.w * 0.100000001;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + (-u_xlat16_24);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x * _Alpha;
    u_xlat16_0.x = u_xlat16_0.x * densitySkySystem;
    u_xlat16_0.x = u_xlat16_0.x * _Color.w;
    vs_TEXCOORD1.w = u_xlat16_0.x * 0.400000006;
    u_xlat3.x = float(uint(gl_InstanceID));
    u_xlat3 = u_xlat3.xxxx * vec4(0.103100002, 0.103, 0.0973000005, 0.109899998);
    u_xlat3 = fract(u_xlat3);
    u_xlat4 = u_xlat3.wzxy + vec4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat27 = dot(u_xlat3, u_xlat4);
    u_xlat3.xyz = vec3(u_xlat27) + u_xlat3.xyz;
    u_xlat3.xw = u_xlat3.yz + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.zy * u_xlat3.xw;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat16_5.x = u_xlat3.x * 0.0999999642 + 0.600000024;
    u_xlat16_0.x = u_xlat3.y * 2.0 + 6.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_24 = sqrt(u_xlat16_16);
    u_xlat16_16 = inversesqrt(u_xlat16_16);
    u_xlat16_6.xyz = vec3(u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_16 = u_xlat16_1.w * 10.0;
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
    u_xlat16_16 = u_xlat16_16 * _Size;
    u_xlat16_5.y = u_xlat16_24 * u_xlat16_0.x;
    u_xlat16_0.xz = vec2(u_xlat16_16) * u_xlat16_5.xy;
    u_xlat16_5.xyz = (-u_xlat16_2.zxy) + _WorldSpaceCameraPos.zxy;
    u_xlat16_24 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_7.xyz = (-u_xlat16_6.yzx) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.zxy * (-u_xlat16_6.zxy) + (-u_xlat16_7.xyz);
    u_xlat16_24 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.z;
    u_xlat16_8 = (-u_xlat16_0.y) + 2.0;
    u_xlat16_0.xzw = (-u_xlat16_6.xyz) * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * in_POSITION0.xxx;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_8) + u_xlat16_0.xzw;
    u_xlat1 = u_xlat16_0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat16_0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat16_0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0 * vs_TEXCOORD1;
    return;
}

#endif
