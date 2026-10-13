Shader "Recovered/Hidden/Snow/Variant1" {
Properties { [HDR] _Color ("Color", Color) = (1,1,1,1)
_Size ("Size", Float) = 1
_Alpha ("Alpha", Range(0,1)) = 1
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
#define hlslcc_mtx4x4glstate_matrix_projection transpose(UNITY_MATRIX_P)
#define hlslcc_mtx4x4unity_MatrixV transpose(UNITY_MATRIX_V)
uint wParticleRT;
float3 skyColor;
float densitySkySystem;
float4 _Color;
float _Size;
float _Alpha;
Texture2D<float4> ParticleBufferRT0; SamplerState samplerParticleBufferRT0;
Texture2D<float4> ParticleBufferRT1; SamplerState samplerParticleBufferRT1;
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
uint4 u_xlatu0;
float4 u_xlat1;
float u_xlat16_1;
float4 u_xlat2;
float u_xlat16_3;
float3 u_xlat16_5;
float u_xlat16_9;

    u_xlat0.xy = input.in_POSITION0.xy + float2(0.5, 0.5);
    output.vs_TEXCOORD0.xy = u_xlat0.xy;
    u_xlatu0.z = uint(uint(0u));
    u_xlatu0.w = uint(uint(0u));
    {
        uint quo = uint(instanceID) / wParticleRT;
        u_xlatu0.y = quo;
    }
    u_xlatu0.x = (-u_xlatu0.y) * wParticleRT + uint(instanceID);
    u_xlat16_1 = ParticleBufferRT1.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w))).w;
    u_xlat16_0 = ParticleBufferRT0.Load(int3( int2(u_xlatu0.xy), int(u_xlatu0.w)));
    u_xlat16_1 = u_xlat16_1 * 3.14159274;
    u_xlat16_1 = sin(u_xlat16_1);
    u_xlat16_5.xyz = u_xlat16_0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_5.x = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_5.x = sqrt(u_xlat16_5.x);
    u_xlat16_5.x = (-u_xlat16_5.x) * 0.0599999987 + 1.20000005;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_5.x = u_xlat16_5.x + 0.200000003;
    u_xlat16_5.x = min(u_xlat16_5.x, 1.0);
    u_xlat16_9 = u_xlat16_0.w * 0.5;
    u_xlat16_1 = u_xlat16_5.x * u_xlat16_1 + (-u_xlat16_9);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat16_1 = u_xlat16_1 * densitySkySystem;
    output.vs_TEXCOORD1.w = u_xlat16_1 * _Color.w;
    u_xlat16_1 = skyColor.y * 0.400000006;
    u_xlat16_1 = min(u_xlat16_1, 2.0);
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    output.vs_TEXCOORD1.xyz = float3(u_xlat16_1,u_xlat16_1,u_xlat16_1) * _Color.xyz;
    u_xlat2.xyz = u_xlat16_0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat16_0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat16_0.zzz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_MatrixV[3].xyz;
    u_xlat2.x = float(uint(instanceID));
    u_xlat1 = u_xlat2.xxxx * float4(0.103100002, 0.103, 0.0973000005, 0.109899998);
    u_xlat1 = frac(u_xlat1);
    u_xlat2 = u_xlat1.wzxy + float4(33.3300018, 33.3300018, 33.3300018, 33.3300018);
    u_xlat2.x = dot(u_xlat1, u_xlat2);
    u_xlat2.xyz = u_xlat1.xyz + u_xlat2.xxx;
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat2.x = u_xlat2.z * u_xlat2.x;
    u_xlat2.x = frac(u_xlat2.x);
    u_xlat16_3 = u_xlat2.x * 0.300000072 + 0.899999976;
    u_xlat16_3 = u_xlat16_3 * _Size;
    u_xlat0.xy = input.in_POSITION0.xy * float2(u_xlat16_3,u_xlat16_3) + u_xlat0.xy;
    u_xlat1.x = hlslcc_mtx4x4glstate_matrix_projection[0].z;
    u_xlat1.y = hlslcc_mtx4x4glstate_matrix_projection[1].z;
    u_xlat1.z = hlslcc_mtx4x4glstate_matrix_projection[2].z;
    u_xlat1.w = hlslcc_mtx4x4glstate_matrix_projection[3].z;
    u_xlat0.w = 1.0;
    output.position.z = dot(u_xlat1, u_xlat0);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[0].x;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].x;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].x;
    output.position.x = dot(u_xlat2.xyz, u_xlat0.xzw);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[1].y;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[2].y;
    u_xlat2.z = hlslcc_mtx4x4glstate_matrix_projection[3].y;
    output.position.y = dot(u_xlat2.xyz, u_xlat0.yzw);
    u_xlat2.x = hlslcc_mtx4x4glstate_matrix_projection[2].w;
    u_xlat2.y = hlslcc_mtx4x4glstate_matrix_projection[3].w;
    output.position.w = dot(u_xlat2.xy, u_xlat0.zw);
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float2 u_xlat16_0;

    u_xlat16_0.xy = input.vs_TEXCOORD0.xy + float2(-0.5, -0.5);
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat16_0.x + 1.0;
    outputColor.w = u_xlat16_0.x * input.vs_TEXCOORD1.w;
    outputColor.xyz = input.vs_TEXCOORD1.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
