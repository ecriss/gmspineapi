/******************************************************************************
 * Spine Runtime Software License - Version 1.0
 * 
 * Copyright (c) 2013, Esoteric Software
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms in whole or in part, with
 * or without modification, are permitted provided that the following conditions
 * are met:
 * 
 * 1. A Spine Single User License or Spine Professional License must be
 *    purchased from Esoteric Software and the license must remain valid:
 *    http://esotericsoftware.com/
 * 2. Redistributions of source code must retain this license, which is the
 *    above copyright notice, this declaration of conditions and the following
 *    disclaimer.
 * 3. Redistributions in binary form must reproduce this license, which is the
 *    above copyright notice, this declaration of conditions and the following
 *    disclaimer, in the documentation and/or other materials provided with the
 *    distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *****************************************************************************/
 
var this = argument[0];
var x1 = argument[1];
var y1 = argument[2];

var slots = ds_map_find_value(this, 'slots');
var boneCount = ds_map_find_value(this, 'boneCount');
var flipX = ds_map_find_value(this, 'flipX');
var flipY = ds_map_find_value(this, 'flipY');

if flipX = 0 flipX = 1; else flipX = -1;
if flipY = 0 flipY = -1; else flipY = 1;

for (i = 0; i < boneCount; ++i) {
  var slot = ds_list_find_value(slots, i);
  var slotData = ds_map_find_value(slot, 'data');
  var bone = ds_map_find_value(slot, 'bone');
  var attachment = ds_map_find_value(slot, 'attachment');
  
  if (attachment) {
        sprite = ds_map_find_value(attachment,'rendererObject');
        
        if (sprite > -1) {

          var color = ds_map_find_value(slotData, 'rgb');
          draw_set_color(color);
          
          //FIXME: somehow this draws upside down so requires flipping
          var vertices = RegionAttachment_computeVertices(attachment, x1*flipX, y1*flipY, bone);
          var tex = sprite_get_texture(sprite, 0);
          draw_primitive_begin_texture(pr_trianglefan, tex);

          draw_vertex_texture(vertices[SPINEAPI_VERTEX_X1]*flipX, vertices[SPINEAPI_VERTEX_Y1]*flipY, 0, 1);  //bottom left
          draw_vertex_texture(vertices[SPINEAPI_VERTEX_X2]*flipX, vertices[SPINEAPI_VERTEX_Y2]*flipY, 0, 0);  //top left
          draw_vertex_texture(vertices[SPINEAPI_VERTEX_X3]*flipX, vertices[SPINEAPI_VERTEX_Y3]*flipY, 1, 0);  //top right
          draw_vertex_texture(vertices[SPINEAPI_VERTEX_X4]*flipX, vertices[SPINEAPI_VERTEX_Y4]*flipY, 1, 1);  //bottom right
 
          draw_primitive_end();

          vertices=0;
        }
  }
}



