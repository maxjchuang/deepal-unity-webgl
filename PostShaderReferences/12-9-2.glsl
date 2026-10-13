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
uniform 	vec4 _MainTex_TexelSize;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec2 u_xlat0;
vec2 u_xlat1;
void main()
{
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0.x = flipY * -2.0 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * rectRenderClip.zw + rectRenderClip.xy;
    gl_Position.y = u_xlat0.x * u_xlat1.y;
    gl_Position.x = u_xlat1.x;
    u_xlat0.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, -0.5) + u_xlat0.xyxy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	vec4 _rcpFrame;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
int u_xlati1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
bool u_xlatb4;
vec2 u_xlat5;
ivec2 u_xlati5;
vec2 u_xlat6;
ivec2 u_xlati6;
vec3 u_xlat8;
bvec3 u_xlatb8;
vec3 u_xlat10;
ivec2 u_xlati10;
bvec2 u_xlatb10;
vec2 u_xlat11;
bool u_xlatb11;
float u_xlat12;
vec2 u_xlat15;
vec2 u_xlat17;
int u_xlati17;
vec2 u_xlat18;
float u_xlat19;
ivec2 u_xlati19;
vec2 u_xlat20;
float u_xlat22;
bool u_xlatb22;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;
int op_not(int value) { return -value - 1; }
ivec2 op_not(ivec2 a) { a.x = op_not(a.x); a.y = op_not(a.y); return a; }
ivec3 op_not(ivec3 a) { a.x = op_not(a.x); a.y = op_not(a.y); a.z = op_not(a.z); return a; }
ivec4 op_not(ivec4 a) { a.x = op_not(a.x); a.y = op_not(a.y); a.z = op_not(a.z); a.w = op_not(a.w); return a; }

void main()
{
    u_xlat16_0.xyz = textureLod(_MainTex, vs_TEXCOORD0.xy, 0.0).xyz;
    u_xlat1.x = dot(u_xlat16_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0 = _rcpFrame.xyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat8.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat0.zw, 0.0).xyz;
    u_xlat15.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0 = _rcpFrame.xyxy * vec4(0.0, -1.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat15.y = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat0.zw, 0.0).xyz;
    u_xlat3.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat3.y = max(u_xlat1.x, u_xlat8.x);
    u_xlat17.x = min(u_xlat1.x, u_xlat8.x);
    u_xlat17.x = min(u_xlat15.x, u_xlat17.x);
    u_xlat10.xz = max(u_xlat15.xy, u_xlat3.yx);
    u_xlat4.x = min(u_xlat15.y, u_xlat3.x);
    u_xlat10.x = max(u_xlat10.x, u_xlat10.z);
    u_xlat17.x = min(u_xlat17.x, u_xlat4.x);
    u_xlat10.x = (-u_xlat17.x) + u_xlat10.x;
    u_xlat17.xy = vs_TEXCOORD0.xy + (-_rcpFrame.xy);
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat17.xy, 0.0).xyz;
    u_xlat17.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat4.xy = vs_TEXCOORD0.xy + _rcpFrame.xy;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat4.xy, 0.0).xyz;
    u_xlat24 = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0 = _rcpFrame.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat0.xy, 0.0).xyz;
    u_xlat4.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat0.zw, 0.0).xyz;
    u_xlat11.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat18.x = u_xlat8.x + u_xlat15.y;
    u_xlat25 = u_xlat15.x + u_xlat3.x;
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat5.x = u_xlat25 + u_xlat18.x;
    u_xlat18.x = u_xlat1.x * -2.0 + u_xlat18.x;
    u_xlat25 = u_xlat1.x * -2.0 + u_xlat25;
    u_xlat12 = u_xlat24 + u_xlat4.x;
    u_xlat4.x = u_xlat17.x + u_xlat4.x;
    u_xlat19 = u_xlat15.x * -2.0 + u_xlat12;
    u_xlat4.x = u_xlat15.y * -2.0 + u_xlat4.x;
    u_xlat17.x = u_xlat17.x + u_xlat11.x;
    u_xlat24 = u_xlat24 + u_xlat11.x;
    u_xlat11.x = abs(u_xlat18.x) * 2.0 + abs(u_xlat19);
    u_xlat4.x = abs(u_xlat25) * 2.0 + abs(u_xlat4.x);
    u_xlat18.x = u_xlat3.x * -2.0 + u_xlat17.x;
    u_xlat24 = u_xlat8.x * -2.0 + u_xlat24;
    u_xlat11.x = u_xlat11.x + abs(u_xlat18.x);
    u_xlat24 = u_xlat4.x + abs(u_xlat24);
    u_xlat17.x = u_xlat12 + u_xlat17.x;
    u_xlatb24 = u_xlat11.x>=u_xlat24;
    u_xlat17.x = u_xlat5.x * 2.0 + u_xlat17.x;
    u_xlat8.z = (u_xlatb24) ? u_xlat15.y : u_xlat3.x;
    u_xlat8.x = (u_xlatb24) ? u_xlat8.x : u_xlat15.x;
    u_xlat15.x = (u_xlatb24) ? _rcpFrame.y : _rcpFrame.x;
    u_xlat3.x = u_xlat17.x * 0.0833333358 + (-u_xlat1.x);
    u_xlat17.x = (-u_xlat1.x) + u_xlat8.z;
    u_xlat4.x = (-u_xlat1.x) + u_xlat8.x;
    u_xlat8.xz = u_xlat1.xx + u_xlat8.xz;
    u_xlatb11 = abs(u_xlat17.x)>=abs(u_xlat4.x);
    u_xlat17.x = max(abs(u_xlat17.x), abs(u_xlat4.x));
    u_xlat15.x = (u_xlatb11) ? (-u_xlat15.x) : u_xlat15.x;
    u_xlat3.x = u_xlat10.x * abs(u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat10.x = u_xlatb24 ? _rcpFrame.x : float(0.0);
    u_xlat4.x = (u_xlatb24) ? 0.0 : _rcpFrame.y;
    u_xlat18.xy = u_xlat15.xx * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
    u_xlat18.x = (u_xlatb24) ? vs_TEXCOORD0.x : u_xlat18.x;
    u_xlat25 = (u_xlatb24) ? u_xlat18.y : vs_TEXCOORD0.y;
    u_xlat5.x = (-u_xlat10.x) + u_xlat18.x;
    u_xlat5.y = (-u_xlat4.x) + u_xlat25;
    u_xlat6.x = u_xlat10.x + u_xlat18.x;
    u_xlat6.y = u_xlat4.x + u_xlat25;
    u_xlat18.x = u_xlat3.x * -2.0 + 3.0;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat5.xy, 0.0).xyz;
    u_xlat25 = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat6.xy, 0.0).xyz;
    u_xlat19 = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat8.x = (u_xlatb11) ? u_xlat8.z : u_xlat8.x;
    u_xlat22 = u_xlat17.x * 0.25;
    u_xlat1.x = (-u_xlat8.x) * 0.5 + u_xlat1.x;
    u_xlat3.x = u_xlat3.x * u_xlat18.x;
    u_xlati1 = int((u_xlat1.x<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlat11.x = (-u_xlat8.x) * 0.5 + u_xlat25;
    u_xlat11.y = (-u_xlat8.x) * 0.5 + u_xlat19;
    u_xlati19.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat11.xyxy), vec4(u_xlat22)).xy) * 0xFFFFFFFFu);
    u_xlat17.x = (-u_xlat10.x) * 1.5 + u_xlat5.x;
    u_xlat20.x = (u_xlati19.x != 0) ? u_xlat5.x : u_xlat17.x;
    u_xlat17.x = (-u_xlat4.x) * 1.5 + u_xlat5.y;
    u_xlat20.y = (u_xlati19.x != 0) ? u_xlat5.y : u_xlat17.x;
    u_xlati5.xy = op_not(u_xlati19.xy);
    u_xlati17 = int(uint(uint(u_xlati5.y) | uint(u_xlati5.x)));
    u_xlat25 = u_xlat10.x * 1.5 + u_xlat6.x;
    u_xlat5.x = (u_xlati19.y != 0) ? u_xlat6.x : u_xlat25;
    u_xlat25 = u_xlat4.x * 1.5 + u_xlat6.y;
    u_xlat5.y = (u_xlati19.y != 0) ? u_xlat6.y : u_xlat25;
    if(u_xlati17 != 0) {
        if(u_xlati19.x == 0) {
            u_xlat16_2.xyz = textureLod(_MainTex, u_xlat20.xy, 0.0).xyz;
            u_xlat11.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
        }
        if(u_xlati19.y == 0) {
            u_xlat16_2.xyz = textureLod(_MainTex, u_xlat5.xy, 0.0).xyz;
            u_xlat11.y = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
        }
        u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
        u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
        u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
        u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat17.x;
        u_xlati19.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat11.xyxy), vec4(u_xlat22)).xy) * 0xFFFFFFFFu);
        u_xlat17.x = (-u_xlat10.x) * 2.0 + u_xlat20.x;
        u_xlat20.x = (u_xlati19.x != 0) ? u_xlat20.x : u_xlat17.x;
        u_xlat17.x = (-u_xlat4.x) * 2.0 + u_xlat20.y;
        u_xlat20.y = (u_xlati19.x != 0) ? u_xlat20.y : u_xlat17.x;
        u_xlati6.xy = op_not(u_xlati19.xy);
        u_xlati17 = int(uint(uint(u_xlati6.y) | uint(u_xlati6.x)));
        u_xlat25 = u_xlat10.x * 2.0 + u_xlat5.x;
        u_xlat5.x = (u_xlati19.y != 0) ? u_xlat5.x : u_xlat25;
        u_xlat25 = u_xlat4.x * 2.0 + u_xlat5.y;
        u_xlat5.y = (u_xlati19.y != 0) ? u_xlat5.y : u_xlat25;
        if(u_xlati17 != 0) {
            if(u_xlati19.x == 0) {
                u_xlat16_2.xyz = textureLod(_MainTex, u_xlat20.xy, 0.0).xyz;
                u_xlat11.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
            }
            if(u_xlati19.y == 0) {
                u_xlat16_2.xyz = textureLod(_MainTex, u_xlat5.xy, 0.0).xyz;
                u_xlat11.y = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
            }
            u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
            u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
            u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
            u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat17.x;
            u_xlati19.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat11.xyxy), vec4(u_xlat22)).xy) * 0xFFFFFFFFu);
            u_xlat17.x = (-u_xlat10.x) * 2.0 + u_xlat20.x;
            u_xlat20.x = (u_xlati19.x != 0) ? u_xlat20.x : u_xlat17.x;
            u_xlat17.x = (-u_xlat4.x) * 2.0 + u_xlat20.y;
            u_xlat20.y = (u_xlati19.x != 0) ? u_xlat20.y : u_xlat17.x;
            u_xlati6.xy = op_not(u_xlati19.xy);
            u_xlati17 = int(uint(uint(u_xlati6.y) | uint(u_xlati6.x)));
            u_xlat25 = u_xlat10.x * 2.0 + u_xlat5.x;
            u_xlat5.x = (u_xlati19.y != 0) ? u_xlat5.x : u_xlat25;
            u_xlat25 = u_xlat4.x * 2.0 + u_xlat5.y;
            u_xlat5.y = (u_xlati19.y != 0) ? u_xlat5.y : u_xlat25;
            if(u_xlati17 != 0) {
                if(u_xlati19.x == 0) {
                    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat20.xy, 0.0).xyz;
                    u_xlat11.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
                }
                if(u_xlati19.y == 0) {
                    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat5.xy, 0.0).xyz;
                    u_xlat11.y = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
                }
                u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
                u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
                u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
                u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat17.x;
                u_xlati19.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat11.xyxy), vec4(u_xlat22)).xy) * 0xFFFFFFFFu);
                u_xlat17.x = (-u_xlat10.x) * 4.0 + u_xlat20.x;
                u_xlat20.x = (u_xlati19.x != 0) ? u_xlat20.x : u_xlat17.x;
                u_xlat17.x = (-u_xlat4.x) * 4.0 + u_xlat20.y;
                u_xlat20.y = (u_xlati19.x != 0) ? u_xlat20.y : u_xlat17.x;
                u_xlati6.xy = op_not(u_xlati19.xy);
                u_xlati17 = int(uint(uint(u_xlati6.y) | uint(u_xlati6.x)));
                u_xlat25 = u_xlat10.x * 4.0 + u_xlat5.x;
                u_xlat5.x = (u_xlati19.y != 0) ? u_xlat5.x : u_xlat25;
                u_xlat25 = u_xlat4.x * 4.0 + u_xlat5.y;
                u_xlat5.y = (u_xlati19.y != 0) ? u_xlat5.y : u_xlat25;
                if(u_xlati17 != 0) {
                    if(u_xlati19.x == 0) {
                        u_xlat16_2.xyz = textureLod(_MainTex, u_xlat20.xy, 0.0).xyz;
                        u_xlat11.x = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
                    }
                    if(u_xlati19.y == 0) {
                        u_xlat16_2.xyz = textureLod(_MainTex, u_xlat5.xy, 0.0).xyz;
                        u_xlat11.y = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
                    }
                    u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
                    u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
                    u_xlat8.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
                    u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat8.x;
                    u_xlatb8.xz = greaterThanEqual(abs(u_xlat11.xxyy), vec4(u_xlat22)).xz;
                    u_xlat17.x = (-u_xlat10.x) * 2.0 + u_xlat20.x;
                    u_xlat20.x = (u_xlatb8.x) ? u_xlat20.x : u_xlat17.x;
                    u_xlat17.x = (-u_xlat4.x) * 2.0 + u_xlat20.y;
                    u_xlat20.y = (u_xlatb8.x) ? u_xlat20.y : u_xlat17.x;
                    u_xlat8.x = u_xlat10.x * 2.0 + u_xlat5.x;
                    u_xlat5.x = (u_xlatb8.z) ? u_xlat5.x : u_xlat8.x;
                    u_xlat8.x = u_xlat4.x * 2.0 + u_xlat5.y;
                    u_xlat5.y = (u_xlatb8.z) ? u_xlat5.y : u_xlat8.x;
                }
            }
        }
    }
    u_xlat8.x = (-u_xlat20.x) + vs_TEXCOORD0.x;
    u_xlat22 = u_xlat5.x + (-vs_TEXCOORD0.x);
    u_xlat10.x = (-u_xlat20.y) + vs_TEXCOORD0.y;
    u_xlat8.x = (u_xlatb24) ? u_xlat8.x : u_xlat10.x;
    u_xlat10.x = u_xlat5.y + (-vs_TEXCOORD0.y);
    u_xlat22 = (u_xlatb24) ? u_xlat22 : u_xlat10.x;
    u_xlati10.xy = ivec2(uvec2(lessThan(u_xlat11.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat4.x = u_xlat8.x + u_xlat22;
    u_xlatb10.xy = notEqual(ivec4(u_xlati1), u_xlati10.xyxx).xy;
    u_xlat1.x = float(1.0) / u_xlat4.x;
    u_xlatb4 = u_xlat8.x<u_xlat22;
    u_xlat8.x = min(u_xlat22, u_xlat8.x);
    u_xlatb22 = (u_xlatb4) ? u_xlatb10.x : u_xlatb10.y;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat1.x = u_xlat8.x * (-u_xlat1.x) + 0.5;
    u_xlat8.x = u_xlat3.x * 0.75;
    u_xlat1.x = u_xlatb22 ? u_xlat1.x : float(0.0);
    u_xlat1.x = max(u_xlat8.x, u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * u_xlat15.xx + vs_TEXCOORD0.xy;
    u_xlat3.x = (u_xlatb24) ? vs_TEXCOORD0.x : u_xlat1.x;
    u_xlat3.y = (u_xlatb24) ? u_xlat1.y : vs_TEXCOORD0.y;
    u_xlat16_2.xyz = textureLod(_MainTex, u_xlat3.xy, 0.0).xyz;
    SV_Target0.w = dot(u_xlat16_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    SV_Target0.xyz = u_xlat16_2.xyz;
    return;
}

#endif
