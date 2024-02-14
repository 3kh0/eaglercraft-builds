#line 2

/*
 * Copyright (c) 2023 lax1dude. All Rights Reserved.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 * 
 */

precision lowp int;
precision highp float;
precision highp sampler2D;

layout(location = 0) out vec4 output4f;

uniform sampler2D u_gbufferColorTexture;
uniform sampler2D u_gbufferNormalTexture;
uniform sampler2D u_gbufferMaterialTexture;

uniform sampler2D u_gbufferDepthTexture;
uniform sampler2D u_metalsLUT;

uniform mat4 u_inverseProjectionMatrix4f;
uniform mat4 u_inverseViewMatrix4f;

uniform vec2 u_viewportSize2f;
uniform vec3 u_lightPosition3f;
uniform vec3 u_lightColor3f;

#define LIB_INCLUDE_PBR_LIGHTING_FUNCTION
#EAGLER INCLUDE (3) "eagler:glsl/deferred/lib/pbr_lighting.glsl"

void main() {
	vec2 v_position2f = gl_FragCoord.xy * u_viewportSize2f;
	vec3 diffuseColor3f;
	vec3 normalVector3f;
	vec2 lightmapCoords2f;
	vec3 materialData3f;

	float depth = textureLod(u_gbufferDepthTexture, v_position2f, 0.0).r;
	if(depth < 0.00001) {
		discard;
	}

	vec4 worldSpacePosition = vec4(v_position2f, depth, 1.0);
	worldSpacePosition.xyz *= 2.0;
	worldSpacePosition.xyz -= 1.0;
	worldSpacePosition = u_inverseProjectionMatrix4f * worldSpacePosition;
	vec4 worldSpacePosition2 = worldSpacePosition;
	worldSpacePosition = u_inverseViewMatrix4f * worldSpacePosition;
	vec3 lightDist = (worldSpacePosition.xyz / worldSpacePosition.w) - u_lightPosition3f;
	vec3 color3f = u_lightColor3f / dot(lightDist, lightDist);

	if(color3f.r + color3f.g + color3f.b < 0.025) {
		discard;
	}

	vec4 sampleVar4f = textureLod(u_gbufferColorTexture, v_position2f, 0.0);
	diffuseColor3f.rgb = sampleVar4f.rgb;
	lightmapCoords2f.x = sampleVar4f.a;
	sampleVar4f = textureLod(u_gbufferNormalTexture, v_position2f, 0.0);
	normalVector3f.xyz = sampleVar4f.rgb * 2.0 - 1.0;
	lightmapCoords2f.y = sampleVar4f.a;
	materialData3f = textureLod(u_gbufferMaterialTexture, v_position2f, 0.0).rgb;

	vec3 worldSpaceNormal = normalize(mat3(u_inverseViewMatrix4f) * normalVector3f);

	vec3 lightDir3f = normalize(lightDist);
	lightDir3f = materialData3f.b == 1.0 ? worldSpaceNormal : -lightDir3f;

	if(dot(lightDir3f, worldSpaceNormal) <= 0.0) {
		discard;
	}

	diffuseColor3f *= diffuseColor3f;
	worldSpacePosition2 = u_inverseViewMatrix4f * vec4(worldSpacePosition2.xyz / worldSpacePosition2.w, 0.0);
	worldSpacePosition2.xyz = normalize(worldSpacePosition2.xyz);
	output4f = vec4(eaglercraftLighting(diffuseColor3f, color3f, -worldSpacePosition2.xyz, lightDir3f, worldSpaceNormal, materialData3f), 0.0);
}
