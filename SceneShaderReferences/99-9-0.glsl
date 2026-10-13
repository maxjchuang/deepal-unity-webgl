FERS
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
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4                _Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(2) uniform UnityPerDraw {
#endif
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_ObjectToWorld[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXhlslcc_mtx4x4unity_WorldToObject[4];
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_LODFade;
	UNITY_UNIFORM vec4 Xhlslcc_UnusedXunity_WorldTransformParams;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec4 u_xlat8;
vec3 u_xlat9;
vec3 u_xlat11;
vec2 u_xlat18;
int u_xlati18;
bool u_xlatb18;
int u_xlati27;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD0.z = 0.0;
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat9.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat9.xyz;
    u_xlat9.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat9.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat0.x = u_xlat1.x * 6.28318548 + (-u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat1.w = u_xlat0.x * 0.0199999996 + abs(u_xlat1.z);
    u_xlat0.xy = _Time.yy * vec2(0.5, 0.5) + u_xlat1.xw;
    u_xlat18.x = dot(u_xlat0.xy, vec2(0.366025418, 0.366025418));
    u_xlat18.xy = u_xlat18.xx + u_xlat0.xy;
    u_xlat18.xy = floor(u_xlat18.xy);
    u_xlat2.xy = u_xlat18.xy * vec2(0.00346020772, 0.00346020772);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) * vec2(289.0, 289.0) + u_xlat18.xy;
    u_xlat0.xy = (-u_xlat18.xy) + u_xlat0.xy;
    u_xlat18.x = dot(u_xlat18.xy, vec2(0.211324871, 0.211324871));
    u_xlat0.xy = u_xlat18.xx + u_xlat0.xy;
    u_xlatb18 = u_xlat0.x>=u_xlat0.y;
    u_xlat3.y = (u_xlatb18) ? 0.0 : 1.0;
    u_xlat3.x = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat3.z = float(0.0);
    u_xlat3.w = float(1.0);
    u_xlat11.xyz = u_xlat2.yyy + u_xlat3.zyw;
    u_xlat4.xyz = u_xlat11.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat11.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
    u_xlat4.xyz = floor(u_xlat4.xyz);
    u_xlat11.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat11.xyz;
    u_xlat2.xyz = u_xlat2.xxx + u_xlat11.xyz;
    u_xlat2.xyz = u_xlat3.zxw + u_xlat2.xyz;
    u_xlat4.xyz = u_xlat2.xyz * vec3(34.0, 34.0, 34.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat2.xyz * vec3(0.00346020772, 0.00346020772, 0.00346020772);
    u_xlat4.xyz = floor(u_xlat4.xyz);
    u_xlat2.xyz = (-u_xlat4.xyz) * vec3(289.0, 289.0, 289.0) + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(0.024390243, 0.024390243, 0.024390243);
    u_xlat2.xyz = fract(u_xlat2.xyz);
    u_xlat4.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-0.5, -0.5, -0.5);
    u_xlat2.xyz = u_xlat2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.xyz = floor(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat2.xyz = abs(u_xlat2.xzy) + vec3(-0.5, -0.5, -0.5);
    u_xlat4.w = u_xlat2.x;
    u_xlat5.xyz = u_xlat2.xzy * u_xlat2.xzy;
    u_xlat5.xyz = u_xlat4.xyz * u_xlat4.xyz + u_xlat5.xyz;
    u_xlat5.xyz = (-u_xlat5.xyz) * vec3(0.853734732, 0.853734732, 0.853734732) + vec3(1.79284286, 1.79284286, 1.79284286);
    u_xlat18.xy = u_xlat4.xw * u_xlat5.xx;
    u_xlat6.x = dot(u_xlat0.xy, u_xlat18.xy);
    u_xlat7.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat8 = u_xlat0.xyxy + vec4(0.211324871, 0.211324871, -0.577350259, -0.577350259);
    u_xlat9.xz = (-u_xlat3.xy) + u_xlat8.xy;
    u_xlat7.y = dot(u_xlat9.xz, u_xlat9.xz);
    u_xlat7.z = dot(u_xlat8.zw, u_xlat8.zw);
    u_xlat3.xyz = (-u_xlat7.xyz) + vec3(0.5, 0.5, 0.5);
    u_xlat3.xyz = max(u_xlat3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat7.xyz = u_xlat3.xyz * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat7.xyz;
    u_xlat7.xyz = u_xlat7.xyz * u_xlat7.xyz;
    u_xlat18.x = u_xlat18.x * u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = u_xlat0.x * -6.0;
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat18.x;
    u_xlat2.xw = u_xlat4.zy;
    u_xlat2 = u_xlat2.xywz * u_xlat5.zzyy;
    u_xlat6.y = dot(u_xlat9.xz, u_xlat2.zw);
    u_xlat9.x = u_xlat9.x * u_xlat3.y;
    u_xlat9.y = u_xlat3.z * u_xlat8.z;
    u_xlat6.z = dot(u_xlat8.zw, u_xlat2.xy);
    u_xlat9.xy = u_xlat9.xy * vec2(-6.0, -6.0);
    u_xlat0.x = u_xlat9.x * u_xlat6.y + u_xlat0.x;
    u_xlat3.y = dot(u_xlat7.xyz, u_xlat6.xyz);
    u_xlat0.x = u_xlat7.y * u_xlat2.z + u_xlat0.x;
    u_xlat0.x = u_xlat9.y * u_xlat6.z + u_xlat0.x;
    u_xlat3.x = u_xlat7.z * u_xlat2.x + u_xlat0.x;
    u_xlat0.xy = u_xlat3.xy * vec2(1.56000006, 1.56000006) + u_xlat1.xw;
    u_xlati18 = int((0.0<u_xlat1.z) ? 0xFFFFFFFFu : uint(0));
    u_xlati27 = int((u_xlat1.z<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlat1 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlati0 = (-u_xlati18) + u_xlati27;
    u_xlat0.x = float(u_xlati0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.xxxx + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
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
uniform 	mediump float isDarkTheme;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityPerCamera {
#endif
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_LightColor0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_AmbientColor;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedX_WorldSpaceLightPos0;
	UNITY_UNIFORM mediump vec3 Xhlslcc_UnusedX_WorldSpaceCameraPos;
	UNITY_UNIFORM vec4                hlslcc_mtx4x4unity_MatrixVP[4];
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH0;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH1;
	UNITY_UNIFORM mediump vec4 Xhlslcc_UnusedXSH2;
	UNITY_UNIFORM vec4                _Time;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityPerMaterial {
#endif
	UNITY_UNIFORM mediump vec4                _ColorBright0;
	UNITY_UNIFORM mediump vec4                _ColorBright1;
	UNITY_UNIFORM mediump vec4                _ColorDark0;
	UNITY_UNIFORM mediump vec4                _ColorDark1;
	UNITY_UNIFORM mediump float                animSpeed;
	UNITY_UNIFORM mediump float                ratio;
	UNITY_UNIFORM mediump float                value;
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec2 u_xlat1;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_8;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.yy * vec2(1.25, 0.600000024);
    u_xlat16_4 = log2(abs(u_xlat16_0.y));
    u_xlat16_0.x = u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_4 = u_xlat16_4 * 1.29999995;
    u_xlat16_4 = exp2(u_xlat16_4);
    u_xlat1.y = _Time.x * animSpeed + u_xlat16_4;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy).x;
    u_xlatb5 = value>=0.0;
    u_xlat16_4 = (u_xlatb5) ? 1.0 : 0.0;
    u_xlatb5 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(isDarkTheme);
    u_xlat16_2 = (bool(u_xlatb5)) ? _ColorDark1 : _ColorBright1;
    u_xlat16_3 = (bool(u_xlatb5)) ? _ColorDark0 : _ColorBright0;
    u_xlat5 = (u_xlatb5) ? 1.0 : 1.39999998;
    u_xlat16_2 = u_xlat16_2 + (-u_xlat16_3);
    u_xlat16_2 = vec4(u_xlat16_4) * u_xlat16_2 + u_xlat16_3;
    u_xlat1.x = u_xlat16_1 * u_xlat16_2.w;
    SV_Target0.xyz = u_xlat16_2.xyz;
    u_xlat16_4 = abs(value) * ratio;
    u_xlat16_4 = u_xlat16_4 * u_xlat1.x;
    u_xlat16_8 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat16_8 = u_xlat16_8 * 5.00000048;
    u_xlat16_8 = clamp(u_xlat16_8, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_8 * u_xlat16_0.x;
    u_xlat16_8 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * 2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_8;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_4;
    u_xlat16_4 = vs_TEXCOORD0.x + -0.5;
    u_xlat16_4 = -abs(u_xlat16_4) * 2.0 + 1.0;
    u_xlat16_4 = u_xlat16_4 * 3.0;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_4 = u_xlat16_4 * u_xlat16_4;
    u_xlat16_0.x = u_xlat16_4 * u_xlat16_0.x;
    SV_Target0.w = u_xlat5 * u_xlat16_0.x;
    return;
}

#endif
          
