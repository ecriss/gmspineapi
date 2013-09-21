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
 
var timeline = argument[0];
var skeleton = argument[1];
var time = argument[2];
var alpha = argument[3];

var bone, frameIndex, lastFrameX, lastFrameY, frameTime, percent;

var _self = timeline;
var frames = ds_map_find_value(_self, 'frames');
var framesLength = ds_map_find_value(_self, 'framesLength');

if time < ds_list_find_value(frames, 0) exit;

var boneIndex = ds_map_find_value(_self, 'boneIndex');
var bones = ds_map_find_value(skeleton, 'bones');
var bone = ds_list_find_value(bones, boneIndex);
var boneData = ds_map_find_value(bone, 'data');
var boneX = ds_map_find_value(bone, 'x');
var boneY = ds_map_find_value(bone, 'y');
var boneDataX = ds_map_find_value(boneData, 'x');
var boneDataY = ds_map_find_value(boneData, 'y');
  
if (time >= ds_list_find_value(frames, framesLength - 3)) {
  boneX += (boneDataX + ds_list_find_value(frames, framesLength - 2) - boneX) * alpha;
  boneY += (boneDataY + ds_list_find_value(frames, framesLength - 1) - boneY) * alpha;
  
  ds_map_replace(bone, 'x', boneX);
  ds_map_replace(bone, 'y', boneY);
  exit;
}

frameIndex = spineapi_listBinarySearch(frames, framesLength, time, 3);
lastFrameX = ds_list_find_value(frames, frameIndex - 2);
lastFrameY = ds_list_find_value(frames, frameIndex - 1);
frameTime = ds_list_find_value(frames, frameIndex);

percent = 1 - (time - frameTime) / (ds_list_find_value(frames, frameIndex + SPINEAPI_TRANSLATE_LAST_FRAME_TIME) - frameTime);

var curvePercent;
if (percent < 0) curvePercent = 0; else if (percent > 1) curvePercent = 1; else curvePercent = percent;

percent =  CurveTimeline_getCurvePercent(_self, frameIndex / 3 - 1, curvePercent);

boneX += (boneDataX + lastFrameX + (ds_list_find_value(frames, frameIndex + SPINEAPI_TRANSLATE_FRAME_X) - lastFrameX) * percent - boneX) * alpha;
boneY += (boneDataY + lastFrameY + (ds_list_find_value(frames, frameIndex + SPINEAPI_TRANSLATE_FRAME_Y) - lastFrameY) * percent - boneY) * alpha;
ds_map_replace(bone, 'x', boneX);
ds_map_replace(bone, 'y', boneY);

