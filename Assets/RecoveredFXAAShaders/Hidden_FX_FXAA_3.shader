Shader "Recovered/Hidden/FX/FXAA/Variant3" {
Properties {
_ClipRect("Clip rectangle",Vector)=(0,0,1,1)

_MainTex("Source",2D)="white"{}
_rcpFrame("Reciprocal frame",Vector)=(1,1,0,0)
_rcpFrameOpt("Reciprocal frame options",Vector)=(2,2,.5,.5)


}

SubShader {
Tags {"RenderType"="Opaque" "Queue"="Geometry"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull Off
Blend One Zero, One Zero
ZWrite Off
ZTest Off
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
float4 _MainTex_TexelSize;
float4 _ClipRect;
float flipY;
float4 rectRenderClip;
float4 _rcpFrameOpt;
sampler2D _MainTex;
struct AppData { float4 vertex:POSITION; float2 uv:TEXCOORD0; };
struct Varyings { float4 position:SV_POSITION; float2 vs_TEXCOORD0:TEXCOORD0; float4 vs_TEXCOORD1:TEXCOORD1; };
Varyings vert(AppData input){Varyings output;float2 uv=lerp(_ClipRect.xy,_ClipRect.zw,input.uv);output.position=UnityObjectToClipPos(input.vertex);output.position.xy=(uv*2-1)*output.position.w;output.vs_TEXCOORD0=uv;output.vs_TEXCOORD1=_MainTex_TexelSize.xyxy*float4(-.5,.5,.5,-.5)+uv.xyxy;return output;}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float3 u_xlat16_0;
float u_xlat1;
bool u_xlatb1;
float4 u_xlat16_2;
float2 u_xlat3;
float4 u_xlat16_3;
float2 u_xlat4;
float3 u_xlat16_5;
float3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
float u_xlat16_12;
float u_xlat13;
float2 u_xlat15;
float u_xlat16_18;
float u_xlat19;
bool u_xlatb19;

    u_xlat16_0.xyz = tex2Dlod(_MainTex,float4( input.vs_TEXCOORD1.zy,0, 0.0)).xyz;
    u_xlat1 = dot(u_xlat16_0.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_0.x = u_xlat1 + 0.00260416674;
    u_xlat16_6.xyz = tex2Dlod(_MainTex,float4( input.vs_TEXCOORD1.xw,0, 0.0)).xyz;
    u_xlat1 = dot(u_xlat16_6.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_6.x = (-u_xlat16_0.x) + u_xlat1;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( input.vs_TEXCOORD1.xy,0, 0.0)).xyz;
    u_xlat7 = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_12 = u_xlat16_6.x + (-u_xlat7);
    u_xlat16_6.x = u_xlat16_6.x + u_xlat7;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( input.vs_TEXCOORD1.zw,0, 0.0)).xyz;
    u_xlat13 = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.x = u_xlat16_12 + u_xlat13;
    u_xlat16_2.y = u_xlat16_6.x + (-u_xlat13);
    u_xlat19 = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat3.x = rsqrt(u_xlat19);
    u_xlat19 = sqrt(u_xlat19);
    u_xlatb19 = u_xlat19<9.99999975e-06;
    u_xlat3.xy = u_xlat16_2.xy * u_xlat3.xx;
    u_xlat3.xy = (bool(u_xlatb19)) ? float2(0.0, 0.0) : u_xlat3.xy;
    u_xlat16_6.x = min(abs(u_xlat3.y), abs(u_xlat3.x));
    u_xlat16_6.x = u_xlat16_6.x * 8.0;
    u_xlat16_6.xy = u_xlat3.xy / u_xlat16_6.xx;
    u_xlat16_6.xy = max(u_xlat16_6.xy, float2(-2.0, -2.0));
    u_xlat16_6.xy = min(u_xlat16_6.xy, float2(2.0, 2.0));
    u_xlat15.xy = (-u_xlat16_6.xy) * _rcpFrameOpt.xy + input.vs_TEXCOORD0.xy;
    u_xlat4.xy = u_xlat16_6.xy * _rcpFrameOpt.xy + input.vs_TEXCOORD0.xy;
    u_xlat16_6.xyz = tex2Dlod(_MainTex,float4( u_xlat4.xy,0, 0.0)).xyz;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat15.xy,0, 0.0)).xyz;
    u_xlat19 = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat15.x = dot(u_xlat16_6.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.w = u_xlat19 + u_xlat15.x;
    u_xlat15.xy = (-u_xlat3.xy) * _rcpFrameOpt.zw + input.vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat3.xy * _rcpFrameOpt.zw + input.vs_TEXCOORD0.xy;
    u_xlat16_6.xyz = tex2Dlod(_MainTex,float4( u_xlat3.xy,0, 0.0)).xyz;
    u_xlat16_5.xyz = tex2Dlod(_MainTex,float4( u_xlat15.xy,0, 0.0)).xyz;
    u_xlat19 = dot(u_xlat16_5.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.xyz = u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.x = dot(u_xlat16_6.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_3.w = u_xlat19 + u_xlat4.x;
    u_xlat16_3 = u_xlat16_3 * float4(0.5, 0.5, 0.5, 0.5);
    u_xlat16_2 = u_xlat16_2 * float4(0.5, 0.5, 0.5, 0.5) + u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * float4(0.5, 0.5, 0.5, 0.5);
    u_xlat16_6.x = min(u_xlat16_0.x, u_xlat13);
    u_xlat16_0.x = max(u_xlat16_0.x, u_xlat13);
    u_xlat16_12 = min(u_xlat1, u_xlat7);
    u_xlat16_18 = max(u_xlat1, u_xlat7);
    u_xlat16_0.x = max(u_xlat16_0.x, u_xlat16_18);
    u_xlatb1 = u_xlat16_0.x<u_xlat16_2.w;
    u_xlat16_0.x = min(u_xlat16_6.x, u_xlat16_12);
    u_xlatb7 = u_xlat16_2.w<u_xlat16_0.x;
    u_xlatb1 = u_xlatb1 || u_xlatb7;
    outputColor = (bool(u_xlatb1)) ? u_xlat16_3 : u_xlat16_2;
    return outputColor;

return outputColor;
}
ENDCG
}}}
