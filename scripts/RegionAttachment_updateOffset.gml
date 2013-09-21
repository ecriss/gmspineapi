/*******************************************************************************
 * Copyright (c) 2013, Esoteric Software
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
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
 ******************************************************************************/
 
var _self = argument[0];

/*UV indices*/
/*
var VERTEX_X1 = 0, 
VERTEX_Y1 = 1, 
VERTEX_X2 = 2, 
VERTEX_Y2 = 3, 
VERTEX_X3 = 4, 
VERTEX_Y3 = 5, 
VERTEX_X4 = 6, 
VERTEX_Y4 = 7;

var width = ds_map_find_value(_self, 'width');
var height = ds_map_find_value(_self, 'height');
var x1 = ds_map_find_value(_self, 'x');
var y1 = ds_map_find_value(_self, 'y');
var regionOriginalWidth = ds_map_find_value(_self, 'regionOriginalWidth');
var regionOriginalHeight = ds_map_find_value(_self, 'regionOriginalHeight');
var scaleX = ds_map_find_value(_self, 'scaleX');
var scaleY = ds_map_find_value(_self, 'scaleY');
var regionOffsetX = ds_map_find_value(_self, 'regionOffsetX');
var regionScaleY = ds_map_find_value(_self, 'regionScaleY');
var regionWidth = ds_map_find_value(_self, 'regionWidth');
var regionHeight = ds_map_find_value(_self, 'regionHeight');
var rotation = ds_map_find_value(_self, 'rotation');
var offset = ds_map_find_value(_self, 'offset');

var regionScaleX = width / regionOriginalWidth * scaleX;
var regionScaleY = height / regionOriginalHeight * scaleY;
var localX = -width / 2 * scaleX + regionOffsetX * regionScaleX;
var localY = -height / 2 * scaleY + regionOffsetY * regionScaleY;
var localX2 = localX + regionWidth * regionScaleX;
var localY2 = localY + regionHeight * regionScaleY;
var radians = degtorad(roation);
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

ds_list_insert(offset, VERTEX_X1,  localXCos - localYSin);
ds_list_insert(offset, VERTEX_Y1,  localYCos + localXSin);
ds_list_insert(offset, VERTEX_X2,  localXCos - localY2Sin);
ds_list_insert(offset, VERTEX_Y2,  localY2Cos + localXSin);
ds_list_insert(offset, VERTEX_X3,  localX2Cos - localY2Sin);
ds_list_insert(offset, VERTEX_Y3,  localY2Cos + localX2Sin);
ds_list_insert(offset, VERTEX_X4,  localX2Cos - localYSin);
ds_list_insert(offset, VERTEX_Y4,  localYCos + localX2Sin);
*/
