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
 
var timeline = argument[0];
var skeleton = argument[1];
var time = argument[2];
var alpha = argument[3];

var slot, frameIndex,  lastFrameR, lastFrameG, lastFrameB, lastFrameA, percent, frameTime, r, g, b, a;

var this = timeline;
var frames = ds_map_find_value(this, 'frames');
var framesLength = ds_map_find_value(this, 'framesLength');

if time < frames[0] exit;

var slotIndex = ds_map_find_value(this, 'slotIndex');
var slots = ds_map_find_value(skeleton, 'slots');
var slot = ds_list_find_value(slots, slotIndex);

if (time >= frames[framesLength - 5]) {

    var r = frames[i-3], g = frames[i-2], b=frames[i-1];
    ds_map_replace(slot, 'r', r);
    ds_map_replace(slot, 'g', g);
    ds_map_replace(slot, 'b', b);
    ds_map_replace(slot, 'a', frames[i]);
    ds_map_replace(slot, 'rgb', make_color_rgb(r,g,b));
    exit;
}

var slotR = ds_map_find_value(slot, 'r');
var slotG = ds_map_find_value(slot, 'g');
var slotB = ds_map_find_value(slot, 'b');
var slotA = ds_map_find_value(slot, 'a');

frameIndex = spineapi_binarySearch(frames, framesLength, time, 5);
lastFrameR = frames[frameIndex - 4];
lastFrameG = frames[frameIndex - 3];
lastFrameB = frames[frameIndex - 2];
lastFrameA = frames[frameIndex - 1];
frameTime =  frames[frameIndex];

percent = 1 - (time - frameTime) / (frames[frameIndex + SPINEAPI_COLOR_LAST_FRAME_TIME] - frameTime);
percent =  CurveTimeline_getCurvePercent(this, frameIndex / 5 - 1, clamp(percent, 0, 1));

r = lastFrameR + (frames[frameIndex + SPINEAPI_COLOR_FRAME_R] - lastFrameR) * percent;
g = lastFrameG + (frames[frameIndex + SPINEAPI_COLOR_FRAME_G] - lastFrameG) * percent;
b = lastFrameB + (frames[frameIndex + SPINEAPI_COLOR_FRAME_B] - lastFrameB) * percent;
a = lastFrameA + (frames[frameIndex + SPINEAPI_COLOR_FRAME_A] - lastFrameA) * percent;

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
ds_map_replace(slot, 'rgb', make_color_rgb(r, g, b));
