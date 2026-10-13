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
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb15;
mediump vec3 u_xlat16_19;
mediump vec3 u_xlat16_20;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_40;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_40 = _Shininess * 128.0;
    u_xlatb33 = 0<unity_VertexLightParams.x;
    if(u_xlatb33){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat34 = unity_LightAtten[0].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
        u_xlatb35 = unity_LightPosition[0].w!=0.0;
        u_xlatb36 = unity_LightAtten[0].w<u_xlat33;
        u_xlatb35 = u_xlatb35 && u_xlatb36;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-07);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat3.xyz;
        u_xlat34 = dot(u_xlat4.xyz, unity_SpotDirection[0].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_19.x = u_xlat34 + (-unity_LightAtten[0].x);
        u_xlat16_19.x = u_xlat16_19.x * unity_LightAtten[0].y;
        u_xlat16_19.x = clamp(u_xlat16_19.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_9.xyz = u_xlat16_19.xxx * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[0].xyz;
        u_xlatb34 = 0.0<u_xlat16_19.x;
        u_xlat16_19.xyz = u_xlat3.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_42 = dot(u_xlat16_19.xyz, u_xlat16_19.xyz);
        u_xlat16_42 = inversesqrt(u_xlat16_42);
        u_xlat16_19.xyz = u_xlat16_19.xyz * vec3(u_xlat16_42);
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat16_19.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_19.x = log2(u_xlat16_19.x);
        u_xlat16_19.x = u_xlat16_40 * u_xlat16_19.x;
        u_xlat16_19.x = exp2(u_xlat16_19.x);
        u_xlat16_19.x = min(u_xlat16_19.x, 1.0);
        u_xlat16_19.x = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_19.xyz = u_xlat16_19.xxx * unity_LightColor[0].xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_19.xyz : vec3(0.0, 0.0, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 1;
    } else {
        u_xlat16_19.x = float(0.0);
        u_xlat16_19.y = float(0.0);
        u_xlat16_19.z = float(0.0);
        u_xlati33 = 0;
    }
    u_xlatb34 = u_xlati33<unity_VertexLightParams.x;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[1].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlatb4 = unity_LightPosition[1].w!=0.0;
        u_xlatb15 = unity_LightAtten[1].w<u_xlat35;
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-07);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[1].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[1].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[1].xyz;
        u_xlatb36 = 0.0<u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 2;
    }
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[2].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlatb4 = unity_LightPosition[2].w!=0.0;
        u_xlatb15 = unity_LightAtten[2].w<u_xlat35;
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-07);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[2].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[2].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[2].y;
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[2].xyz;
        u_xlatb36 = 0.0<u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[2].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 3;
    }
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[3].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlatb4 = unity_LightPosition[3].w!=0.0;
        u_xlatb15 = unity_LightAtten[3].w<u_xlat35;
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-07);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[3].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[3].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[3].y;
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[3].xyz;
        u_xlatb36 = 0.0<u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[3].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 4;
    }
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[4].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlatb4 = unity_LightPosition[4].w!=0.0;
        u_xlatb15 = unity_LightAtten[4].w<u_xlat35;
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-07);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[4].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[4].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[4].y;
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[4].xyz;
        u_xlatb36 = 0.0<u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[4].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 5;
    }
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[5].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlatb4 = unity_LightPosition[5].w!=0.0;
        u_xlatb15 = unity_LightAtten[5].w<u_xlat35;
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-07);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[5].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[5].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[5].y;
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[5].xyz;
        u_xlatb36 = 0.0<u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[5].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 6;
    }
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[6].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
        u_xlatb4 = unity_LightPosition[6].w!=0.0;
        u_xlatb15 = unity_LightAtten[6].w<u_xlat35;
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-07);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[6].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[6].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[6].y;
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[6].xyz;
        u_xlatb36 = 0.0<u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[6].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 7;
    }
    u_xlatb33 = u_xlati33<unity_VertexLightParams.x;
    u_xlatb33 = u_xlatb33 && u_xlatb34;
    if(u_xlatb33){
        u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
        u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat34 = unity_LightAtten[7].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
        u_xlatb35 = unity_LightPosition[7].w!=0.0;
        u_xlatb3 = unity_LightAtten[7].w<u_xlat33;
        u_xlatb35 = u_xlatb35 && u_xlatb3;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-07);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat3.xyz = vec3(u_xlat33) * u_xlat0.xyz;
        u_xlat34 = dot(u_xlat3.xyz, unity_SpotDirection[7].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_9.x = u_xlat34 + (-unity_LightAtten[7].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[7].y;
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[7].xyz;
        u_xlatb34 = 0.0<u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat0.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_40 = exp2(u_xlat16_40);
        u_xlat16_40 = min(u_xlat16_40, 1.0);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_8;
        u_xlat16_10.xyz = vec3(u_xlat16_40) * unity_LightColor[7].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_19.xyz * _SpecColor.xyz;
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
    vs_COLOR0.xyz = u_xlat16_7.xyz;
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
    vs_COLOR0.w = _Color.w;
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
