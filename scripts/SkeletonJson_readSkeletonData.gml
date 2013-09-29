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
var json = argument[1];

var skeletonData;
var i, ii, ii, boneCount;
var json_map = json_decode(json);
var slots, skinsMap, animations;
var scale = ds_map_find_value(this, 'scale');

if (scale == 0) {
  scale = 1;
}

ds_map_replace(this, 'scale', scale);
ds_map_add(this, 'error', '');

if (json_map == -1) {
    _SkeletonJson_setError(this, 0, "Invalid skeleton JSON: ", '');
    return 0;
}

skeletonData = SkeletonData_create();
var skelBones = ds_list_create();
ds_map_add(skeletonData, 'bones', skelBones);

bones = ds_map_find_value(json_map, 'bones');
boneCount = ds_list_size(bones);
ds_map_add(skeletonData, 'boneCount', boneCount);

for (i = 0; i < boneCount; ++i) {
  
  var boneMap = ds_list_find_value(bones,i);
  var boneName = ds_map_find_value(boneMap, 'name');
  var parent = 0;
  var parentName = ds_map_find_value(boneMap, 'parent');
  
  if (is_real(parentName)) {
     parentName = '';
  }
  
  if (parentName != '') {
    parent = SkeletonData_findBone(skeletonData, parentName);
    
    if (!parent) {
      
      SkeletonData_dispose(skeletonData);
      _SkeletonJson_setError(this, json_map, "Parent bone not found: ", parentName);
      return 0;
    }
  }
  
  var boneData = BoneData_create(boneName, parent);
  ds_map_add(boneData, 'length', ds_map_find_value(boneMap, 'length') * scale);
  ds_map_add(boneData, 'x', ds_map_find_value(boneMap, 'x') * scale);
  ds_map_add(boneData, 'y', ds_map_find_value(boneMap, 'y') * scale);
  ds_map_add(boneData, 'rotation', ds_map_find_value(boneMap, 'rotation'));
  
  if !ds_map_exists(boneMap,'scaleX') ds_map_add(boneMap,'scaleX',1);
  if !ds_map_exists(boneMap,'scaleY') ds_map_add(boneMap,'scaleY',1);
  
  ds_map_replace(boneData, 'scaleX', ds_map_find_value(boneMap, 'scaleX'));
  ds_map_replace(boneData, 'scaleY', ds_map_find_value(boneMap, 'scaleY'));
  ds_list_add(skelBones, boneData);

}

slots = ds_map_find_value(json_map, 'slots');

if (slots) {
  var slotCount = ds_list_size(slots);
  var skelSlots = ds_list_create();
  ds_map_add(skeletonData, 'slots', skelSlots);
  ds_map_add(skeletonData, 'slotCount', slotCount);
  
  for (i = 0; i < slotCount; ++i) {
    var slotData, color, attachmentItem;
    var slotMap = ds_list_find_value(slots, i);
    var slotName = ds_map_find_value(slotMap, 'name');
    var boneName = ds_map_find_value(slotMap, 'bone');
    var boneData = SkeletonData_findBone(skeletonData, boneName);
    
    if (!boneData) {
        SkeletonData_dispose(skeletonData);
        _SkeletonJson_setError(this, json_map, "Slot bone not found: ", boneName);
        return 0;
    }
    
    slotData = SlotData_create(slotName, boneData);
    color = ds_map_find_value(slotMap, 'color');
    
    if (color) {
    
      var rgba = hex_to_dec(color);
      var r = ((rgba >> 24) & $ff), g = ((rgba >> 16) & $ff), b = ((rgba >> 8) & $ff), a = (rgba & $ff) / 255;
      
      ds_map_replace(slotData, 'r', r);
      ds_map_replace(slotData, 'g', g);
      ds_map_replace(slotData, 'b', b);
      ds_map_replace(slotData, 'a', a);
      ds_map_replace(slotData, 'rgb', make_color_rgb(r, g, b));
    }
    
    attachmentItem = ds_map_find_value(slotMap, 'attachment');
    
    if (is_string(attachmentItem)) {
      SlotData_setAttachmentName(slotData, attachmentItem);
    }
    ds_list_add(skelSlots, slotData);
    
  }
  
}

skinsMap = ds_map_find_value(json_map, 'skins');
var attachmentLoader = ds_map_find_value(this, 'attachmentLoader');

if (skinsMap) {
    var skinCount = ds_map_size(skinsMap);
    var skinName = ds_map_find_first(skinsMap);
    var skelSkins = ds_list_create();
    
    ds_map_add(skeletonData, 'skins', skelSkins);
    ds_map_add(skeletonData, 'skinCount', skinCount);
     
    var defaultSkin = skinName;
    
    for (i = 0; i < skinCount; ++i) {
      var slotMap = ds_map_find_value(skinsMap, skinName);
      var skin = Skin_create(skinName);
      var slotNameCount = ds_map_size(slotMap);
      var slotName = ds_map_find_first(slotMap); 
      
      ds_list_add(skelSkins, skin);
      
      if (skinName == 'default') {
        defaultSkin = skinName;
        ds_map_add(skeletonData, 'defaultSkin', skin);
      }
      
      for (ii = 0; ii < slotNameCount; ++ii) {
        var attachmentsMap = ds_map_find_value(slotMap, slotName);
        var attachmentCount = ds_map_size(attachmentsMap);
        var slotIndex = SkeletonData_findSlotIndex(skeletonData, slotName);
        var skinAttachmentName = ds_map_find_first(attachmentsMap);
        
        for (iii = 0; iii < attachmentCount; ++iii) {
            var attachment;
            var attachmentMap = ds_map_find_value(attachmentsMap, skinAttachmentName);
            var attachmentName = ds_map_find_value(attachmentMap, 'name');
            var attachmentType = ds_map_find_value(attachmentMap, 'type');
            
            if (is_real(attachmentName)) attachmentName = skinAttachmentName;
            if (is_real(attachmentType)) attachmentType = 'region';

            var attachType;
            
            if (attachmentType == 'region') {
                attachType = SPINEAPI_ATTACHMENT_REGION;
            } else if (attachmentType == 'regionSequence') {
                attachType = SPINEAPI_ATTACHMENT_REGION_SEQUENCE;
            } else {
                SkeletonData_dispose(skeletonData);
                _SkeletonJson_setError(this, json_map, "Unknown attachment type: ", attachmentType);
                return 0;
            }
            
            attachment = AttachmentLoader_newAttachment(attachmentLoader, skin, attachType, attachmentName);
            
            if (!attachment) {
                if (ds_map_find_value(attachmentLoader, 'error1')) {
                   SkeletonData_dispose(skeletonData);
                   _SkeletonJson_setError(this, json_map, ds_map_find_value(attachmentLoader, 'error1'), ds_map_find_value(attachmentLoader, 'error2'));
                   return 0;
                }
                continue;
            }
            
            if (attachType == SPINEAPI_ATTACHMENT_REGION || attachType == SPINEAPI_ATTACHMENT_REGION_SEQUENCE) {
                var regionAttachment = attachment;
                
                if !ds_map_exists(attachmentMap,'scaleX') ds_map_add(attachmentMap,'scaleX',1);
                if !ds_map_exists(attachmentMap,'scaleY') ds_map_add(attachmentMap,'scaleY',1);
                if !ds_map_exists(attachmentMap,'width') ds_map_add(attachmentMap,'width',32);
                if !ds_map_exists(attachmentMap,'height') ds_map_add(attachmentMap,'height',32);
                
                ds_map_replace(regionAttachment, 'x', ds_map_find_value(attachmentMap, 'x') * scale);
                ds_map_replace(regionAttachment, 'y', ds_map_find_value(attachmentMap, 'y') * scale);
                ds_map_replace(regionAttachment, 'scaleX', ds_map_find_value(attachmentMap, 'scaleX'));
                ds_map_replace(regionAttachment, 'scaleY', ds_map_find_value(attachmentMap, 'scaleY'));
                ds_map_replace(regionAttachment, 'rotation', ds_map_find_value(attachmentMap, 'rotation'));
                ds_map_replace(regionAttachment, 'width', ds_map_find_value(attachmentMap, 'width') * scale);
                ds_map_replace(regionAttachment, 'height', ds_map_find_value(attachmentMap, 'height') * scale);
                
                RegionAttachment_updateOffset(regionAttachment);
            }
                
            Skin_addAttachment(skin, slotIndex, skinAttachmentName, attachment);
            skinAttachmentName = ds_map_find_next(attachmentsMap, skinAttachmentName);
            ds_map_destroy(attachmentMap);
        }
        
        slotName = ds_map_find_next(slotMap, slotName);
        ds_map_destroy(attachmentsMap);
      }
      skinName = ds_map_find_next(skinsMap, skinName);
      ds_map_destroy(slotMap);
    }

}

animations = ds_map_find_value(json_map, 'animations');

if (animations) {
    var animationCount = ds_map_size(animations);
    var animKey = ds_map_find_first(animations);
    
    ds_map_add(skeletonData, 'animations', ds_list_create());

    for (i = 0; i < animationCount; ++i) {
        var animationMap = ds_map_find_value(animations, animKey);
        
        if (!ds_map_exists(animationMap, 'name')) {
            ds_map_add(animationMap, 'name', animKey);
        }
        
        _SkeletonJson_readAnimation(this, animationMap, skeletonData);
        animKey = ds_map_find_next(animations, animKey);
        ds_map_destroy(animationMap);
    }

}

for (i = 0; i < boneCount; ++i) {
     var boneMap = ds_list_find_value(bones, i);
     ds_map_destroy(boneMap);
}

ds_list_destroy(bones);
ds_list_destroy(slots);
ds_map_destroy(animations);
ds_map_destroy(skinsMap);
ds_map_destroy(json_map);
return skeletonData;
