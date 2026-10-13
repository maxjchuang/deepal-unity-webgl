Shader "Recovered/Hidden/RainDrop/Variant1" {
Properties { [HDR] _Color ("Color", Color)=(1,1,1,1)
_Size ("Size",Float)=1
_Alpha ("Alpha",Range(0,1))=1
_MainTex ("Texture",2D)="white" {}
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
float3 skyColor;
float densitySkySystem;
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
float4 _Color;
float _Size;
float _Alpha;
Texture2D<float4> ParticleBufferRT0; SamplerState samplerParticleBufferRT0;
Texture2D<float4> ParticleBufferRT1; SamplerState samplerParticleBufferRT1;
Texture2D<float4> _MainTex; SamplerState sampler_MainTex;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
float4 vs_TEXCOORD1:TEXCOORD1;
};
Varyings vert(AppData input, uint instanceID:SV_InstanceID) { Varyings output;
float4 u_xlat0;
float4 u_xlat16_0;
float4 u_xlat1;
float4 u_xlat16_1;
uint4 u_xlatu1;
float4 u_xlat16_2;
float4 u_xlat3;
float4 u_xlat4;
float3 u_xlat16_5;
float3 u_xlat16_6;
float3 u_xlat16_7;
float u_xlat16_8;
float u_xlat16_16;
float u_xlat16_24;
float u_xlat27;

    u_xlat16_0.xy = input.in_POSITION0.xy + float2(0.5, 0.5);
    output.vs_TEXCOORD0.xy = u_xlat16_0.xy;
    u_xlat16_0.x = skyColor.y * 0.400000006;
    u_xlat16_0.x = min(u_xlat16_0.x, 2.0);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    output.vs_TEXCOORD1.xyz = u_xlat16_0.xxx * _Color.xyz;
    u_xlatu1.z = uint(uint(0u));
    u_xlatu1.w = uint(uint(0u));
    {
        uint quo = uint(instanceID) / wParticleRT;
        u_xlatu1.y = quo;
    }
    u_xlatu1.x = (-u_xlatu1.y) * wParticleRT + uint(instanceID);
    u_xlat16_2 = ParticleBufferRT0.Load(int3( int2(u_xlatu1.xy), int(u_xlatu1.w)));
    u_xlat16_1 = ParticleBufferRT1.Load(int3( int2(u_xlatu1.xy), int(u_xlatu1.w)));
    u_xlat16_0.xzw = u_xlat16_2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_0.x = dot(u_xlat16_0.xzw, u_xlat16_0.xzw);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = (-u_xlat16_0.x) * 0.0599999987 + 1.10000002;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_16 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + 0.200000003;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_16 = (-u_xlat16_1.w) + 1.0;
    u_xlat16_16 = u_xlat16_16 * 6.28318548;
    u_xlat16_16 = cos(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * -0.5 + 0.5;
    u_xlat16_24 = u_xlat16_2.w * 0.100000001;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_16 + (-u_xlat16_24);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x * _Alpha;
    u_xlat16_0.x = u_xlat16_0.x * densitySkySystem;
    u_xlat16_0.x = u_xlat16_0.x * _Color.w;
    output.vs_TEXCOORD1.w = u_xlat16_0.x * 0.400000006;
    u_xlat3.x = float(uint(instanceID));
    u_xlat3 = u_xlat3.xxxx * float4(0.103100002, 0.103, 0.0973000005, 0.109899998);
    u_xlat3 = frac(u_xlat3);
    u_xlat4 = u_xlat3.wzxy + float4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat27 = dot(u_xlat3, u_xlat4);
    u_xlat3.xyz = float3(u_xlat27,u_xlat27,u_xlat27) + u_xlat3.xyz;
    u_xlat3.xw = u_xlat3.yz + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.zy * u_xlat3.xw;
    u_xlat3.xy = frac(u_xlat3.xy);
    u_xlat16_5.x = u_xlat3.x * 0.0999999642 + 0.600000024;
    u_xlat16_0.x = u_xlat3.y * 2.0 + 6.0;
    u_xlat16_16 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_24 = sqrt(u_xlat16_16);
    u_xlat16_16 = rsqrt(u_xlat16_16);
    u_xlat16_6.xyz = float3(u_xlat16_16,u_xlat16_16,u_xlat16_16) * u_xlat16_1.xyz;
    u_xlat16_16 = u_xlat16_1.w * 10.0;
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
    u_xlat16_16 = u_xlat16_16 * _Size;
    u_xlat16_5.y = u_xlat16_24 * u_xlat16_0.x;
    u_xlat16_0.xz = float2(u_xlat16_16,u_xlat16_16) * u_xlat16_5.xy;
    u_xlat16_5.xyz = (-u_xlat16_2.zxy) + _WorldSpaceCameraPos.zxy;
    u_xlat16_24 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_24 = rsqrt(u_xlat16_24);
    u_xlat16_5.xyz = float3(u_xlat16_24,u_xlat16_24,u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_7.xyz = (-u_xlat16_6.yzx) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.zxy * (-u_xlat16_6.zxy) + (-u_xlat16_7.xyz);
    u_xlat16_24 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_24 = rsqrt(u_xlat16_24);
    u_xlat16_5.xyz = float3(u_xlat16_24,u_xlat16_24,u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xxx * u_xlat16_5.xyz;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.z;
    u_xlat16_8 = (-u_xlat16_0.y) + 2.0;
    u_xlat16_0.xzw = (-u_xlat16_6.xyz) * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz * input.in_POSITION0.xxx;
    u_xlat16_0.xyz = u_xlat16_2.xyz * float3(u_xlat16_8,u_xlat16_8,u_xlat16_8) + u_xlat16_0.xzw;
    u_xlat1 = u_xlat16_0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat16_0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat16_0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    output.position = u_xlat0;
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float4 u_xlat16_0;

    u_xlat16_0 = _MainTex.Sample(sampler_MainTex, input.vs_TEXCOORD0.xy);
    outputColor = u_xlat16_0 * input.vs_TEXCOORD1;
    return outputColor;

return outputColor;
}
ENDCG
}}}
