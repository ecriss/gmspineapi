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

var width = ds_map_find_value(this, 'width');
var height = ds_map_find_value(this, 'height');
var x1 = ds_map_find_value(this, 'x');
var y1 = ds_map_find_value(this, 'y');
var regionOriginalWidth = ds_map_find_value(this, 'regionOriginalWidth');
var regionOriginalHeight = ds_map_find_value(this, 'regionOriginalHeight');
var scaleX = ds_map_find_value(this, 'scaleX');
var scaleY = ds_map_find_value(this, 'scaleY');
var regionOffsetX = ds_map_find_value(this, 'regionOffsetX');
var regionOffsetY = ds_map_find_value(this, 'regionOffsetY');
var regionWidth = ds_map_find_value(this, 'regionWidth');
var regionHeight = ds_map_find_value(this, 'regionHeight');
var rotation = ds_map_find_value(this, 'rotation');
var offset = ds_map_find_value(this, 'offset');

var regionScaleX = width / regionOriginalWidth * scaleX;
var regionScaleY = height / regionOriginalHeight * scaleY;
var localX = -width / 2 * scaleX + regionOffsetX * regionScaleX;
var localY = -height / 2 * scaleY + regionOffsetY * regionScaleY;
var localX2 = localX + regionWidth * regionScaleX;
var localY2 = localY + regionHeight * regionScaleY;
var radians = degtorad(rotation);
var cosine = cos(radians);
var sine = sin(radians);

var localXCos = localX * cosine + x1;
var localXSin = localX * sine;
var localYCos = localY * cosine + y1;
var localYSin = localY * sine;
var localX2Cos = localX2 * cosine + x1;
var localX2Sin = localX2 * sine;
var localY2Cos = localY2 * cosine + y1;
var localY2Sin = localY2 * sine;

offset[SPINEAPI_VERTEX_X1] = localXCos - localYSin;
offset[SPINEAPI_VERTEX_Y1] = localYCos + localXSin;
offset[SPINEAPI_VERTEX_X2] = localXCos - localY2Sin;
offset[SPINEAPI_VERTEX_Y2] = localY2Cos + localXSin;
offset[SPINEAPI_VERTEX_X3] = localX2Cos - localY2Sin;
offset[SPINEAPI_VERTEX_Y3] = localY2Cos + localX2Sin;
offset[SPINEAPI_VERTEX_X4] = localX2Cos - localYSin;
offset[SPINEAPI_VERTEX_Y4] = localYCos + localX2Sin;

ds_map_replace(this, 'offset', offset);
