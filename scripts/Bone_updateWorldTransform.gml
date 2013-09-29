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
var flipX = argument[1];
var flipY = argument[2];

var radians, cosine, sine, worldX, worldY, worldScaleX, worldScaleY, worldRotation;
var parent = ds_map_find_value(this, 'parent');
var yDown = ds_map_find_value(this, 'yDown');
var x1 = ds_map_find_value(this, 'x');
var y1 = ds_map_find_value(this, 'y');
    
if (parent) {
    
    worldX = x1 * ds_map_find_value(parent, 'm00') + y1 * ds_map_find_value(parent, 'm01') + ds_map_find_value(parent, 'worldX');
    worldY = x1 * ds_map_find_value(parent, 'm10') + y1 * ds_map_find_value(parent, 'm11') + ds_map_find_value(parent, 'worldY');
    worldScaleX = ds_map_find_value(parent, 'worldScaleX') * ds_map_find_value(this, 'scaleX');
    worldScaleY = ds_map_find_value(parent, 'worldScaleY') * ds_map_find_value(this, 'scaleY');
    worldRotation = ds_map_find_value(parent, 'worldRotation') + ds_map_find_value(this, 'rotation');

} else {
    
    if (flipX) {worldX = -1 * x1; worldY = -1 * y1;} 
    else       {worldX =  x1; worldY =  y1;}

    worldScaleX = ds_map_find_value(this, 'scaleX');
    worldScaleY = ds_map_find_value(this, 'scaleY');
    worldRotation = ds_map_find_value(this, 'rotation');
}

ds_map_replace(this, 'worldX', worldX);
ds_map_replace(this, 'worldY', worldY);
ds_map_replace(this, 'worldScaleX', worldScaleX);
ds_map_replace(this, 'worldScaleY', worldScaleY);
ds_map_replace(this, 'worldRotation', worldRotation);

radians = degtorad(worldRotation);
cosine = cos(radians);
sine = sin(radians);

var m00 = cosine * worldScaleX; 
var m10 = sine * worldScaleX;
var m01 = -sine * worldScaleY;
var m11 = cosine * worldScaleY;


if (flipX) {
  m00 = -1 * m00;
  m01 = -1 * m01;
}

if (flipY) {
  m10 = -1 * m10;
  m11 = -1 * m11;
}

if (yDown) {
  m10 = -1 * m10;
  m11 = -1 * m11;
}

ds_map_replace(this, 'm00', m00);
ds_map_replace(this, 'm10', m10);
ds_map_replace(this, 'm01', m01);
ds_map_replace(this, 'm11', m11);
