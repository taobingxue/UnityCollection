Shader "Hidden/Grayscale Effect" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_RampTex ("Base (RGB)", 2D) = "grayscaleRamp" {}
}

SubShader {
	Pass {
		ZTest Always Cull Off ZWrite Off
				
CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
uniform half _RampOffset;
uniform half _XOffset;

struct a2v {
	float4 position: POSITION;
	half2 uv: TEXCOORD0;
};
struct v2f {
	float4 position: SV_POSITION;
	half2 uv: TEXCOORD0;
};

v2f vert(a2v i) {
	v2f o;
	o.position = mul(UNITY_MATRIX_MVP, i.position);
	
	float4 tmp = float4 (i.uv.x, i.uv.y, 0, 0);
	tmp = mul(UNITY_MATRIX_TEXTURE0, tmp);
	o.uv = tmp.xy;
	
	o.position.x /= 2;
	if (_XOffset == 0) o.position.x -= 0.5;
	else o.position.x += 0.5;
	//UNITY_TRANSFER_FOG(o, o.position);
	return o;
}

fixed4 frag (v2f i) : SV_Target
{
	fixed4 original = tex2D(_MainTex, i.uv);
	fixed grayscale = Luminance(original.rgb);
	half2 remap = half2 (grayscale + _RampOffset, .5);
	fixed4 output = tex2D(_RampTex, remap);
	output.a = original.a;
	return output;
}
ENDCG

	}
}

Fallback off

}
