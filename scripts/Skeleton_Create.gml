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
 
//Skeleton_create(SkeletonData data)
//Create new Skeleton from data
//returns DS Map (Skeleton)

var data = argument[0];
var i, ii;

var _self = ds_map_create();
var boneCount = ds_map_find_value(data, 'boneCount');
ds_map_add(_self, 'data', data);
ds_map_add(_self, 'boneCount', boneCount);

var bones = ds_list_create();
var dataBones = ds_map_find_value(data, 'bones');
for (i=0; i < boneCount; ++i) {
  var boneData = ds_list_find_value(dataBones, i);
  var boneParent = ds_map_find_value(boneData, 'parent');
  var parent = 0;
  
  if (boneParent) {
      
    for (ii = 0; ii < boneCount; ++ii) {
        if (ds_list_find_value(dataBones, ii) == boneParent) {
            parent = ds_list_find_value(bones, ii);
            break;;
        }
    }
    
  }
  ds_list_add(bones, Bone_create(boneData, parent));
}

var slotCount = ds_map_find_value(data, 'slotCount');
ds_map_add(_self, 'bones', bones);
ds_map_add(_self, 'root', ds_list_find_value(bones, 0));
ds_map_add(_self, 'slotCount', slotCount);

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
    ds_list_add(slots, Slot_create(slotData, _self, bone));
}

var drawOrder =  ds_list_create();
ds_list_copy(drawOrder, slots);

ds_map_add(_self, 'slots', slots);
ds_map_add(_self, 'drawOrder', drawOrder);
ds_map_add(_self, 'r', 1);
ds_map_add(_self, 'g', 1);
ds_map_add(_self, 'b', 1);
ds_map_add(_self, 'a', 1);

return _self;
