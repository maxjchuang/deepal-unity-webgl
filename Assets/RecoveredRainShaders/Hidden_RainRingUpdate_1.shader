Shader "Recovered/Hidden/RainRingUpdate/Variant1" {
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
uint numParticle;
uint wParticleRT;
uint wParticleExRT;
uint indexFramePeriod;
float driving;
Texture2D<float4> ParticleBufferRT0; SamplerState samplerParticleBufferRT0;
Texture2D<float4> ParticleBufferRT1; SamplerState samplerParticleBufferRT1;
Texture2D<float4> ParticleExBufferRT0; SamplerState samplerParticleExBufferRT0;
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
float4 u_xlat16_2;
float u_xlat16_3;
uint4 u_xlatu3;
bool u_xlatb4;
float3 u_xlat16_5;
float3 u_xlat16_6;
float u_xlat8;
bool u_xlatb11;
float u_xlat15;
float u_xlat16_23;
float u_xlat16_26;

float4 hlslcc_FragCoord = float4(input.position.xyz, 1.0/input.position.w);
    u_xlatu0.xy = uint2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = ParticleBufferRT0.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat16_0 = ParticleBufferRT1.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat8 = float(u_xlatu1);
    u_xlat8 = u_xlat8 * 0.103100002;
    u_xlat8 = frac(u_xlat8);
    u_xlat15 = u_xlat8 + 33.3300018;
    u_xlat8 = u_xlat15 * u_xlat8;
    u_xlat8 = dot(float2(u_xlat8,u_xlat8), float2(u_xlat8,u_xlat8));
    u_xlat8 = frac(u_xlat8);
    u_xlat16_3 = (-u_xlat8) + 3.0;
    u_xlat16_23 = (-deltaTime) * u_xlat16_3 + u_xlat16_2.w;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlatu1 = numParticle * indexFramePeriod + u_xlatu1;
    {
        uint quo = u_xlatu1 / wParticleExRT;
        u_xlatu3.y = quo;
    }
    u_xlatu3.x = (-u_xlatu3.y) * wParticleExRT + u_xlatu1;
    u_xlatu3.z = uint(uint(0u));
    u_xlatu3.w = uint(uint(0u));
    u_xlat16_1 = ParticleExBufferRT0.Load(int3( int2(u_xlatu3.xy), int(u_xlatu3.w)));
    u_xlatb4 = u_xlat16_23==0.0;
    u_xlatb11 = 0.0<u_xlat16_1.w;
    u_xlatb4 = u_xlatb11 && u_xlatb4;
    if(u_xlatb4){
        u_xlat16_5.x = u_xlat16_1.x;
        u_xlat16_5.y = 1.0;
        u_xlat16_5.x = dot(float2(0.125, 0.473749995), u_xlat16_5.xy);
        u_xlat16_6.xy = u_xlat16_1.yz;
        u_xlat16_6.z = 1.0;
        u_xlat16_5.y = dot(float3(1.49011603e-08, 0.25, 0.5), u_xlat16_6.xyz);
        u_xlat16_5.xyz = texCollision.Sample(samplertexCollision, u_xlat16_5.xy).xyz;
        u_xlat16_5.xyz = u_xlat16_5.xyz * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
        u_xlat16_26 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
        u_xlat16_26 = rsqrt(u_xlat16_26);
        u_xlat16_5.xyz = float3(u_xlat16_26,u_xlat16_26,u_xlat16_26) * u_xlat16_5.xyz;
        outputColor.rt0.xyz = u_xlat16_5.xyz * float3(0.00300000003, 0.00300000003, 0.00300000003) + u_xlat16_1.xyz;
        u_xlat16_0.xyz = u_xlat16_5.xyz * float3(0.5, 0.5, 0.5) + float3(0.5, 0.5, 0.5);
        outputColor.rt0.w = 1.0;
    } else {
        u_xlatb4 = u_xlat16_2.y<0.100000001;
        u_xlat16_5.x = deltaTime * driving;
        u_xlat16_5.x = u_xlat16_5.x * 10.0 + u_xlat16_2.x;
        outputColor.rt0.x = (u_xlatb4) ? u_xlat16_5.x : u_xlat16_2.x;
        outputColor.rt0.yz = u_xlat16_2.yz;
        outputColor.rt0.w = u_xlat16_23;
    }
    outputColor.rt1 = u_xlat16_0;
    return outputColor;

return outputColor;
}
ENDCG
}}}
