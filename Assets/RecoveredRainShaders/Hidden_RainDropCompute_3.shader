Shader "Recovered/Hidden/RainDropCompute/Variant3" {
Properties {}
SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend One Zero, One Zero
ZWrite On
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile_instancing
#include "UnityCG.cginc"
float2 processRange;
float deltaTime;
uint wParticleRT;
uint startID;
uint endID;
float driving;
Texture2D<float4> ParticleBufferRT0; SamplerState samplerParticleBufferRT0;
Texture2D<float4> ParticleBufferRT1; SamplerState samplerParticleBufferRT1;
Texture2D<float4> texCollision; SamplerState samplertexCollision;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
};
Varyings vert(AppData input, uint instanceID:SV_InstanceID) { Varyings output;
float3 u_xlat0;

    u_xlat0.xy = input.in_POSITION0.yx * float2(0.5, 0.5) + float2(0.5, 0.5);
    u_xlat0.x = max(u_xlat0.x, processRange.x);
    u_xlat0.z = min(u_xlat0.x, processRange.y);
    output.position.xy = u_xlat0.yz * float2(2.0, 2.0) + float2(-1.0, -1.0);
    output.position.zw = float2(0.0, 1.0);
    return output;

return output;
}
struct ParticleOutput { float4 rt0:SV_Target0;float4 rt1:SV_Target1;};
ParticleOutput frag(Varyings input) {ParticleOutput outputColor;outputColor.rt0=0;outputColor.rt1=0;
float4 u_xlat16_0;
uint4 u_xlatu0;
bool u_xlatb0;
float4 u_xlat16_1;
float4 u_xlat16_2;
float4 u_xlat16_3;
float3 u_xlat4;
float4 u_xlat16_4;
float3 u_xlat5;
bool u_xlatb5;
float4 u_xlat16_6;
float3 u_xlat16_7;
float3 u_xlat8;
float u_xlat16;
bool u_xlatb16;
float u_xlat16_22;
bool u_xlatb24;
float u_xlat16_25;

float4 hlslcc_FragCoord = float4(input.position.xyz, 1.0/input.position.w);
    u_xlatu0.xy = uint2(hlslcc_FragCoord.xy);
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_1 = ParticleBufferRT0.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat16_2 = ParticleBufferRT1.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat16_3.w = (-deltaTime) * 0.25 + u_xlat16_2.w;
    u_xlat16_3.w = clamp(u_xlat16_3.w, 0.0, 1.0);
    u_xlatb16 = u_xlat16_3.w==0.0;
    if(u_xlatb16){
        u_xlatu0.x = u_xlatu0.y * wParticleRT + u_xlatu0.x;
        u_xlat8.x = float(u_xlatu0.x);
        u_xlat8.xyz = u_xlat8.xxx * float3(0.103100002, 0.103, 0.0973000005);
        u_xlat8.xyz = frac(u_xlat8.xyz);
        u_xlat4.xyz = u_xlat8.yzx + float3(33.3300018, 33.3300018, 33.3300018);
        u_xlat4.x = dot(u_xlat8.xyz, u_xlat4.xyz);
        u_xlat8.xyz = u_xlat8.xyz + u_xlat4.xxx;
        u_xlat4.xy = u_xlat8.zz + u_xlat8.xy;
        u_xlat8.xy = u_xlat8.yx * u_xlat4.xy;
        u_xlat8.xy = frac(u_xlat8.xy);
        u_xlatb24 = u_xlatu0.x>=startID;
        u_xlatb0 = u_xlatu0.x<endID;
        u_xlatb0 = u_xlatb0 && u_xlatb24;
        u_xlat8.x = sqrt(u_xlat8.x);
        u_xlat16 = u_xlat8.y * 6.28318548;
        u_xlat4.x = sin(u_xlat16);
        u_xlat5.x = cos(u_xlat16);
        u_xlat5.z = u_xlat4.x;
        u_xlat8.xy = u_xlat8.xx * u_xlat5.xz;
        u_xlat16_6.x = driving * -2.0 + 0.5;
        u_xlat16_6.y = float(4.0);
        u_xlat16_6.z = float(0.0);
        u_xlat16_6.xz = u_xlat8.xy * float2(7.5, 7.5) + u_xlat16_6.xz;
        u_xlat16_4.xyz = (bool(u_xlatb0)) ? u_xlat16_6.xyz : u_xlat16_1.xyz;
        u_xlat16_2.w = 0.0;
        u_xlat16_3 = (bool(u_xlatb0)) ? float4(0.0, -0.100000001, 0.0, 1.0) : u_xlat16_2;
        u_xlat16_4.w = 0.0;
    } else {
        u_xlat16_6.x = u_xlat16_1.x;
        u_xlat16_6.y = 1.0;
        u_xlat16_6.x = dot(float2(0.125, 0.473749995), u_xlat16_6.xy);
        u_xlat16_7.xy = u_xlat16_1.yz;
        u_xlat16_7.z = 1.0;
        u_xlat16_6.y = dot(float3(1.49011603e-08, 0.25, 0.5), u_xlat16_7.xyz);
        u_xlat16_22 = dot(float3(-0.333333403, 1.98682208e-08, 0.833333373), u_xlat16_7.xyz);
        u_xlat16_0 = texCollision.SampleLevel(samplertexCollision, u_xlat16_6.xy, 0.0);
        u_xlat16_6.xyw = u_xlat16_0.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
        u_xlat16_7.x = dot(u_xlat16_6.xyw, u_xlat16_6.xyw);
        u_xlat16_7.x = rsqrt(u_xlat16_7.x);
        u_xlat16_6.xyw = u_xlat16_6.xyw * u_xlat16_7.xxx;
        u_xlatb5 = u_xlat16_0.w<u_xlat16_22;
        u_xlat16_22 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
        u_xlat16_22 = sqrt(u_xlat16_22);
        u_xlat16_7.xyz = float3(u_xlat16_22,u_xlat16_22,u_xlat16_22) * u_xlat16_6.xyw;
        u_xlat16_7.xyz = u_xlat16_7.xyz * float3(deltaTime,deltaTime,deltaTime) + u_xlat16_1.xyz;
        u_xlat16_6.xyz = u_xlat16_6.xyw * float3(0.5, 0.5, 0.5);
        u_xlat16_0.yzw = u_xlat16_2.xyz * float3(0.400000006, 0.400000006, 0.400000006) + u_xlat16_6.xyz;
        u_xlat16_0.x = u_xlat16_1.w + deltaTime;
        u_xlat16_1.xyz = (bool(u_xlatb5)) ? u_xlat16_7.xyz : u_xlat16_1.xyz;
        u_xlat16_2.w = u_xlat16_1.w;
        u_xlat16_4 = (bool(u_xlatb5)) ? u_xlat16_0.yzwx : u_xlat16_2;
        u_xlat16_25 = driving * 4.0 + 1.0;
        u_xlat16_2.x = u_xlat16_25 * deltaTime;
        u_xlat16_2.yz = float2(deltaTime,deltaTime);
        u_xlat16_2.xyz = u_xlat16_2.xyz * float3(0.5, -2.5, 0.0) + u_xlat16_4.xyz;
        u_xlat16_25 = (-deltaTime) + 1.0;
        u_xlat16_3.xyz = float3(u_xlat16_25,u_xlat16_25,u_xlat16_25) * u_xlat16_2.xyz;
        u_xlat16_4.xyz = u_xlat16_3.xyz * float3(deltaTime,deltaTime,deltaTime) + u_xlat16_1.xyz;
    }
    outputColor.rt0 = u_xlat16_4;
    outputColor.rt1 = u_xlat16_3;
    return outputColor;

return outputColor;
}
ENDCG
}}}
