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
 
//Skeleton_create(SkeletonData data)
//Create new Skeleton from data
//returns DS Map (Skeleton)

var data = argument[0];
var i, ii;

var this = ds_map_create();
var boneCount = ds_map_find_value(data, 'boneCount');
ds_map_add(this, 'data', data);
ds_map_add(this, 'boneCount', boneCount);

var bones = ds_list_create();
var dataBones = ds_map_find_value(data, 'bones');
for (i=0; i < boneCount; ++i) {
  var boneData = ds_list_find_value(dataBones, i);
  var boneDataParent = ds_map_find_value(boneData, 'parent');
  var parent = 0;
  
  if (boneDataParent) {
      
    for (ii = 0; ii < boneCount; ++ii) {
        if (ds_list_find_value(dataBones, ii) == boneDataParent) {
            parent = ds_list_find_value(bones, ii);
            break;
        }
    }
    
  }
  ds_list_add(bones, Bone_create(boneData, parent));
}

var slotCount = ds_map_find_value(data, 'slotCount');
ds_map_add(this, 'bones', bones);
ds_map_add(this, 'root', ds_list_find_value(bones, 0));
ds_map_add(this, 'slotCount', slotCount);

var slots = ds_list_create();
var dataSlots = ds_map_find_value(data, 'slots');

for (i = 0; i < slotCount; ++i) {
    var slotData = ds_list_find_value(dataSlots, i);
    var bone = 0;
    
    for (ii = 0; ii < boneCount; ++ii) {
    
        if (ds_list_find_value(dataBones, ii) == ds_map_find_value(slotData, 'boneData')) {
            bone = ds_list_find_value(bones, ii);
            break;
        }
  
    }
    ds_list_add(slots, Slot_create(slotData, this, bone));
}

var drawOrder =  ds_list_create();
ds_list_copy(drawOrder, slots);

var r = 255, g = 255, b = 255;
ds_map_add(this, 'slots', slots);
ds_map_add(this, 'drawOrder', drawOrder);
ds_map_add(this, 'r', r);
ds_map_add(this, 'g', g);
ds_map_add(this, 'b', g);
ds_map_add(this, 'a', 1);
ds_map_add(this, 'rgb', make_color_rgb(r,g,b));

return this;
