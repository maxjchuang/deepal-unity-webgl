Shader "Recovered/CarRP/Unlit/DepthOnlyRefection/Variant1" {
Properties {
[Toggle] fixMirror ("FixMirror", Float) = 0.0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2.0
}

SubShader {
Tags {"Queue"="Geometry" "RenderType"="Opaque"}
Pass {Tags {"LightMode"="ForwardBase"}
Cull [_Cull]
Blend One Zero, One Zero
ColorMask 0
ZWrite On
ZTest LEqual
CGPROGRAM
#pragma target 3.5
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#define hlslcc_mtx4x4unity_MatrixVP transpose(UNITY_MATRIX_VP)
#define hlslcc_mtx4x4unity_ObjectToWorld transpose(unity_ObjectToWorld)
float fixMirror;
struct AppData {
float4 in_POSITION0:POSITION0;
};
struct Varyings { float4 position:SV_POSITION;
};
Varyings vert(AppData input) { Varyings output;
float4 u_xlat0;
float4 u_xlat1;
float3 u_xlat2;

    u_xlat0.x = fixMirror * -2.0 + 1.0;
    u_xlat0.x = u_xlat0.x * input.in_POSITION0.z;
    u_xlat2.xyz = input.in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * input.in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.xxx + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1 = (-u_xlat0.yyyy) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    output.position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    return output;

return output;
}
float4 frag(Varyings input):SV_Target {float4 outputColor=float4(0,0,0,1);


    outputColor = float4(0.0, 0.0, 0.0, 0.0);
    return outputColor;

return outputColor;
}
ENDCG
}}}
