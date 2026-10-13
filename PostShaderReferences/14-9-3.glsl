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
uniform 	float flipY;
uniform 	vec4 rectRenderClip;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
float u_xlat0;
vec2 u_xlat1;
void main()
{
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0 = flipY * -2.0 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * rectRenderClip.zw + rectRenderClip.xy;
    gl_Position.y = u_xlat0 * u_xlat1.y;
    gl_Position.x = u_xlat1.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
uniform 	mediump float _BloomIntensity;
uniform 	mediump vec4 rectRenderClipBloom;
uniform 	mediump vec3 _Lut2D_Params;
uniform 	mediump float _PostExposure;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Lut2D;
UNITY_LOCATION(2) uniform mediump sampler2D _BloomTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_7;
vec2 u_xlat10;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat22;
void main()
{
    u_xlat0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlatb18 = u_xlat0.y>=u_xlat0.z;
    u_xlat16_1.x = (u_xlatb18) ? 1.0 : 0.0;
    u_xlat16_7.xy = (-u_xlat0.zy) + u_xlat0.yz;
    u_xlat16_1.xy = u_xlat16_1.xx * u_xlat16_7.xy + u_xlat0.zy;
    u_xlat16_2.xy = (-u_xlat16_1.xy);
    u_xlat16_2.z = (-u_xlat0.x);
    u_xlat16_3.yz = u_xlat16_1.yx + u_xlat16_2.yz;
    u_xlat16_3.x = u_xlat0.x + u_xlat16_2.x;
    u_xlatb18 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat16_13 = (u_xlatb18) ? 1.0 : 0.0;
    u_xlat16_1.xy = vec2(u_xlat16_13) * u_xlat16_3.xy + u_xlat16_1.xy;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_3.z + u_xlat0.x;
    u_xlat16_7.x = min(u_xlat16_1.y, u_xlat16_13);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.00000001e-10;
    u_xlat16_1.x = u_xlat16_7.x / u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_7.x = dot(u_xlat0.xyz, vec3(0.209999993, 0.709999979, 0.0700000003));
    u_xlat16_7.x = u_xlat16_7.x * 10.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat0.zxy;
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat0.zxy) + u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat0.zxy;
    u_xlat16_2.xy = vs_TEXCOORD0.xy + (-rectRenderClipBloom.xy);
    u_xlat16_2.xy = abs(u_xlat16_2.xy) * rectRenderClipBloom.zw + vec2(-1000.0, -1000.0);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
    u_xlat16_19 = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_19 = u_xlat16_19 * _BloomIntensity;
    u_xlat16_0 = texture(_BloomTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_0.w * 8.0;
    u_xlat16_2.xyz = u_xlat16_0.zxy * u_xlat16_2.xxx;
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_19) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_PostExposure, _PostExposure, _PostExposure));
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(5.55555582, 5.55555582, 5.55555582) + vec3(0.0479959995, 0.0479959995, 0.0479959995);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(0.0734997839, 0.0734997839, 0.0734997839) + vec3(0.386036009, 0.386036009, 0.386036009);
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
    u_xlat22 = u_xlat4.x * _Lut2D_Params.z;
    u_xlat22 = floor(u_xlat22);
    u_xlat4.x = u_xlat4.x * _Lut2D_Params.z + (-u_xlat22);
    u_xlat10.xy = u_xlat4.yz * _Lut2D_Params.zz + vec2(0.5, 0.5);
    u_xlat5.yz = u_xlat10.yx * _Lut2D_Params.yx;
    u_xlat5.x = u_xlat22 * _Lut2D_Params.y + u_xlat5.z;
    u_xlat16_10.xyz = texture(_Lut2D, u_xlat5.xy).xyz;
    u_xlat5.x = u_xlat5.x + _Lut2D_Params.y;
    u_xlat16_5.xyz = texture(_Lut2D, u_xlat5.xy).xyz;
    u_xlat5.xyz = (-u_xlat16_10.xyz) + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat4.xyz;
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    SV_Target0.xyz = u_xlat4.xyz;
    SV_Target0.w = dot(u_xlat16_1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    return;
}

#endif
