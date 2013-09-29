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
var animationMap = argument[1];
var skeletonData = argument[2];

var animation;

var scale = ds_map_find_value(this, 'scale');
var name = ds_map_find_value(animationMap, 'name');
var bones = ds_map_find_value(animationMap, 'bones');
var boneCount = 0;

if (bones) {
  boneCount = ds_map_size(bones);
}

var slots = ds_map_find_value(animationMap, 'slots');
var slotCount = 0;

if (slots) {
    slotCount = ds_map_size(slots);
}

var timelineCount = 0;
var i, ii, iii;

var boneName = ds_map_find_first(bones);
for (i = 0; i < boneCount; ++i) {
    var bone = ds_map_find_value(bones, boneName);
    timelineCount += ds_map_size(bone);
    boneName = ds_map_find_next(bones, boneName);
}

var slotName = ds_map_find_first(slots);
for (i = 0; i < slotCount; ++i) {
    var slot = ds_map_find_value(slots, slotName);
    timelineCount += ds_map_size(slot);
    slotName = ds_map_find_next(slots, slotName);
}

animation = Animation_create(name, timelineCount);

var animationDuration = 0;
var timelines = ds_map_find_value(animation, 'timelines');
var skeletonAnimations = ds_map_find_value(skeletonData, 'animations');
var animationCount = ds_map_find_value(skeletonData, 'animationCount');

ds_list_insert(skeletonAnimations, animationCount, animation);
ds_map_replace(skeletonData, 'animationCount', ++animationCount);

timelineCount = 0;
boneName = ds_map_find_first(bones);

for (i = 0; i < boneCount; ++i) {
    var boneMap = ds_map_find_value(bones, boneName);
    var boneIndex = SkeletonData_findBoneIndex(skeletonData, boneName);

    if (boneIndex == -1) {
        Animation_dispose(animation);
        _SkeletonJson_setError(this, animationMap, "Bone not found: ", boneName);
        return 0;
    }
    
    var timelineType = ds_map_find_first(boneMap);
    timelineCount = ds_map_size(boneMap)
    
    
    for (ii = 0; ii < timelineCount; ++ii) {
        var duration;
        var timelineList = ds_map_find_value(boneMap, timelineType);
        var frameCount = ds_list_size(timelineList);
        
        if (timelineType == 'rotate') {
            var timeline = RotateTimeline_create(frameCount);
            
            
            ds_map_replace(timeline, 'boneIndex', boneIndex);
            
            for (iii = 0; iii < frameCount; ++iii) {
            
                var frame = ds_list_find_value(timelineList, iii);
                var time = ds_map_find_value(frame, 'time');
                var angle = ds_map_find_value(frame, 'angle');
                
                RotateTimeline_setFrame(timeline, iii, time, angle);
                _SkeletonJson_readCurve(timeline, iii, frame);
            }
            
            ds_list_add(timelines, timeline);
            
            var frames = ds_map_find_value(timeline, 'frames');
                       
            duration = frames[frameCount * 2 - 2];
            
            if (duration > animationDuration) {
                animationDuration = duration;
            }
            
        } else {
            var isScale = timelineType == 'scale';
            var isTranslate = timelineType == 'translate';
            var timeline;
            
            if (isScale || isTranslate) {
              var _scale = scale;
              
              if (isScale) {
                _scale = 1;
                timeline = ScaleTimeline_create(frameCount);
              } else {
                timeline = TranslateTimeline_create(frameCount);
              }
              
              ds_map_replace(timeline, 'boneIndex', boneIndex);
              
              for (iii = 0; iii < frameCount; ++iii) {
            
                var frame = ds_list_find_value(timelineList, iii);
                var time = ds_map_find_value(frame, 'time');
                var x1 = ds_map_find_value(frame, 'x') * _scale;
                var y1 = ds_map_find_value(frame, 'y') * _scale;
                
                TranslateTimeline_setFrame(timeline, iii, time, x1, y1);
                _SkeletonJson_readCurve(timeline, iii, frame);
                ds_map_destroy(frame);
              }
              
              ds_list_add(timelines, timeline);
              
              var frames = ds_map_find_value(timeline, 'frames');
              //duration = ds_list_find_value(frames, frameCount * 3 - 3);
              duration = frames[frameCount * 3 - 3];
              if (duration > animationDuration) {
                animationDuration = duration;
              }

            }  else {
               Animation_dispose(animation);
               _SkeletonJson_setError(this, 0, "Invalid timeline type for a bone: ", timelineType);
               return 0;
            }
        
        }
        
        timelineType = ds_map_find_next(boneMap, timelineType);
        ds_list_destroy(timelineList);
    }
    
    boneName = ds_map_find_next(bones, boneName);
}

timelineCount = 0;
slotName = ds_map_find_first(slots);

for (i = 0; i < slotCount; ++i) {
    var slotMap = ds_map_find_value(slots, slotName);
    var slotIndex = SkeletonData_findSlotIndex(skeletonData, slotName);
    
    if (slotIndex == -1) {
      Animation_dispose(animation);
      _SkeletonJson_setError(this, animatioMap, "Slot not found: ", slotName);
      return 0;
    }
    
    timelineCount = ds_map_size(slotMap);
    var timelineType = ds_map_find_first(slotMap);
    
    for (ii = 0; ii < timelineCount; ++ii) {
      var duration;
      var timelineList = ds_map_find_value(slotMap, timelineType);
      var frameCount = ds_list_size(timelineList);
      
      if (timelineType == 'color') {
        var timeline = ColorTimeline_create(frameCount);
        ds_map_add(timeline, 'slotIndex', slotIndex);
        
        for (iii = 0; iii < frameCount; ++iii) {
             var frame = ds_list_find_value(timelineList, iii);
             var color = ds_map_find_value(frame, 'color');
             var time = ds_map_find_value(frame, 'time');
             
             var rgba = hex_to_dec(color);
             var r = ((rgba >> 24) & $ff), g = ((rgba >> 16) & $ff), b = ((rgba >> 8) & $ff), a = (rgba & $ff) / 255;
             
             ColorTimeline_setFrame(timeline, iii, time, r, g, b, a);
             _SkeletonJson_readCurve(timeline, iii, frame);
             ds_map_destroy(frame);
        }
        
        ds_list_add(timelines, timeline);
        duration = ds_list_find_value(frames, frameCount * 5 - 5);
    
        if (duration > animationDuration) {
            animationDuration = duration;
        }

      } else if (timelineType == 'attachment') {
        var timeline = AttachmentTimeline_create(frameCount);
        ds_map_add(timeline, 'slotIndex', slotIndex);
        
        for (iii = 0; iii < frameCount; ++iii) {
            var frame = ds_list_find_value(timelineList, iii);
            var name = ds_map_find_value(frame, 'name');
            var time = ds_map_find_value(frame, 'time');
            
            AttachmentTimeline_setFrame(timeline, iii, time, name);
            ds_map_destroy(frame);
        }
        
        ds_list_add(timelines, timeline);
        duration = ds_list_find_value(frames, frameCount - 1);
    
        if (duration > animationDuration) {
            animationDuration = duration;
        }
        
      } else {
      
        Animation_dispose(animation);
        _SkeletonJson_setError(this, 0, "Invalid timeline type for a slot: ", timelineType);
        return 0;
        
      }
      
      timelineType = ds_map_find_next(slotMap, timelineType);
      ds_map_destroy(timelineList);
      
    }
    
    slotName = ds_map_find_next(slots, slotName);
}

ds_map_replace(animation, 'timelineCount', ds_list_size(timelines));
ds_map_replace(animation, 'duration', animationDuration);

return animation;
