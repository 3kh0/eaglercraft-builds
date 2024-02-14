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
precision mediump float;
precision mediump sampler2D;

in vec2 v_texCoord2f;
in vec4 v_color4f;
in vec2 v_lightmap2f;

layout(location = 0) out vec4 gbufferColor4f;
layout(location = 1) out vec4 gbufferNormal4f;
layout(location = 2) out vec4 gbufferMaterial4f;

uniform sampler2D u_diffuseTexture;
uniform sampler2D u_samplerNormalMaterial;

uniform vec2 u_textureYScale2f;

void main() {
	vec4 diffuseRGBA = texture(u_diffuseTexture, v_texCoord2f) * v_color4f;
	if(diffuseRGBA.a < 0.004) {
		discard;
	}
	gbufferColor4f = vec4(diffuseRGBA.rgb, v_lightmap2f.r);
	gbufferNormal4f = vec4(0.5, 0.5, 1.0, v_lightmap2f.g);
	gbufferMaterial4f = vec4(texture(u_samplerNormalMaterial, vec2(v_texCoord2f.x, v_texCoord2f.y * u_textureYScale2f.x + u_textureYScale2f.y)).rgb, 1.0);
}
