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

var bone, frameIndex, lastFrameValue, frameTime, percent, amount;
var this = timeline;
var frames = ds_map_find_value(this, 'frames');

if time < frames[0] exit;

var bones = ds_map_find_value(skeleton, 'bones');
var framesLength = ds_map_find_value(this, 'framesLength');

bone = ds_list_find_value(bones, ds_map_find_value(this, 'boneIndex'));
var boneData = ds_map_find_value(bone, 'data');
var boneDataRotation = ds_map_find_value(boneData, 'rotation');
var boneRotation = ds_map_find_value(bone, 'rotation');
  
if (time >= frames[framesLength - 2]) { 

  var amount = boneDataRotation + frames[framesLength - 1] - boneRotation;
  
  while (amount > 180) {
      amount -= 360;
  }    
      
  while (amount < -180) {
      amount += 360;
  }
      
  boneRotation += amount * alpha;
  ds_map_replace(bone, 'rotation', boneRotation);
  exit;
  
}

frameIndex = spineapi_binarySearch(frames, framesLength, time, 2);
lastFrameValue = frames[frameIndex - 1];
frameTime = frames[frameIndex];
percent = 1 - ((time - frameTime) / (frames[frameIndex + SPINEAPI_ROTATE_LAST_FRAME_TIME]  - frameTime));
percent =  CurveTimeline_getCurvePercent(this, frameIndex / 2 - 1, clamp(percent, 0, 1));

amount = frames[frameIndex + SPINEAPI_ROTATE_FRAME_VALUE] - lastFrameValue;

while (amount > 180) {
  amount -= 360;
}

while (amount < -180) {
  amount += 360;
}

amount = boneDataRotation + (lastFrameValue + amount * percent) - boneRotation;

while (amount > 180) {
  amount -= 360;
}

while (amount < -180) {
  amount += 360;
}

boneRotation += amount * alpha;
ds_map_replace(bone, 'rotation', boneRotation);
