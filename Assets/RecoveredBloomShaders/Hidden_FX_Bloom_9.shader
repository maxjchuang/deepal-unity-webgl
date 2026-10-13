Shader "Recovered/Hidden/FX/Bloom/Variant9" {
Properties {
_ClipRect ("Native proxy clip",Vector)=(0,0,1,1)
_MainTex ("Source",2D)="black" {}
_BaseTex ("Base",2D)="black" {}
_BloomThreshold ("Threshold",Float)=4.5947938
_PrefilterOffs ("Offset",Float)=0
_SampleScale ("Scale",Float)=0.6415443

}

SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Back
Blend One Zero, One Zero
ZWrite Off
ZTest Off
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
float4 _ClipRect;
float flipY;
float4 rectRenderClip;
float2 _MainTex_TexelSize;
float _SampleScale;
sampler2D _MainTex;
sampler2D _BaseTex;
struct AppData {
float4 in_POSITION0:POSITION0;
float2 in_TEXCOORD0:TEXCOORD0;
};
struct Varyings { float4 position:SV_POSITION;
float2 vs_TEXCOORD0:TEXCOORD0;
};
Varyings vert(AppData input){Varyings output;output.position=UnityObjectToClipPos(input.in_POSITION0);float2 uv=lerp(_ClipRect.xy,_ClipRect.zw,input.in_TEXCOORD0);output.position.xy=(uv*2-1)*output.position.w;output.vs_TEXCOORD0=uv;return output;}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float4 u_xlat16_0;
float4 u_xlat16_1;
float4 u_xlat16_2;
float4 u_xlat16_3;
float4 u_xlat16_4;
float4 u_xlat16_5;
float u_xlat16_18;

    u_xlat16_0 = tex2D(_MainTex, input.vs_TEXCOORD0.xy);
    u_xlat16_18 = u_xlat16_0.w * 8.0;
    u_xlat16_0.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_0.xyz;
    u_xlat16_1.x = 1.0;
    u_xlat16_1.z = _SampleScale;
    u_xlat16_1 = u_xlat16_1.xxzz * _MainTex_TexelSize.xyxy;
    u_xlat16_2.z = float(-1.0);
    u_xlat16_2.w = float(0.0);
    u_xlat16_2.x = _SampleScale;
    u_xlat16_3 = (-u_xlat16_1.xywy) * u_xlat16_2.xxwx + input.vs_TEXCOORD0.xyxy;
    u_xlat16_4 = tex2D(_MainTex, u_xlat16_3.zw);
    u_xlat16_3 = tex2D(_MainTex, u_xlat16_3.xy);
    u_xlat16_18 = u_xlat16_4.w * 8.0;
    u_xlat16_4.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat16_18 = u_xlat16_3.w * 8.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) + u_xlat16_4.xyz;
    u_xlat16_4.xy = (-u_xlat16_1.zy) * u_xlat16_2.zx + input.vs_TEXCOORD0.xy;
    u_xlat16_4 = tex2D(_MainTex, u_xlat16_4.xy);
    u_xlat16_18 = u_xlat16_4.w * 8.0;
    u_xlat16_3.xyz = u_xlat16_4.xyz * float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_4 = u_xlat16_1.zwxw * u_xlat16_2.zwxw + input.vs_TEXCOORD0.xyxy;
    u_xlat16_5 = u_xlat16_1.zywy * u_xlat16_2.zxwx + input.vs_TEXCOORD0.xyxy;
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_2.xx + input.vs_TEXCOORD0.xy;
    u_xlat16_1 = tex2D(_MainTex, u_xlat16_1.xy);
    u_xlat16_2 = tex2D(_MainTex, u_xlat16_4.xy);
    u_xlat16_4 = tex2D(_MainTex, u_xlat16_4.zw);
    u_xlat16_18 = u_xlat16_2.w * 8.0;
    u_xlat16_2.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * float3(2.0, 2.0, 2.0) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * float3(4.0, 4.0, 4.0) + u_xlat16_2.xyz;
    u_xlat16_18 = u_xlat16_4.w * 8.0;
    u_xlat16_2.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * float3(2.0, 2.0, 2.0) + u_xlat16_0.xyz;
    u_xlat16_2 = tex2D(_MainTex, u_xlat16_5.xy);
    u_xlat16_3 = tex2D(_MainTex, u_xlat16_5.zw);
    u_xlat16_18 = u_xlat16_2.w * 8.0;
    u_xlat16_0.xyz = u_xlat16_2.xyz * float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat16_18 = u_xlat16_3.w * 8.0;
    u_xlat16_2.xyz = float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * float3(2.0, 2.0, 2.0) + u_xlat16_0.xyz;
    u_xlat16_18 = u_xlat16_1.w * 8.0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * float3(0.0625, 0.0625, 0.0625);
    u_xlat16_1 = tex2D(_BaseTex, input.vs_TEXCOORD0.xy);
    u_xlat16_18 = u_xlat16_1.w * 8.0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * float3(u_xlat16_18,u_xlat16_18,u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat16_18 = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_18 = max(u_xlat16_0.z, u_xlat16_18);
    u_xlat16_1.x = max(u_xlat16_18, 0.00100000005);
    outputColor.w = u_xlat16_18 * 0.125 + -0.00499999989;
    outputColor.w = clamp(outputColor.w, 0.0, 1.0);
    outputColor.xyz = u_xlat16_0.xyz / u_xlat16_1.xxx;
    outputColor.xyz = clamp(outputColor.xyz, 0.0, 1.0);
    return outputColor;

return outputColor;
}
ENDCG
}}}
