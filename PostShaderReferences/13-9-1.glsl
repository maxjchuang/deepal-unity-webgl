#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float flipY;
uniform 	vec4 rectRenderClip;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
float u_xlat0;
vec2 u_xlat1;
void main()
{
    gl_Position.zw = vec2(0.0, 1.0);
    u_xlat0 = flipY * -2.0 + 1.0;
    u_xlat1.xy = in_POSITION0.xy * rectRenderClip.zw + rectRenderClip.xy;
    gl_Position.y = u_xlat0 * u_xlat1.y;
    gl_Position.x = u_xlat1.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _Lut2D_Params;
uniform 	mediump vec3 _ColorBalance;
uniform 	mediump vec3 _ColorFilter;
uniform 	mediump vec3 _HueSatCon;
uniform 	mediump vec3 _ChannelMixerRed;
uniform 	mediump vec3 _ChannelMixerGreen;
uniform 	mediump vec3 _ChannelMixerBlue;
uniform 	mediump vec3 _Lift;
uniform 	mediump vec3 _InvGamma;
uniform 	mediump vec3 _Gain;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
bool u_xlatb7;
mediump vec2 u_xlat16_9;
mediump vec3 u_xlat16_11;
float u_xlat14;
bool u_xlatb14;
float u_xlat15;
bool u_xlatb15;
mediump float u_xlat16_16;
mediump vec2 u_xlat16_18;
float u_xlat21;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.yz = vs_TEXCOORD0.xy + (-_Lut2D_Params.yz);
    u_xlat1.x = u_xlat0.y * _Lut2D_Params.x;
    u_xlat0.x = fract(u_xlat1.x);
    u_xlat1.x = u_xlat0.x / _Lut2D_Params.x;
    u_xlat0.w = u_xlat0.y + (-u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xzw * _Lut2D_Params.www + vec3(-0.386036009, -0.386036009, -0.386036009);
    u_xlat0.xyz = u_xlat0.xyz * vec3(13.6054821, 13.6054821, 13.6054821);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.0479959995, -0.0479959995, -0.0479959995);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.179999992, 0.179999992, 0.179999992);
    u_xlat16_2.x = dot(vec3(0.439700991, 0.382977992, 0.177334994), u_xlat0.xyz);
    u_xlat16_2.y = dot(vec3(0.0897922963, 0.813422978, 0.0967615992), u_xlat0.xyz);
    u_xlat16_2.z = dot(vec3(0.0175439995, 0.111543998, 0.870703995), u_xlat0.xyz);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = min(u_xlat16_2.xyz, vec3(65504.0, 65504.0, 65504.0));
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.5, 0.5, 0.5) + vec3(1.525878e-05, 1.525878e-05, 1.525878e-05);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlatb0.xyz = lessThan(u_xlat16_2.xyzx, vec4(3.05175708e-05, 3.05175708e-05, 3.05175708e-05, 0.0)).xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz + vec3(9.72000027, 9.72000027, 9.72000027);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.0570776239, 0.0570776239, 0.0570776239);
    {
        vec4 hlslcc_movcTemp = u_xlat16_2;
        hlslcc_movcTemp.x = (u_xlatb0.x) ? u_xlat16_3.x : u_xlat16_2.x;
        hlslcc_movcTemp.y = (u_xlatb0.y) ? u_xlat16_3.y : u_xlat16_2.y;
        hlslcc_movcTemp.z = (u_xlatb0.z) ? u_xlat16_3.z : u_xlat16_2.z;
        u_xlat16_2 = hlslcc_movcTemp;
    }
    u_xlat0.xyz = u_xlat16_2.xyz + vec3(-0.413588405, -0.413588405, -0.413588405);
    u_xlat0.xyz = u_xlat0.xyz * _HueSatCon.zzz + vec3(0.413588405, 0.413588405, 0.413588405);
    u_xlatb1 = lessThan(u_xlat0.xxyy, vec4(-0.301369876, 1.46799636, -0.301369876, 1.46799636));
    u_xlat16_2.xyz = u_xlat0.xyz * vec3(17.5200005, 17.5200005, 17.5200005) + vec3(-9.72000027, -9.72000027, -9.72000027);
    u_xlatb0.xy = lessThan(u_xlat0.zzzz, vec4(-0.301369876, 1.46799636, 0.0, 0.0)).xy;
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_3.x = (u_xlatb1.y) ? u_xlat16_2.x : float(65504.0);
    u_xlat16_3.y = (u_xlatb1.w) ? u_xlat16_2.y : float(65504.0);
    u_xlat16_2.xyw = u_xlat16_2.xyz + vec3(-1.52587891e-05, -1.52587891e-05, -1.52587891e-05);
    u_xlat16_16 = (u_xlatb0.y) ? u_xlat16_2.z : 65504.0;
    u_xlat16_2.xyw = u_xlat16_2.xyw + u_xlat16_2.xyw;
    {
        vec3 hlslcc_movcTemp = u_xlat16_3;
        hlslcc_movcTemp.x = (u_xlatb1.x) ? u_xlat16_2.x : u_xlat16_3.x;
        hlslcc_movcTemp.y = (u_xlatb1.z) ? u_xlat16_2.y : u_xlat16_3.y;
        u_xlat16_3 = hlslcc_movcTemp;
    }
    u_xlat16_3.z = (u_xlatb0.x) ? u_xlat16_2.w : u_xlat16_16;
    u_xlat16_2.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat16_3.xyz);
    u_xlat16_2.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat16_3.xyz);
    u_xlat16_2.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat16_3.xyz);
    u_xlat0.x = dot(vec3(0.390404999, 0.549941003, 0.00892631989), u_xlat16_2.xyz);
    u_xlat0.y = dot(vec3(0.070841603, 0.963172019, 0.00135775004), u_xlat16_2.xyz);
    u_xlat0.z = dot(vec3(0.0231081992, 0.128021002, 0.936245024), u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * _ColorBalance.xyz;
    u_xlat1.x = dot(vec3(2.85846996, -1.62879002, -0.0248910002), u_xlat0.xyz);
    u_xlat1.y = dot(vec3(-0.210181996, 1.15820003, 0.000324280991), u_xlat0.xyz);
    u_xlat1.z = dot(vec3(-0.0418119989, -0.118169002, 1.06867003), u_xlat0.xyz);
    u_xlat16_2.xyz = u_xlat1.xyz * _ColorFilter.xyz;
    u_xlat0.x = dot(u_xlat16_2.xyz, _ChannelMixerRed.xyz);
    u_xlat0.y = dot(u_xlat16_2.xyz, _ChannelMixerGreen.xyz);
    u_xlat0.z = dot(u_xlat16_2.xyz, _ChannelMixerBlue.xyz);
    u_xlat0.xyz = u_xlat0.xyz * _Gain.xyz + _Lift.xyz;
    u_xlat1.xyz = log2(abs(u_xlat0.xyz));
    u_xlatb0.xyz = greaterThanEqual(u_xlat0.xyzx, vec4(0.0, 0.0, 0.0, 0.0)).xyz;
    u_xlat0.x = (u_xlatb0.x) ? float(1.0) : float(-1.0);
    u_xlat0.y = (u_xlatb0.y) ? float(1.0) : float(-1.0);
    u_xlat0.z = (u_xlatb0.z) ? float(1.0) : float(-1.0);
    u_xlat1.xyz = u_xlat1.xyz * _InvGamma.xyz;
    u_xlat1.xyz = exp2(u_xlat1.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xy = (-u_xlat16_2.zy) + u_xlat16_2.yz;
    u_xlatb14 = u_xlat16_2.y>=u_xlat16_2.z;
    u_xlat14 = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy + u_xlat16_2.zy;
    u_xlat3.w = (-u_xlat16_2.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(-1.0);
    u_xlat1.zw = vec2(u_xlat14) * u_xlat0.xy + vec2(-1.0, 0.666666687);
    u_xlat3.xyz = (-u_xlat1.xyw);
    u_xlat0.yzw = u_xlat1.yzx + u_xlat3.yzw;
    u_xlat0.x = u_xlat16_2.x + u_xlat3.x;
    u_xlatb15 = u_xlat16_2.x>=u_xlat1.x;
    u_xlat15 = u_xlatb15 ? 1.0 : float(0.0);
    u_xlat21 = u_xlat15 * u_xlat0.w + u_xlat16_2.x;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyw;
    u_xlat1.x = min(u_xlat0.y, u_xlat21);
    u_xlat7.x = (-u_xlat0.y) + u_xlat21;
    u_xlat21 = u_xlat0.x + (-u_xlat1.x);
    u_xlat1.x = u_xlat21 * 6.0 + 9.99999975e-06;
    u_xlat7.x = u_xlat7.x / u_xlat1.x;
    u_xlat7.x = u_xlat7.x + u_xlat0.z;
    u_xlat16_2.x = abs(u_xlat7.x) + _HueSatCon.x;
    u_xlatb7 = 1.0<u_xlat16_2.x;
    u_xlat1.xy = u_xlat16_2.xx + vec2(1.0, -1.0);
    u_xlat7.x = (u_xlatb7) ? u_xlat1.y : u_xlat16_2.x;
    u_xlatb14 = u_xlat16_2.x<0.0;
    u_xlat7.x = (u_xlatb14) ? u_xlat1.x : u_xlat7.x;
    u_xlat1.xyz = u_xlat7.xxx + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat1.xyz = abs(u_xlat1.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = clamp(u_xlat1.xyz, 0.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.x = u_xlat0.x + 9.99999975e-06;
    u_xlat7.x = u_xlat21 / u_xlat7.x;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat7.xyz * u_xlat0.xxx;
    u_xlat1.x = dot(u_xlat1.xyz, vec3(0.212672904, 0.715152204, 0.0721750036));
    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz + (-u_xlat1.xxx);
    u_xlat0.xyz = _HueSatCon.yyy * u_xlat0.xyz + u_xlat1.xxx;
    u_xlat16_9.y = dot(vec3(-0.00552588282, 0.00402521016, 1.00150073), u_xlat0.xyz);
    u_xlat16_9.x = dot(vec3(0.0447945632, 0.859671116, 0.0955343172), u_xlat0.xyz);
    u_xlat16_4.x = dot(vec3(0.695452213, 0.140678704, 0.163869068), u_xlat0.xyz);
    u_xlat16_11.x = (-u_xlat16_9.y) + u_xlat16_9.x;
    u_xlat16_11.x = u_xlat16_11.x * 1.73205078;
    u_xlat16_18.x = u_xlat16_4.x * 2.0 + (-u_xlat16_9.x);
    u_xlat16_18.x = (-u_xlat16_9.y) + u_xlat16_18.x;
    u_xlat16_25 = max(abs(u_xlat16_18.x), abs(u_xlat16_11.x));
    u_xlat16_25 = float(1.0) / u_xlat16_25;
    u_xlat16_5.x = min(abs(u_xlat16_18.x), abs(u_xlat16_11.x));
    u_xlat16_25 = u_xlat16_25 * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_25 * u_xlat16_25;
    u_xlat0.x = u_xlat16_5.x * 0.0208350997 + -0.0851330012;
    u_xlat0.x = u_xlat16_5.x * u_xlat0.x + 0.180141002;
    u_xlat0.x = u_xlat16_5.x * u_xlat0.x + -0.330299497;
    u_xlat0.x = u_xlat16_5.x * u_xlat0.x + 0.999866009;
    u_xlat7.x = u_xlat0.x * u_xlat16_25;
    u_xlat7.x = u_xlat7.x * -2.0 + 1.57079637;
    u_xlatb14 = abs(u_xlat16_18.x)<abs(u_xlat16_11.x);
    u_xlat7.x = u_xlatb14 ? u_xlat7.x : float(0.0);
    u_xlat0.x = u_xlat16_25 * u_xlat0.x + u_xlat7.x;
    u_xlatb7 = u_xlat16_18.x<(-u_xlat16_18.x);
    u_xlat7.x = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat7.x + u_xlat0.x;
    u_xlat16_25 = min(u_xlat16_18.x, u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_18.x, u_xlat16_11.x);
    u_xlatb7 = u_xlat16_11.x>=(-u_xlat16_11.x);
    u_xlatb14 = u_xlat16_25<(-u_xlat16_25);
    u_xlatb7 = u_xlatb7 && u_xlatb14;
    u_xlat0.x = (u_xlatb7) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat16_11.x = u_xlat0.x * 57.2957802;
    u_xlatb0.x = u_xlat16_9.x==u_xlat16_4.x;
    u_xlatb7 = u_xlat16_9.y==u_xlat16_9.x;
    u_xlatb0.x = u_xlatb7 && u_xlatb0.x;
    u_xlat16_11.x = (u_xlatb0.x) ? 0.0 : u_xlat16_11.x;
    u_xlatb0.x = u_xlat16_11.x<0.0;
    u_xlat16_18.x = u_xlat16_11.x + 360.0;
    u_xlat16_11.x = (u_xlatb0.x) ? u_xlat16_18.x : u_xlat16_11.x;
    u_xlatb0.x = 180.0<u_xlat16_11.x;
    u_xlat16_18.xy = u_xlat16_11.xx + vec2(360.0, -360.0);
    u_xlat16_25 = (u_xlatb0.x) ? u_xlat16_18.y : u_xlat16_11.x;
    u_xlatb0.x = u_xlat16_11.x<-180.0;
    u_xlat16_11.x = (u_xlatb0.x) ? u_xlat16_18.x : u_xlat16_25;
    u_xlat0.x = u_xlat16_11.x * 0.0148148146;
    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat7.x = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat7.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_11.x = min(u_xlat16_9.x, u_xlat16_4.x);
    u_xlat16_11.x = min(u_xlat16_9.y, u_xlat16_11.x);
    u_xlat16_18.x = max(u_xlat16_9.x, u_xlat16_4.x);
    u_xlat16_11.y = max(u_xlat16_9.y, u_xlat16_18.x);
    u_xlat16_11.xyz = max(u_xlat16_11.xyy, vec3(9.99999975e-05, 9.99999975e-05, 0.00999999978));
    u_xlat16_11.x = (-u_xlat16_11.x) + u_xlat16_11.y;
    u_xlat16_11.x = u_xlat16_11.x / u_xlat16_11.z;
    u_xlat0.x = u_xlat0.x * u_xlat16_11.x;
    u_xlat7.x = (-u_xlat16_4.x) + 0.0299999993;
    u_xlat0.x = u_xlat7.x * u_xlat0.x;
    u_xlat2.x = u_xlat0.x * 0.180000007 + u_xlat16_4.x;
    u_xlat2.yz = u_xlat16_9.xy;
    u_xlat16_4.x = dot(vec3(1.45143926, -0.236510754, -0.214928567), u_xlat2.xyz);
    u_xlat0.yz = u_xlat2.yz;
    u_xlat16_4.y = dot(vec3(-0.0765537769, 1.17622972, -0.0996759236), u_xlat2.xyz);
    u_xlat0.x = u_xlat2.x;
    u_xlat16_4.z = dot(vec3(0.00831614807, -0.00603244966, 0.997716308), u_xlat0.xyz);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.x = dot(u_xlat16_4.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat7.xyz = (-u_xlat0.xxx) + u_xlat16_4.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.959999979, 0.959999979, 0.959999979) + u_xlat0.xxx;
    u_xlat1.xyz = u_xlat0.xyz * vec3(278.508514, 278.508514, 278.508514) + vec3(10.7771997, 10.7771997, 10.7771997);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat6.xyz = u_xlat0.xyz * vec3(293.604492, 293.604492, 293.604492) + vec3(88.7121964, 88.7121964, 88.7121964);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat6.xyz + vec3(80.6889038, 80.6889038, 80.6889038);
    u_xlat0.xyz = u_xlat1.xyz / u_xlat0.xyz;
    u_xlat16_4.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat16_4.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat16_4.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat16_18.x = dot(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_18.x = max(u_xlat16_18.x, 9.99999975e-05);
    u_xlat16_5.xy = u_xlat16_4.xy / u_xlat16_18.xx;
    u_xlat16_4.x = max(u_xlat16_4.y, 0.0);
    u_xlat16_4.x = min(u_xlat16_4.x, 65504.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * 0.981100023;
    u_xlat16_4.y = exp2(u_xlat16_4.x);
    u_xlat16_25 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_5.z = (-u_xlat16_5.y) + u_xlat16_25;
    u_xlat16_25 = max(u_xlat16_5.y, 9.99999975e-05);
    u_xlat16_25 = u_xlat16_4.y / u_xlat16_25;
    u_xlat16_4.xz = vec2(u_xlat16_25) * u_xlat16_5.xz;
    u_xlat16_5.x = dot(vec3(1.6410234, -0.324803293, -0.236424699), u_xlat16_4.xyz);
    u_xlat16_5.y = dot(vec3(-0.663662851, 1.61533165, 0.0167563483), u_xlat16_4.xyz);
    u_xlat16_5.z = dot(vec3(0.0117218941, -0.00828444213, 0.988394856), u_xlat16_4.xyz);
    u_xlat0.x = dot(u_xlat16_5.xyz, vec3(0.272228986, 0.674081981, 0.0536894985));
    u_xlat7.xyz = (-u_xlat0.xxx) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat7.xyz * vec3(0.930000007, 0.930000007, 0.930000007) + u_xlat0.xxx;
    u_xlat1.x = dot(vec3(0.662454188, 0.134004205, 0.156187683), u_xlat0.xyz);
    u_xlat1.y = dot(vec3(0.272228718, 0.674081743, 0.0536895171), u_xlat0.xyz);
    u_xlat1.z = dot(vec3(-0.00557464967, 0.0040607336, 1.01033914), u_xlat0.xyz);
    u_xlat0.x = dot(vec3(0.987223983, -0.00611326983, 0.0159533005), u_xlat1.xyz);
    u_xlat0.y = dot(vec3(-0.00759836007, 1.00186002, 0.00533019984), u_xlat1.xyz);
    u_xlat0.z = dot(vec3(0.00307257008, -0.00509594986, 1.08168006), u_xlat1.xyz);
    u_xlat1.x = dot(vec3(3.2409699, -1.5373832, -0.498610765), u_xlat0.xyz);
    u_xlat1.y = dot(vec3(-0.969243646, 1.8759675, 0.0415550582), u_xlat0.xyz);
    u_xlat1.z = dot(vec3(0.0556300804, -0.203976959, 1.05697155), u_xlat0.xyz);
    u_xlat16_4.xyz = u_xlat1.xyz * vec3(1.06006002, 1.05999994, 1.05900002);
    SV_Target0.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    SV_Target0.w = 1.0;
    return;
}

#endif
