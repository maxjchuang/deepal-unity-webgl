Shader "Recovered/Hidden/FX/Uber/Variant2" {
Properties {

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
sampler2D _MainTex;
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
float4 u_xlat16_0;
bool u_xlatb1;
float2 u_xlat16_2;
float3 u_xlat16_3;
float3 u_xlat16_4;
float3 u_xlat16_7;
float u_xlat16_12;

    u_xlat16_0 = tex2D(_MainTex, input.vs_TEXCOORD0.xy);
    u_xlatb1 = u_xlat16_0.y>=u_xlat16_0.z;
    u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_7.xy = (-u_xlat16_0.zy) + u_xlat16_0.yz;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat16_7.xy + u_xlat16_0.zy;
    u_xlat16_3.xy = (-u_xlat16_2.xy);
    u_xlat16_3.z = (-u_xlat16_0.x);
    u_xlat16_4.yz = u_xlat16_2.yx + u_xlat16_3.yz;
    u_xlat16_4.x = u_xlat16_0.x + u_xlat16_3.x;
    u_xlatb1 = u_xlat16_0.x>=u_xlat16_2.x;
    u_xlat16_12 = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2.xy = float2(u_xlat16_12,u_xlat16_12) * u_xlat16_4.xy + u_xlat16_2.xy;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_4.z + u_xlat16_0.x;
    u_xlat16_7.x = min(u_xlat16_2.y, u_xlat16_12);
    u_xlat16_7.x = (-u_xlat16_7.x) + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x + 1.00000001e-10;
    u_xlat16_2.x = u_xlat16_7.x / u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_7.x = dot(u_xlat16_0.xyz, float3(0.209999993, 0.709999979, 0.0700000003));
    u_xlat16_7.x = u_xlat16_7.x * 10.0;
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz;
    u_xlat16_7.xyz = clamp(u_xlat16_7.xyz, 0.0, 1.0);
    u_xlat16_7.xyz = (-u_xlat16_0.xyz) + u_xlat16_7.xyz;
    outputColor.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz + u_xlat16_0.xyz;
    outputColor.w = u_xlat16_0.w;
    return outputColor;

return outputColor;
}
ENDCG
}}}
