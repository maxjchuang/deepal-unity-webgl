// Recovered Hidden/SkyGradient fragment: base + ratio * (override - base).
Shader "Recovered/Hidden/SkyGradient" {Properties {_MainTex("Original BG_Bright",2D)="white"{} skyTexOverride("Sky override",2D)="white"{} skyTexOverrideRatio("Override ratio",Float)=0}
SubShader {Tags {"Queue"="Background"}Pass {Cull Off ZWrite Off ZTest LEqual CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
struct V{float4 pos:SV_POSITION;float2 uv:TEXCOORD0;};
V vert(appdata_base v){V o;o.pos=UnityObjectToClipPos(v.vertex);o.uv=v.texcoord;return o;}
sampler2D _MainTex,skyTexOverride;float skyTexOverrideRatio;
float4 frag(V i):SV_Target {float3 base=tex2D(_MainTex,i.uv).rgb;float3 extra=tex2D(skyTexOverride,i.uv).rgb;return float4(base+skyTexOverrideRatio*(extra-base),1);}
ENDCG }} }
