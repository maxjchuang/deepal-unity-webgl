Shader "Recovered/Hidden/SnowCompute/Variant1" {
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
uint numParticle;
uint wParticleRT;
uint rateNum;
Texture2D<float4> ParticleBufferRT0; SamplerState samplerParticleBufferRT0;
Texture2D<float4> ParticleBufferRT1; SamplerState samplerParticleBufferRT1;
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
float u_xlat1;
uint u_xlatu1;
float3 u_xlat2;
float4 u_xlat16_2;
bool u_xlatb2;
float3 u_xlat3;
float3 u_xlat16_4;
float3 u_xlat6;
float u_xlat11;
uint u_xlatu16;
bool u_xlatb16;

float4 hlslcc_FragCoord = float4(input.position.xyz, 1.0/input.position.w);
    u_xlatu0.xy = uint2(hlslcc_FragCoord.xy);
    u_xlatu1 = u_xlatu0.y * wParticleRT + u_xlatu0.x;
    u_xlat6.x = float(u_xlatu1);
    u_xlat6.xyz = u_xlat6.xxx * float3(0.103100002, 0.103, 0.0973000005);
    u_xlat6.xyz = frac(u_xlat6.xyz);
    u_xlat2.xyz = u_xlat6.yzx + float3(33.3300018, 33.3300018, 33.3300018);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat6.xyz = u_xlat6.xyz + u_xlat2.xxx;
    u_xlat2.xy = u_xlat6.zz + u_xlat6.xy;
    u_xlat6.xy = u_xlat6.yx * u_xlat2.xy;
    u_xlat6.xy = frac(u_xlat6.xy);
    u_xlat11 = u_xlat6.y * 6.28318548;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat2.x = sin(u_xlat11);
    u_xlat3.x = cos(u_xlat11);
    u_xlat3.z = u_xlat2.x;
    u_xlat6.xy = u_xlat6.xx * u_xlat3.xz;
    u_xlat6.xy = u_xlat6.xy * float2(7.5, 7.5);
    u_xlatu16 = numParticle + (-rateNum);
    u_xlatb16 = u_xlatu16<u_xlatu1;
    u_xlatb2 = u_xlatu1<numParticle;
    u_xlatu1 = (-u_xlatu1) + numParticle;
    u_xlat1 = float(u_xlatu1);
    u_xlatb16 = u_xlatb16 && u_xlatb2;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    u_xlat16_2 = ParticleBufferRT0.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w))).wxyz;
    u_xlat16_0 = ParticleBufferRT1.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w))).wxyz;
    outputColor.rt0.xz = (bool(u_xlatb16)) ? u_xlat6.xy : u_xlat16_2.yw;
    u_xlat6.x = float(rateNum);
    u_xlat1 = u_xlat1 / u_xlat6.x;
    u_xlat1 = min(u_xlat1, 1.0);
    u_xlat1 = (-u_xlat1) + 1.0;
    u_xlat16_4.x = u_xlat1 * 4.0;
    outputColor.rt0.y = (u_xlatb16) ? u_xlat16_4.x : u_xlat16_2.z;
    outputColor.rt0.w = (u_xlatb16) ? 0.0 : u_xlat16_2.x;
    u_xlat16_4.x = (-u_xlat1) + 1.0;
    u_xlat16_4.y = u_xlat16_4.x * -2.5 + -0.100000001;
    u_xlat16_4.x = float(0.0);
    u_xlat16_4.z = float(0.0);
    outputColor.rt1.xyz = (bool(u_xlatb16)) ? u_xlat16_4.xyz : u_xlat16_0.yzw;
    outputColor.rt1.w = (u_xlatb16) ? u_xlat1 : u_xlat16_0.x;
    return outputColor;

return outputColor;
}
ENDCG
}}}
