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
uniform 	mediump float densitySkySystem;
uniform 	mediump float driving;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4                _WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_WorldSpaceCameraPos;
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
UNITY_LOCATION(0) uniform mediump sampler2D ParticleBufferRT0;
UNITY_LOCATION(1) uniform mediump sampler2D ParticleBufferRT1;
in mediump vec4 in_POSITION0;
out mediump float vs_TEXCOORD2;
mediump  vec4 phase0_Output0_0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uvec4 u_xlatu0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_14;
float u_xlat18;
void main()
{
    u_xlat0.x = float(uint(gl_InstanceID));
    u_xlat0.xyz = u_xlat0.xxx * vec3(0.103100002, 0.103, 0.0973000005);
    u_xlat0.xyz = fract(u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.yzx + vec3(33.3300018, 33.3300018, 33.3300018);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.xyz = vec3(u_xlat18) + u_xlat0.xyz;
    u_xlat0.xw = u_xlat0.yz + u_xlat0.xx;
    u_xlat0.xy = u_xlat0.zy * u_xlat0.xw;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.zw = in_POSITION0.xy + vec2(0.5, 0.5);
    phase0_Output0_0.xyz = u_xlat0.yzw;
    u_xlat16_2 = u_xlat0.x * 1.5 + 1.5;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    {
        uint quo = uint(gl_InstanceID) / wParticleRT;
        u_xlatu0.y = quo;
    }
    u_xlatu0.x = (-u_xlatu0.y) * wParticleRT + uint(gl_InstanceID);
    u_xlat16_1 = texelFetch(ParticleBufferRT0, ivec2(u_xlatu0.xy), int(u_xlatu0.w));
    u_xlat16_8.xyz = texelFetch(ParticleBufferRT1, ivec2(u_xlatu0.xy), int(u_xlatu0.w)).xyz;
    u_xlat16_8.xyz = u_xlat16_8.yzx * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_1.w;
    u_xlat16_3.x = u_xlat16_3.x * 3.14159274;
    u_xlat16_3.x = sin(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_3.x;
    u_xlat16_3.xy = vec2(u_xlat16_2) * in_POSITION0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(_Size);
    u_xlat16_4.xyz = u_xlat16_1.zxy * u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_1.yzx * u_xlat16_8.yzx + (-u_xlat16_4.xyz);
    u_xlat16_2 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2 = inversesqrt(u_xlat16_2);
    u_xlat16_4.xyz = vec3(u_xlat16_2) * u_xlat16_4.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_1.w) + 1.0;
    u_xlat16_2 = u_xlat16_2 * 3.14159274;
    u_xlat16_2 = sin(u_xlat16_2);
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_4.zxy;
    u_xlat16_4.xyz = u_xlat16_4.yzx * u_xlat16_8.yzx + (-u_xlat16_5.xyz);
    u_xlat16_14 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_14);
    u_xlat16_4.xyz = vec3(u_xlat16_14) * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.yyy * u_xlat16_4.xyz + u_xlat16_3.xzw;
    u_xlat16_14 = (-u_xlat16_3.y) + 0.5;
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
    u_xlat16_14 = u_xlat16_14 + _Color.w;
    u_xlat16_4.x = (-driving);
    u_xlat16_4.y = 1.0;
    u_xlat16_8.x = dot(u_xlat16_8.zx, u_xlat16_4.xy);
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_8.x = u_xlat16_8.x * _Alpha;
    u_xlat16_2 = u_xlat16_8.x * u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_14;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    vs_TEXCOORD1.w = u_xlat16_2 * densitySkySystem;
    vs_TEXCOORD1.xyz = _Color.xyz;
    u_xlat0 = u_xlat16_3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat16_3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat16_3.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    gl_Position = u_xlat0;
vs_TEXCOORD2 = phase0_Output0_0.x;
vs_TEXCOORD0 = phase0_Output0_0.yz;
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
uniform 	mediump vec4 timePeriod;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4                _WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedX_Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in mediump float vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_4;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_2.x = timePeriod.y + timePeriod.y;
    u_xlat16_2.x = u_xlat16_0.x * 10.0 + (-u_xlat16_2.x);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_2.x = vs_TEXCOORD2 * 6.28318548 + u_xlat16_2.x;
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + 0.5;
    u_xlat16_4 = u_xlat16_0.x * u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * vs_TEXCOORD1.w;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_0.x;
    u_xlat16_1.x = dFdx(u_xlat16_4);
    u_xlat16_1.y = dFdy(u_xlat16_4);
    u_xlat16_1.z = 0.100000001;
    u_xlat16_2.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = u_xlat16_2.x + 0.5;
    SV_Target0.w = u_xlat16_2.x * u_xlat16_0.x;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
