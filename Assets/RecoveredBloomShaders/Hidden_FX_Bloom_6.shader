Shader "Recovered/Hidden/FX/Bloom/Variant6" {
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
sampler2D _MainTex;
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
float u_xlat16_9;
float u_xlat16_10;

    u_xlat16_0 = _MainTex_TexelSize.xyxy * float4(-1.0, -1.0, 1.0, -1.0) + input.vs_TEXCOORD0.xyxy;
    u_xlat16_1 = tex2D(_MainTex, u_xlat16_0.zw);
    u_xlat16_0 = tex2D(_MainTex, u_xlat16_0.xy);
    u_xlat16_10 = u_xlat16_1.w * 8.0;
    u_xlat16_1.xyz = float3(u_xlat16_10,u_xlat16_10,u_xlat16_10) * u_xlat16_1.xyz;
    u_xlat16_9 = u_xlat16_0.w * 8.0;
    u_xlat16_0.xyz = u_xlat16_0.xyz * float3(u_xlat16_9,u_xlat16_9,u_xlat16_9) + u_xlat16_1.xyz;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * float4(-1.0, 1.0, 1.0, 1.0) + input.vs_TEXCOORD0.xyxy;
    u_xlat16_2 = tex2D(_MainTex, u_xlat16_1.xy);
    u_xlat16_1 = tex2D(_MainTex, u_xlat16_1.zw);
    u_xlat16_9 = u_xlat16_2.w * 8.0;
    u_xlat16_0.xyz = u_xlat16_2.xyz * float3(u_xlat16_9,u_xlat16_9,u_xlat16_9) + u_xlat16_0.xyz;
    u_xlat16_9 = u_xlat16_1.w * 8.0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * float3(u_xlat16_9,u_xlat16_9,u_xlat16_9) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * float3(0.25, 0.25, 0.25);
    u_xlat16_9 = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_9 = max(u_xlat16_0.z, u_xlat16_9);
    u_xlat16_1.x = max(u_xlat16_9, 0.00100000005);
    outputColor.w = u_xlat16_9 * 0.125 + -0.00499999989;
    outputColor.w = clamp(outputColor.w, 0.0, 1.0);
    outputColor.xyz = u_xlat16_0.xyz / u_xlat16_1.xxx;
    outputColor.xyz = clamp(outputColor.xyz, 0.0, 1.0);
    return outputColor;

return outputColor;
}
ENDCG
}}}
