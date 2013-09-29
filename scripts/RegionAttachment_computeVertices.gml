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
var bone = argument[3];
var vertices;

var offset = ds_map_find_value(this, 'offset');
x1 += ds_map_find_value(bone, 'worldX');
y1 += ds_map_find_value(bone, 'worldY');

var m00 = ds_map_find_value(bone, 'm00');
var m10 = ds_map_find_value(bone, 'm10');
var m11 = ds_map_find_value(bone, 'm11');
var m01 = ds_map_find_value(bone, 'm01');

var ox1 = offset[SPINEAPI_VERTEX_X1];
var oy1 = offset[SPINEAPI_VERTEX_Y1];
var ox2 = offset[SPINEAPI_VERTEX_X2];
var oy2 = offset[SPINEAPI_VERTEX_Y2];
var ox3 = offset[SPINEAPI_VERTEX_X3];
var oy3 = offset[SPINEAPI_VERTEX_Y3];
var ox4 = offset[SPINEAPI_VERTEX_X4];
var oy4 = offset[SPINEAPI_VERTEX_Y4];

vertices[SPINEAPI_VERTEX_X1] = ox1 * m00 + oy1 * m01 + x1;
vertices[SPINEAPI_VERTEX_Y1] = ox1 * m10 + oy1 * m11 + y1;
vertices[SPINEAPI_VERTEX_X2] = ox2 * m00 + oy2 * m01 + x1;
vertices[SPINEAPI_VERTEX_Y2] = ox2 * m10 + oy2 * m11 + y1;
vertices[SPINEAPI_VERTEX_X3] = ox3 * m00 + oy3 * m01 + x1;
vertices[SPINEAPI_VERTEX_Y3] = ox3 * m10 + oy3 * m11 + y1;
vertices[SPINEAPI_VERTEX_X4] = ox4 * m00 + oy4 * m01 + x1;
vertices[SPINEAPI_VERTEX_Y4] = ox4 * m10 + oy4 * m11 + y1;
          
return vertices;


