Shader "Recovered/Hidden/FX/Uber/Variant3" {
Properties {
_MainTex ("Source",2D)="white" {}
_Lut2D ("Captured ACES LUT",2D)="black" {}
_BloomTex ("Bloom",2D)="black" {}
_Lut2D_Params ("LUT dimensions",Vector)=(0.0009765625,0.03125,31,0)
_PostExposure ("Exposure",Float)=1
_BloomIntensity ("Bloom intensity",Float)=0
rectRenderClipBloom ("Bloom clip",Vector)=(0,0,1,1)

}
SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Off
Blend One Zero, One Zero
ZWrite Off
ZTest Always
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
float flipY;
float4 rectRenderClip;
float _BloomIntensity;
float4 rectRenderClipBloom;
float3 _Lut2D_Params;
float _PostExposure;
sampler2D _MainTex;
sampler2D _Lut2D;
sampler2D _BloomTex;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
};
// Blit vertex adapter; original fragment arithmetic is preserved below.
Varyings vert(AppData input){Varyings output;output.position=UnityObjectToClipPos(input.in_POSITION0);output.vs_TEXCOORD0=input.in_TEXCOORD0;return output;}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat0;
float4 u_xlat16_0;
float3 u_xlat16_1;
float3 u_xlat16_2;
float3 u_xlat16_3;
float3 u_xlat4;
float3 u_xlat5;
float3 u_xlat16_5;
float3 u_xlat16_7;
float2 u_xlat10;
float3 u_xlat16_10;
float u_xlat16_13;
bool u_xlatb18;
float u_xlat16_19;
float u_xlat22;

    u_xlat0.xyz = tex2D(_MainTex, input.vs_TEXCOORD0.xy).xyz;
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
    u_xlat16_1.xy = float2(u_xlat16_13,u_xlat16_13) * u_xlat16_3.xy + u_xlat16_1.xy;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_3.z + u_xlat0.x;
    u_xlat16_7.x = min(u_xlat16_1.y, u_xlat16_13);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.00000001e-10;
    u_xlat16_1.x = u_xlat16_7.x / u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_7.x = dot(u_xlat0.xyz, float3(0.209999993, 0.709999979, 0.0700000003));
    u_xlat16_7.x = u_xlat16_7.x * 10.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat0.zxy;
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat0.zxy) + u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_7.xyz + u_xlat0.zxy;
    u_xlat16_2.xy = input.vs_TEXCOORD0.xy + (-rectRenderClipBloom.xy);
    u_xlat16_2.xy = abs(u_xlat16_2.xy) * rectRenderClipBloom.zw + float2(-1000.0, -1000.0);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = (-u_xlat16_2.xy) + float2(1.0, 1.0);
    u_xlat16_19 = u_xlat16_2.y * u_xlat16_2.x;
    u_xlat16_19 = u_xlat16_19 * _BloomIntensity;
    u_xlat16_0 = tex2D(_BloomTex, input.vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_0.w * 8.0;
    u_xlat16_2.xyz = u_xlat16_0.zxy * u_xlat16_2.xxx;
    u_xlat16_1.xyz = u_xlat16_2.xyz * float3(u_xlat16_19,u_xlat16_19,u_xlat16_19) + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * float3(float3(_PostExposure, _PostExposure, _PostExposure));
    u_xlat4.xyz = u_xlat16_1.xyz * float3(5.55555582, 5.55555582, 5.55555582) + float3(0.0479959995, 0.0479959995, 0.0479959995);
    u_xlat4.xyz = log2(u_xlat4.xyz);
    u_xlat4.xyz = u_xlat4.xyz * float3(0.0734997839, 0.0734997839, 0.0734997839) + float3(0.386036009, 0.386036009, 0.386036009);
    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
    u_xlat22 = u_xlat4.x * _Lut2D_Params.z;
    u_xlat22 = floor(u_xlat22);
    u_xlat4.x = u_xlat4.x * _Lut2D_Params.z + (-u_xlat22);
    u_xlat10.xy = u_xlat4.yz * _Lut2D_Params.zz + float2(0.5, 0.5);
    u_xlat5.yz = u_xlat10.yx * _Lut2D_Params.yx;
    u_xlat5.x = u_xlat22 * _Lut2D_Params.y + u_xlat5.z;
    u_xlat16_10.xyz = tex2D(_Lut2D, u_xlat5.xy).xyz;
    u_xlat5.x = u_xlat5.x + _Lut2D_Params.y;
    u_xlat16_5.xyz = tex2D(_Lut2D, u_xlat5.xy).xyz;
    u_xlat5.xyz = (-u_xlat16_10.xyz) + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat5.xyz + u_xlat16_10.xyz;
    u_xlat16_1.xyz = u_xlat4.xyz;
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    outputColor.xyz = u_xlat4.xyz;
    outputColor.w = dot(u_xlat16_1.xyz, float3(0.212672904, 0.715152204, 0.0721750036));
    return outputColor;

return outputColor;
}
ENDCG
}}}
