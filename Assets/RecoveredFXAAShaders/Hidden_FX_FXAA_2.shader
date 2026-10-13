Shader "Recovered/Hidden/FX/FXAA/Variant2" {
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
int op_not(int value){return ~value;}
int2 op_not(int2 value){return ~value;}
int3 op_not(int3 value){return ~value;}
int4 op_not(int4 value){return ~value;}
bool4 notEqual(int4 a,int4 b){return a!=b;}
float4 _MainTex_TexelSize;
float4 _ClipRect;
float flipY;
float4 rectRenderClip;
float4 _rcpFrame;
sampler2D _MainTex;
struct AppData { float4 vertex:POSITION; float2 uv:TEXCOORD0; };
struct Varyings { float4 position:SV_POSITION; float2 vs_TEXCOORD0:TEXCOORD0; float4 vs_TEXCOORD1:TEXCOORD1; };
Varyings vert(AppData input){Varyings output;float2 uv=lerp(_ClipRect.xy,_ClipRect.zw,input.uv);output.position=UnityObjectToClipPos(input.vertex);output.position.xy=(uv*2-1)*output.position.w;output.vs_TEXCOORD0=uv;output.vs_TEXCOORD1=_MainTex_TexelSize.xyxy*float4(-.5,.5,.5,-.5)+uv.xyxy;return output;}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);
float4 u_xlat0;
float3 u_xlat16_0;
float2 u_xlat1;
int u_xlati1;
float3 u_xlat16_2;
float2 u_xlat3;
float2 u_xlat4;
bool u_xlatb4;
float2 u_xlat5;
int2 u_xlati5;
float2 u_xlat6;
int2 u_xlati6;
float3 u_xlat8;
bool3 u_xlatb8;
float3 u_xlat10;
int2 u_xlati10;
bool2 u_xlatb10;
float2 u_xlat11;
bool u_xlatb11;
float u_xlat12;
float2 u_xlat15;
float2 u_xlat17;
int u_xlati17;
float2 u_xlat18;
float u_xlat19;
int2 u_xlati19;
float2 u_xlat20;
float u_xlat22;
bool u_xlatb22;
float u_xlat24;
bool u_xlatb24;
float u_xlat25;

    u_xlat16_0.xyz = tex2Dlod(_MainTex,float4( input.vs_TEXCOORD0.xy,0, 0.0)).xyz;
    u_xlat1.x = dot(u_xlat16_0.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat0 = _rcpFrame.xyxy * float4(0.0, 1.0, 1.0, 0.0) + input.vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat0.xy,0, 0.0)).xyz;
    u_xlat8.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat0.zw,0, 0.0)).xyz;
    u_xlat15.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat0 = _rcpFrame.xyxy * float4(0.0, -1.0, -1.0, 0.0) + input.vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat0.xy,0, 0.0)).xyz;
    u_xlat15.y = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat0.zw,0, 0.0)).xyz;
    u_xlat3.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat3.y = max(u_xlat1.x, u_xlat8.x);
    u_xlat17.x = min(u_xlat1.x, u_xlat8.x);
    u_xlat17.x = min(u_xlat15.x, u_xlat17.x);
    u_xlat10.xz = max(u_xlat15.xy, u_xlat3.yx);
    u_xlat4.x = min(u_xlat15.y, u_xlat3.x);
    u_xlat10.x = max(u_xlat10.x, u_xlat10.z);
    u_xlat17.x = min(u_xlat17.x, u_xlat4.x);
    u_xlat10.x = (-u_xlat17.x) + u_xlat10.x;
    u_xlat17.xy = input.vs_TEXCOORD0.xy + (-_rcpFrame.xy);
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat17.xy,0, 0.0)).xyz;
    u_xlat17.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat4.xy = input.vs_TEXCOORD0.xy + _rcpFrame.xy;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat4.xy,0, 0.0)).xyz;
    u_xlat24 = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat0 = _rcpFrame.xyxy * float4(1.0, -1.0, -1.0, 1.0) + input.vs_TEXCOORD0.xyxy;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat0.xy,0, 0.0)).xyz;
    u_xlat4.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat0.zw,0, 0.0)).xyz;
    u_xlat11.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat18.x = u_xlat8.x + u_xlat15.y;
    u_xlat25 = u_xlat15.x + u_xlat3.x;
    u_xlat10.x = float(1.0) / u_xlat10.x;
    u_xlat5.x = u_xlat25 + u_xlat18.x;
    u_xlat18.x = u_xlat1.x * -2.0 + u_xlat18.x;
    u_xlat25 = u_xlat1.x * -2.0 + u_xlat25;
    u_xlat12 = u_xlat24 + u_xlat4.x;
    u_xlat4.x = u_xlat17.x + u_xlat4.x;
    u_xlat19 = u_xlat15.x * -2.0 + u_xlat12;
    u_xlat4.x = u_xlat15.y * -2.0 + u_xlat4.x;
    u_xlat17.x = u_xlat17.x + u_xlat11.x;
    u_xlat24 = u_xlat24 + u_xlat11.x;
    u_xlat11.x = abs(u_xlat18.x) * 2.0 + abs(u_xlat19);
    u_xlat4.x = abs(u_xlat25) * 2.0 + abs(u_xlat4.x);
    u_xlat18.x = u_xlat3.x * -2.0 + u_xlat17.x;
    u_xlat24 = u_xlat8.x * -2.0 + u_xlat24;
    u_xlat11.x = u_xlat11.x + abs(u_xlat18.x);
    u_xlat24 = u_xlat4.x + abs(u_xlat24);
    u_xlat17.x = u_xlat12 + u_xlat17.x;
    u_xlatb24 = u_xlat11.x>=u_xlat24;
    u_xlat17.x = u_xlat5.x * 2.0 + u_xlat17.x;
    u_xlat8.z = (u_xlatb24) ? u_xlat15.y : u_xlat3.x;
    u_xlat8.x = (u_xlatb24) ? u_xlat8.x : u_xlat15.x;
    u_xlat15.x = (u_xlatb24) ? _rcpFrame.y : _rcpFrame.x;
    u_xlat3.x = u_xlat17.x * 0.0833333358 + (-u_xlat1.x);
    u_xlat17.x = (-u_xlat1.x) + u_xlat8.z;
    u_xlat4.x = (-u_xlat1.x) + u_xlat8.x;
    u_xlat8.xz = u_xlat1.xx + u_xlat8.xz;
    u_xlatb11 = abs(u_xlat17.x)>=abs(u_xlat4.x);
    u_xlat17.x = max(abs(u_xlat17.x), abs(u_xlat4.x));
    u_xlat15.x = (u_xlatb11) ? (-u_xlat15.x) : u_xlat15.x;
    u_xlat3.x = u_xlat10.x * abs(u_xlat3.x);
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat10.x = u_xlatb24 ? _rcpFrame.x : float(0.0);
    u_xlat4.x = (u_xlatb24) ? 0.0 : _rcpFrame.y;
    u_xlat18.xy = u_xlat15.xx * float2(0.5, 0.5) + input.vs_TEXCOORD0.xy;
    u_xlat18.x = (u_xlatb24) ? input.vs_TEXCOORD0.x : u_xlat18.x;
    u_xlat25 = (u_xlatb24) ? u_xlat18.y : input.vs_TEXCOORD0.y;
    u_xlat5.x = (-u_xlat10.x) + u_xlat18.x;
    u_xlat5.y = (-u_xlat4.x) + u_xlat25;
    u_xlat6.x = u_xlat10.x + u_xlat18.x;
    u_xlat6.y = u_xlat4.x + u_xlat25;
    u_xlat18.x = u_xlat3.x * -2.0 + 3.0;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat5.xy,0, 0.0)).xyz;
    u_xlat25 = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat6.xy,0, 0.0)).xyz;
    u_xlat19 = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    u_xlat8.x = (u_xlatb11) ? u_xlat8.z : u_xlat8.x;
    u_xlat22 = u_xlat17.x * 0.25;
    u_xlat1.x = (-u_xlat8.x) * 0.5 + u_xlat1.x;
    u_xlat3.x = u_xlat3.x * u_xlat18.x;
    u_xlati1 = int((u_xlat1.x<0.0) ? 0xFFFFFFFFu : uint(0));
    u_xlat11.x = (-u_xlat8.x) * 0.5 + u_xlat25;
    u_xlat11.y = (-u_xlat8.x) * 0.5 + u_xlat19;
    u_xlati19.xy = int2(uint2((abs(u_xlat11.xyxy) >=  float4(u_xlat22,u_xlat22,u_xlat22,u_xlat22)).xy) * 0xFFFFFFFFu);
    u_xlat17.x = (-u_xlat10.x) * 1.5 + u_xlat5.x;
    u_xlat20.x = (u_xlati19.x != 0) ? u_xlat5.x : u_xlat17.x;
    u_xlat17.x = (-u_xlat4.x) * 1.5 + u_xlat5.y;
    u_xlat20.y = (u_xlati19.x != 0) ? u_xlat5.y : u_xlat17.x;
    u_xlati5.xy = op_not(u_xlati19.xy);
    u_xlati17 = int(uint(uint(u_xlati5.y) | uint(u_xlati5.x)));
    u_xlat25 = u_xlat10.x * 1.5 + u_xlat6.x;
    u_xlat5.x = (u_xlati19.y != 0) ? u_xlat6.x : u_xlat25;
    u_xlat25 = u_xlat4.x * 1.5 + u_xlat6.y;
    u_xlat5.y = (u_xlati19.y != 0) ? u_xlat6.y : u_xlat25;
    if(u_xlati17 != 0) {
        if(u_xlati19.x == 0) {
            u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat20.xy,0, 0.0)).xyz;
            u_xlat11.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
        }
        if(u_xlati19.y == 0) {
            u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat5.xy,0, 0.0)).xyz;
            u_xlat11.y = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
        }
        u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
        u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
        u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
        u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat17.x;
        u_xlati19.xy = int2(uint2((abs(u_xlat11.xyxy) >=  float4(u_xlat22,u_xlat22,u_xlat22,u_xlat22)).xy) * 0xFFFFFFFFu);
        u_xlat17.x = (-u_xlat10.x) * 2.0 + u_xlat20.x;
        u_xlat20.x = (u_xlati19.x != 0) ? u_xlat20.x : u_xlat17.x;
        u_xlat17.x = (-u_xlat4.x) * 2.0 + u_xlat20.y;
        u_xlat20.y = (u_xlati19.x != 0) ? u_xlat20.y : u_xlat17.x;
        u_xlati6.xy = op_not(u_xlati19.xy);
        u_xlati17 = int(uint(uint(u_xlati6.y) | uint(u_xlati6.x)));
        u_xlat25 = u_xlat10.x * 2.0 + u_xlat5.x;
        u_xlat5.x = (u_xlati19.y != 0) ? u_xlat5.x : u_xlat25;
        u_xlat25 = u_xlat4.x * 2.0 + u_xlat5.y;
        u_xlat5.y = (u_xlati19.y != 0) ? u_xlat5.y : u_xlat25;
        if(u_xlati17 != 0) {
            if(u_xlati19.x == 0) {
                u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat20.xy,0, 0.0)).xyz;
                u_xlat11.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
            }
            if(u_xlati19.y == 0) {
                u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat5.xy,0, 0.0)).xyz;
                u_xlat11.y = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
            }
            u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
            u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
            u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
            u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat17.x;
            u_xlati19.xy = int2(uint2((abs(u_xlat11.xyxy) >=  float4(u_xlat22,u_xlat22,u_xlat22,u_xlat22)).xy) * 0xFFFFFFFFu);
            u_xlat17.x = (-u_xlat10.x) * 2.0 + u_xlat20.x;
            u_xlat20.x = (u_xlati19.x != 0) ? u_xlat20.x : u_xlat17.x;
            u_xlat17.x = (-u_xlat4.x) * 2.0 + u_xlat20.y;
            u_xlat20.y = (u_xlati19.x != 0) ? u_xlat20.y : u_xlat17.x;
            u_xlati6.xy = op_not(u_xlati19.xy);
            u_xlati17 = int(uint(uint(u_xlati6.y) | uint(u_xlati6.x)));
            u_xlat25 = u_xlat10.x * 2.0 + u_xlat5.x;
            u_xlat5.x = (u_xlati19.y != 0) ? u_xlat5.x : u_xlat25;
            u_xlat25 = u_xlat4.x * 2.0 + u_xlat5.y;
            u_xlat5.y = (u_xlati19.y != 0) ? u_xlat5.y : u_xlat25;
            if(u_xlati17 != 0) {
                if(u_xlati19.x == 0) {
                    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat20.xy,0, 0.0)).xyz;
                    u_xlat11.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
                }
                if(u_xlati19.y == 0) {
                    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat5.xy,0, 0.0)).xyz;
                    u_xlat11.y = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
                }
                u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
                u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
                u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
                u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat17.x;
                u_xlati19.xy = int2(uint2((abs(u_xlat11.xyxy) >=  float4(u_xlat22,u_xlat22,u_xlat22,u_xlat22)).xy) * 0xFFFFFFFFu);
                u_xlat17.x = (-u_xlat10.x) * 4.0 + u_xlat20.x;
                u_xlat20.x = (u_xlati19.x != 0) ? u_xlat20.x : u_xlat17.x;
                u_xlat17.x = (-u_xlat4.x) * 4.0 + u_xlat20.y;
                u_xlat20.y = (u_xlati19.x != 0) ? u_xlat20.y : u_xlat17.x;
                u_xlati6.xy = op_not(u_xlati19.xy);
                u_xlati17 = int(uint(uint(u_xlati6.y) | uint(u_xlati6.x)));
                u_xlat25 = u_xlat10.x * 4.0 + u_xlat5.x;
                u_xlat5.x = (u_xlati19.y != 0) ? u_xlat5.x : u_xlat25;
                u_xlat25 = u_xlat4.x * 4.0 + u_xlat5.y;
                u_xlat5.y = (u_xlati19.y != 0) ? u_xlat5.y : u_xlat25;
                if(u_xlati17 != 0) {
                    if(u_xlati19.x == 0) {
                        u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat20.xy,0, 0.0)).xyz;
                        u_xlat11.x = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
                    }
                    if(u_xlati19.y == 0) {
                        u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat5.xy,0, 0.0)).xyz;
                        u_xlat11.y = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
                    }
                    u_xlat17.x = (-u_xlat8.x) * 0.5 + u_xlat11.x;
                    u_xlat11.x = (u_xlati19.x != 0) ? u_xlat11.x : u_xlat17.x;
                    u_xlat8.x = (-u_xlat8.x) * 0.5 + u_xlat11.y;
                    u_xlat11.y = (u_xlati19.y != 0) ? u_xlat11.y : u_xlat8.x;
                    u_xlatb8.xz = (abs(u_xlat11.xxyy) >=  float4(u_xlat22,u_xlat22,u_xlat22,u_xlat22)).xz;
                    u_xlat17.x = (-u_xlat10.x) * 2.0 + u_xlat20.x;
                    u_xlat20.x = (u_xlatb8.x) ? u_xlat20.x : u_xlat17.x;
                    u_xlat17.x = (-u_xlat4.x) * 2.0 + u_xlat20.y;
                    u_xlat20.y = (u_xlatb8.x) ? u_xlat20.y : u_xlat17.x;
                    u_xlat8.x = u_xlat10.x * 2.0 + u_xlat5.x;
                    u_xlat5.x = (u_xlatb8.z) ? u_xlat5.x : u_xlat8.x;
                    u_xlat8.x = u_xlat4.x * 2.0 + u_xlat5.y;
                    u_xlat5.y = (u_xlatb8.z) ? u_xlat5.y : u_xlat8.x;
                }
            }
        }
    }
    u_xlat8.x = (-u_xlat20.x) + input.vs_TEXCOORD0.x;
    u_xlat22 = u_xlat5.x + (-input.vs_TEXCOORD0.x);
    u_xlat10.x = (-u_xlat20.y) + input.vs_TEXCOORD0.y;
    u_xlat8.x = (u_xlatb24) ? u_xlat8.x : u_xlat10.x;
    u_xlat10.x = u_xlat5.y + (-input.vs_TEXCOORD0.y);
    u_xlat22 = (u_xlatb24) ? u_xlat22 : u_xlat10.x;
    u_xlati10.xy = int2(uint2((u_xlat11.xyxx <  float4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlat4.x = u_xlat8.x + u_xlat22;
    u_xlatb10.xy = notEqual(int4(u_xlati1,u_xlati1,u_xlati1,u_xlati1), u_xlati10.xyxx).xy;
    u_xlat1.x = float(1.0) / u_xlat4.x;
    u_xlatb4 = u_xlat8.x<u_xlat22;
    u_xlat8.x = min(u_xlat22, u_xlat8.x);
    u_xlatb22 = (u_xlatb4) ? u_xlatb10.x : u_xlatb10.y;
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat1.x = u_xlat8.x * (-u_xlat1.x) + 0.5;
    u_xlat8.x = u_xlat3.x * 0.75;
    u_xlat1.x = u_xlatb22 ? u_xlat1.x : float(0.0);
    u_xlat1.x = max(u_xlat8.x, u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * u_xlat15.xx + input.vs_TEXCOORD0.xy;
    u_xlat3.x = (u_xlatb24) ? input.vs_TEXCOORD0.x : u_xlat1.x;
    u_xlat3.y = (u_xlatb24) ? u_xlat1.y : input.vs_TEXCOORD0.y;
    u_xlat16_2.xyz = tex2Dlod(_MainTex,float4( u_xlat3.xy,0, 0.0)).xyz;
    outputColor.w = dot(u_xlat16_2.xyz, float3(0.298999995, 0.587000012, 0.114));
    outputColor.xyz = u_xlat16_2.xyz;
    return outputColor;

return outputColor;
}
ENDCG
}}}
