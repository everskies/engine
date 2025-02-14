// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <impeller/blending.glsl>
#include <impeller/color.glsl>
#include <impeller/texture.glsl>

uniform BlendInfo {
  float dst_y_coord_scale;
  float src_y_coord_scale;
  float color_factor;
  vec4 color;  // This color input is expected to be unpremultiplied.
}
blend_info;

uniform sampler2D texture_sampler_dst;
uniform sampler2D texture_sampler_src;

in vec2 v_dst_texture_coords;
in vec2 v_src_texture_coords;

out vec4 frag_color;

void main() {
  vec4 dst = IPUnpremultiply(IPSampleWithTileMode(
      texture_sampler_dst,           // sampler
      v_dst_texture_coords,          // texture coordinates
      blend_info.dst_y_coord_scale,  // y coordinate scale
      kTileModeDecal                 // tile mode
      ));
  vec4 src = blend_info.color_factor > 0
                 ? blend_info.color
                 : IPUnpremultiply(IPSampleWithTileMode(
                       texture_sampler_src,           // sampler
                       v_src_texture_coords,          // texture coordinates
                       blend_info.src_y_coord_scale,  // y coordinate scale
                       kTileModeDecal                 // tile mode
                       ));

  vec3 blended = Blend(dst.rgb, src.rgb);

  frag_color = vec4(blended, 1) * src.a * dst.a;
}
