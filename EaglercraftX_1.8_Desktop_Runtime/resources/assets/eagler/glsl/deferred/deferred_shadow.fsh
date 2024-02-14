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

#if !defined(COMPILE_ENABLE_ALPHA_TEST) && !defined(COMPILE_COLORED_SHADOWS)
#undef COMPILE_ENABLE_TEXTURE2D
#endif

#ifdef COMPILE_COLORED_SHADOWS
layout(location = 0) out vec4 output4f;
uniform vec4 u_color4f;
#endif

#ifdef COMPILE_ENABLE_TEXTURE2D
uniform sampler2D u_samplerTexture;
#ifdef COMPILE_TEXTURE_ATTRIB
in vec2 v_texture2f;
#else
uniform vec2 u_textureCoords01;
#endif
#ifdef COMPILE_ENABLE_ALPHA_TEST
uniform float u_alphaTestRef1f;
#endif
#endif

void main() {
#ifdef COMPILE_COLORED_SHADOWS
	vec4 color = u_color4f;
#else
	vec4 color = vec4(1.0);
#endif

#ifdef COMPILE_ENABLE_TEXTURE2D
#ifdef COMPILE_TEXTURE_ATTRIB
	color *= texture(u_samplerTexture, v_texture2f);
#else
	color *= texture(u_samplerTexture, u_textureCoords01);
#endif
#ifdef COMPILE_ENABLE_ALPHA_TEST
	if(color.a < u_alphaTestRef1f) discard;
#endif
#endif

#ifdef COMPILE_COLORED_SHADOWS
	output4f = vec4(mix(vec3(1.0), color.rgb, color.a), color.a);
#endif
}
