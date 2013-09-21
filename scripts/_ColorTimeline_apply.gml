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

var slot, frameIndex,  lastFrameR, lastFrameG, lastFrameB, lastFrameA, percent, frameTime, r, g, b, a;

var _self = timeline;
var frames = ds_map_find_value(_self, 'frames');
var framesLength = ds_map_find_value(_self, 'framesLength');

if time < ds_list_find_value(frames, 0) exit;

var slotIndex = ds_map_find_value(_self, 'slotIndex');
var slots = ds_map_find_value(skeleton, 'slots');
var slot = ds_list_find_value(slots, slotIndex);

if (time >= ds_list_find_value(frames, framesLength - 5)) {
    var i = framesLength - 1;
    ds_map_replace(slot, 'r', ds_list_find_value(frames, i - 3));
    ds_map_replace(slot, 'g', ds_list_find_value(frames, i - 2));
    ds_map_replace(slot, 'b', ds_list_find_value(frames, i - 1));
    ds_map_replace(slot, 'a', ds_list_find_value(frames, i));
    exit;
}

var slotR = ds_map_find_value(slot, 'r');
var slotG = ds_map_find_value(slot, 'g');
var slotB = ds_map_find_value(slot, 'b');
var slotA = ds_map_find_value(slot, 'a');

frameIndex = spineapi_listBinarySearch(frames, framesLength, time, 5);
lastFrameR = ds_list_find_value(frames, frameIndex - 4);
lastFrameG = ds_list_find_value(frames, frameIndex - 3);
lastFrameB = ds_list_find_value(frames, frameIndex - 2);
lastFrameA = ds_list_find_value(frames, frameIndex - 1);
frameTime = ds_list_find_value(frames, frameIndex);

percent = 1 - (time - frameTime) / (ds_list_find_value(frames, frameIndex + SPINEAPI_COLOR_LAST_FRAME_TIME) - frameTime);

var curvePercent;
if (percent < 0) curvePercent = 0; else if (percent > 1) curvePercent = 1; else curvePercent = percent;

percent =  CurveTimeline_getCurvePercent(_self, frameIndex / 5 - 1, curvePercent);

r = lastFrameR + (ds_list_find_value(frames, frameIndex + SPINEAPI_COLOR_FRAME_R) - lastFrameR) * percent;
g = lastFrameG + (ds_list_find_value(frames, frameIndex + SPINEAPI_COLOR_FRAME_G) - lastFrameG) * percent;
b = lastFrameB + (ds_list_find_value(frames, frameIndex + SPINEAPI_COLOR_FRAME_B) - lastFrameB) * percent;
a = lastFrameA + (ds_list_find_value(frames, frameIndex + SPINEAPI_COLOR_FRAME_A) - lastFrameA) * percent;

if (alpha < 1) {
    slotR += (r - slotR) * alpha;
    slotG += (g - slotG) * alpha;
    slotB += (b - slotB) * alpha;
    slotA += (a - slotA) * alpha;
} else {
    slotR = r;
    slotG = g;
    slotB = b;
    slotA = a;
}

ds_map_replace(slot, 'r', slotR);
ds_map_replace(slot, 'g', slotG);
ds_map_replace(slot, 'b', slotB);
ds_map_replace(slot, 'a', slotA);

