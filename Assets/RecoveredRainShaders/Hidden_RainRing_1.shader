Shader "Recovered/Hidden/RainRing/Variant1" {
Properties { [HDR] _Color ("Color",Color)=(1,1,1,1)
_Size ("Size",Float)=1
_Alpha ("Alpha",Range(0,1))=1
}
SubShader {
Tags {"RenderType"="Transparent" "Queue"="Transparent"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
ZWrite Off
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile_instancing
#include "UnityCG.cginc"
uint wParticleRT;
float densitySkySystem;
float driving;
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
float4 _Color;
float _Size;
float _Alpha;
Texture2D<float4> ParticleBufferRT0; SamplerState samplerParticleBufferRT0;
Texture2D<float4> ParticleBufferRT1; SamplerState samplerParticleBufferRT1;
float4 timePeriod;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
float vs_TEXCOORD2:TEXCOORD0;
float2 vs_TEXCOORD0:TEXCOORD1;
float4 vs_TEXCOORD1:TEXCOORD2;
};
Varyings vert(AppData input, uint instanceID:SV_InstanceID) { Varyings output;
float4 phase0_Output0_0;
float4 u_xlat0;
uint4 u_xlatu0;
float3 u_xlat1;
float4 u_xlat16_1;
float u_xlat16_2;
float4 u_xlat16_3;
float3 u_xlat16_4;
float3 u_xlat16_5;
float3 u_xlat16_8;
float u_xlat16_14;
float u_xlat18;

    u_xlat0.x = float(uint(instanceID));
    u_xlat0.xyz = u_xlat0.xxx * float3(0.103100002, 0.103, 0.0973000005);
    u_xlat0.xyz = frac(u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.yzx + float3(33.3300018, 33.3300018, 33.3300018);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.xyz = float3(u_xlat18,u_xlat18,u_xlat18) + u_xlat0.xyz;
    u_xlat0.xw = u_xlat0.yz + u_xlat0.xx;
    u_xlat0.xy = u_xlat0.zy * u_xlat0.xw;
    u_xlat0.xy = frac(u_xlat0.xy);
    u_xlat0.zw = input.in_POSITION0.xy + float2(0.5, 0.5);
    phase0_Output0_0.xyz = u_xlat0.yzw;
    u_xlat16_2 = u_xlat0.x * 1.5 + 1.5;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    {
        uint quo = uint(instanceID) / wParticleRT;
        u_xlatu0.y = quo;
    }
    u_xlatu0.x = (-u_xlatu0.y) * wParticleRT + uint(instanceID);
    u_xlat16_1 = ParticleBufferRT0.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat16_8.xyz = ParticleBufferRT1.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w))).xyz;
    u_xlat16_8.xyz = u_xlat16_8.yzx * float3(2.0, 2.0, 2.0) + float3(-1.0, -1.0, -1.0);
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_1.w;
    u_xlat16_3.x = u_xlat16_3.x * 3.14159274;
    u_xlat16_3.x = sin(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_3.x;
    u_xlat16_3.xy = float2(u_xlat16_2,u_xlat16_2) * input.in_POSITION0.xy;
    u_xlat16_3.xy = u_xlat16_3.xy * float2(_Size,_Size);
    u_xlat16_4.xyz = u_xlat16_1.zxy * u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_1.yzx * u_xlat16_8.yzx + (-u_xlat16_4.xyz);
    u_xlat16_2 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2 = rsqrt(u_xlat16_2);
    u_xlat16_4.xyz = float3(u_xlat16_2,u_xlat16_2,u_xlat16_2) * u_xlat16_4.xyz;
    u_xlat16_3.xzw = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_1.w) + 1.0;
    u_xlat16_2 = u_xlat16_2 * 3.14159274;
    u_xlat16_2 = sin(u_xlat16_2);
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_4.zxy;
    u_xlat16_4.xyz = u_xlat16_4.yzx * u_xlat16_8.yzx + (-u_xlat16_5.xyz);
    u_xlat16_14 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_14 = rsqrt(u_xlat16_14);
    u_xlat16_4.xyz = float3(u_xlat16_14,u_xlat16_14,u_xlat16_14) * u_xlat16_4.xyz;
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
    output.vs_TEXCOORD1.w = u_xlat16_2 * densitySkySystem;
    output.vs_TEXCOORD1.xyz = _Color.xyz;
    u_xlat0 = u_xlat16_3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat16_3.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat16_3.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    output.position = u_xlat0;
output.vs_TEXCOORD2 = phase0_Output0_0.x;
output.vs_TEXCOORD0 = phase0_Output0_0.yz;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float2 u_xlat16_0;
float3 u_xlat16_1;
float3 u_xlat16_2;
float u_xlat16_4;

    u_xlat16_0.xy = input.vs_TEXCOORD0.xy + float2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_2.x = timePeriod.y + timePeriod.y;
    u_xlat16_2.x = u_xlat16_0.x * 10.0 + (-u_xlat16_2.x);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = rsqrt(u_xlat16_0.x);
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_2.x = input.vs_TEXCOORD2 * 6.28318548 + u_xlat16_2.x;
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 0.5 + 0.5;
    u_xlat16_4 = u_xlat16_0.x * u_xlat16_2.x;
    u_xlat16_0.x = u_xlat16_0.x * input.vs_TEXCOORD1.w;
    u_xlat16_0.x = u_xlat16_2.x * u_xlat16_0.x;
    u_xlat16_1.x = ddx(u_xlat16_4);
    u_xlat16_1.y = ddy(u_xlat16_4);
    u_xlat16_1.z = 0.100000001;
    u_xlat16_2.x = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_2.x = rsqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_1.xyz;
    u_xlat16_2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = u_xlat16_2.x + 0.5;
    outputColor.w = u_xlat16_2.x * u_xlat16_0.x;
    outputColor.xyz = input.vs_TEXCOORD1.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
