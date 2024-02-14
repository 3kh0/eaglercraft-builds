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

in vec2 v_texCoords2f;

#ifndef COMPILE_BLIT_DEPTH
layout(location = 0) out vec4 output4f;
#endif

uniform sampler2D u_inputTexture;
uniform float u_textureLod1f;

#ifdef COMPILE_PIXEL_ALIGNMENT
uniform vec4 u_pixelAlignmentSizes4f;
uniform vec2 u_pixelAlignmentOffset2f;
#endif

void main() {
	vec2 uv2f = v_texCoords2f;
#ifdef COMPILE_PIXEL_ALIGNMENT
	uv2f = (floor(uv2f * u_pixelAlignmentSizes4f.xy) + u_pixelAlignmentOffset2f) * u_pixelAlignmentSizes4f.zw;
#endif
#ifndef COMPILE_BLIT_DEPTH
	output4f = textureLod(u_inputTexture, uv2f, u_textureLod1f);
#else
	gl_FragDepth = textureLod(u_inputTexture, uv2f, u_textureLod1f).r;
#endif
}
