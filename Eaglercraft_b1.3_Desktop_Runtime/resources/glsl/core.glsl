
// copyright (c) 2020-2023 lax1dude

#line 4

precision highp int;
precision highp sampler2D;
precision highp float;

uniform mat4 matrix_m;
uniform mat4 matrix_p;
uniform mat4 matrix_t;

#ifdef CC_VERT

in vec3 a_position;
#ifdef CC_a_texture0
in vec2 a_texture0;
#endif
#ifdef CC_a_color
in vec4 a_color;
#endif
#ifdef CC_a_normal
in vec4 a_normal;
#endif

#ifdef CC_fog
out vec4 v_position;
#endif
#ifdef CC_a_color
out vec4 v_color;
#endif
#ifdef CC_a_normal
out vec4 v_normal;
#endif
#ifdef CC_a_texture0
out vec2 v_texture0;
#endif

void main(){
	vec4 pos = matrix_m * vec4(a_position, 1.0);
#ifdef CC_fog
	v_position = pos;
#endif
#ifdef CC_a_color
	v_color = a_color;
#endif
#ifdef CC_a_normal
	v_normal = a_normal;
#endif
#ifdef CC_a_texture0
	v_texture0 = a_texture0;
#endif
	gl_Position = matrix_p * pos;
}

#endif

#ifdef CC_FRAG

#ifdef CC_unit0
uniform sampler2D tex0;
#ifndef CC_a_texture0
uniform vec2 texCoordV0;
#endif
#endif
#ifdef CC_lighting
uniform vec3 light0Pos;
uniform vec3 light1Pos;
uniform vec3 normalUniform;
#endif
#ifdef CC_fog
uniform vec4 fogColor;
uniform int fogMode;
uniform float fogStart;
uniform float fogEnd;
uniform float fogDensity;
uniform float fogPremultiply;
#endif
uniform vec4 colorUniform;
#ifdef CC_alphatest
uniform float alphaTestF;
#endif

#ifdef CC_fog
in vec4 v_position;
#endif
#ifdef CC_a_color
in vec4 v_color;
#endif
#ifdef CC_a_normal
in vec4 v_normal;
#endif
#ifdef CC_a_texture0
in vec2 v_texture0;
#endif

out vec4 fragColor;

#define TEX_MAT3x2(mat4In) mat3x2(mat4In[0].xy,mat4In[1].xy,mat4In[3].xy)

void main(){
#ifdef CC_a_color
	vec4 color = colorUniform * v_color;
#else
	vec4 color = colorUniform;
#endif
	
#ifdef CC_unit0
#ifdef CC_a_texture0
	color *= texture(tex0, (TEX_MAT3x2(matrix_t) * vec3(v_texture0, 1.0)).xy).rgba;
#else
	color *= texture(tex0, (TEX_MAT3x2(matrix_t) * vec3(texCoordV0, 1.0)).xy).rgba;
#endif
#endif

#ifdef CC_alphatest
	if(color.a < alphaTestF){
		discard;
	}
#endif

#ifdef CC_lighting
#ifdef CC_a_normal
	vec3 normal = ((v_normal.xyz - 0.5) * 2.0);
#else
	vec3 normal = normalUniform;
#endif
	normal = normalize(mat3(matrix_m) * normal);
	float ins = max(dot(normal, -light0Pos), 0.0) + max(dot(normal, -light1Pos), 0.0);
	color.rgb *= min((0.4 + ins * 0.6), 1.0);
#endif
	
#ifdef CC_fog
	float dist = sqrt(dot(v_position, v_position));
	float i = (fogMode == 1) ? clamp((dist - fogStart) / (fogEnd - fogStart), 0.0, 1.0) : clamp(1.0 - exp(-(fogDensity * dist)), 0.0, 1.0);
	color.rgb = mix(color.rgb, fogColor.xyz, i * fogColor.a);
#endif
	
	fragColor = color;
}

#endif

