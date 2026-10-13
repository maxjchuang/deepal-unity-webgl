Shader "Recovered/Hidden/SnowCompute/Variant3" {
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
float4 timePeriod;
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
float4 u_xlat16_1;
uint u_xlatu1;
bool u_xlatb1;
float4 u_xlat16_2;
float3 u_xlat3;
float4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
float4 u_xlat16_4;
float3 u_xlat5;
float3 u_xlat16_6;
float3 u_xlat16_7;
float3 u_xlat10;
float u_xlat12;
float3 u_xlat16_16;
float3 u_xlat16_17;
float u_xlat16_24;
float u_xlat16_33;

float4 hlslcc_FragCoord = float4(input.position.xyz, 1.0/input.position.w);
    u_xlatu0.xy = uint2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = ParticleBufferRT0.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat16_0 = ParticleBufferRT1.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat10.x = float(u_xlatu1);
    u_xlat10.xyz = u_xlat10.xxx * float3(0.0973000005, 0.103, 0.103100002);
    u_xlat10.xyz = frac(u_xlat10.xyz);
    u_xlat3.xyz = u_xlat10.yxz + float3(33.3300018, 33.3300018, 33.3300018);
    u_xlat3.x = dot(u_xlat10.zyx, u_xlat3.xyz);
    u_xlat10.xyz = u_xlat10.xyz + u_xlat3.xxx;
    u_xlat3.xyz = u_xlat10.yxx + u_xlat10.zzy;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xyz;
    u_xlat10.xyz = frac(u_xlat10.xyz);
    u_xlat16_0.w = (-deltaTime) * 0.150000006 + u_xlat16_0.w;
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
    u_xlatb3 = u_xlat16_0.w==0.0;
    if(u_xlatb3){
        u_xlatb3 = u_xlatu1>=startID;
        u_xlatb1 = u_xlatu1<endID;
        u_xlatb1 = u_xlatb1 && u_xlatb3;
        u_xlat3.x = sqrt(u_xlat10.y);
        u_xlat12 = u_xlat10.z * 6.28318548;
        u_xlat4 = sin(u_xlat12);
        u_xlat5.x = cos(u_xlat12);
        u_xlat5.z = u_xlat4;
        u_xlat3.xy = u_xlat3.xx * u_xlat5.xz;
        u_xlat16_6.x = driving * -6.0;
        u_xlat16_6.y = float(4.0);
        u_xlat16_6.z = float(0.0);
        u_xlat16_6.xz = u_xlat3.xy * float2(7.5, 7.5) + u_xlat16_6.xz;
        u_xlat16_2.xyz = (bool(u_xlatb1)) ? u_xlat16_6.xyz : u_xlat16_2.xyz;
        u_xlat16_0.w = 0.0;
        u_xlat16_0 = (bool(u_xlatb1)) ? float4(0.0, -0.100000001, 0.0, 1.0) : u_xlat16_0;
        u_xlat16_2.w = 0.0;
    } else {
        u_xlatb1 = u_xlat16_2.y<0.100000001;
        if(u_xlatb1){
            u_xlat16_6.x = deltaTime * driving;
            u_xlat16_2.x = u_xlat16_6.x * 10.0 + u_xlat16_2.x;
            u_xlat16_2.w = u_xlat16_2.w + deltaTime;
        } else {
            u_xlat16_6.x = u_xlat16_2.x;
            u_xlat16_6.y = 1.0;
            u_xlat16_6.x = dot(float2(0.125, 0.473749995), u_xlat16_6.xy);
            u_xlat16_7.xy = u_xlat16_2.yz;
            u_xlat16_7.z = 1.0;
            u_xlat16_6.y = dot(float3(1.49011603e-08, 0.25, 0.5), u_xlat16_7.xyz);
            u_xlat16_24 = dot(float3(-0.333333403, 1.98682208e-08, 0.833333373), u_xlat16_7.xyz);
            u_xlat16_6.x = texCollision.SampleLevel(samplertexCollision, u_xlat16_6.xy, 0.0).w;
            u_xlatb1 = u_xlat16_6.x<u_xlat16_24;
            u_xlat16_3.x = u_xlat16_2.w + deltaTime;
            u_xlat10.xyz = u_xlat16_0.www + u_xlat10.xyz;
            u_xlat10.xyz = u_xlat10.xyz * float3(6.28318548, 6.28318548, 6.28318548);
            u_xlat10.xyz = u_xlat16_2.xyz * float3(16.3999996, 16.7999992, 17.6000004) + u_xlat10.xyz;
            u_xlat16_6.xyz = u_xlat10.xyz + timePeriod.yyy;
            u_xlat16_16.x = cos(u_xlat16_6.x);
            u_xlat16_6.xy = sin(u_xlat16_6.yz);
            u_xlat16_17.x = driving * 1.5 + 0.150000006;
            u_xlat16_17.y = float(-0.800000012);
            u_xlat16_17.z = float(0.0);
            u_xlat16_16.yz = u_xlat16_6.xy * float2(0.699999988, 1.0);
            u_xlat16_6.xyz = u_xlat16_16.xyz + u_xlat16_17.xyz;
            u_xlat16_6.xyz = u_xlat16_6.xyz * float3(deltaTime,deltaTime,deltaTime) + u_xlat16_0.xyz;
            u_xlat16_33 = (-deltaTime) + 1.0;
            u_xlat16_4.yzw = float3(u_xlat16_33,u_xlat16_33,u_xlat16_33) * u_xlat16_6.xyz;
            u_xlat16_6.xyz = u_xlat16_4.yzw * float3(deltaTime,deltaTime,deltaTime) + u_xlat16_2.xyz;
            u_xlat16_2.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_6.xyz;
            u_xlat16_3.y = float(0.0);
            u_xlat16_3.z = float(0.0);
            u_xlat16_3.w = float(0.0);
            u_xlat16_4.x = u_xlat16_2.w;
            u_xlat16_1 = (bool(u_xlatb1)) ? u_xlat16_3 : u_xlat16_4;
            u_xlat16_0.xyz = u_xlat16_1.yzw;
            u_xlat16_2.w = u_xlat16_1.x;
        }
    }
    outputColor.rt0 = u_xlat16_2;
    outputColor.rt1 = u_xlat16_0;
    return outputColor;

return outputColor;
}
ENDCG
}}}
