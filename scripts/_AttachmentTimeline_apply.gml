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

var frameIndex, attachmentName;
var _self = timeline;

var frames = ds_map_find_value(_self, 'frames');

if time < ds_list_find_value(frames, 0) exit;

var framesLength = ds_map_find_value(_self, 'framesLength');

if (time >= ds_list_find_value(frames, framesLength - 1)) {
  frameIndex = framesLength - 1;
} else {
  frameIndex = spineapi_listBinarySearch(frames, framesLength, time, 1) - 1;
}

var attachmentNames = ds_map_find_value(_self, 'attachmentNames');
var slots = ds_map_find_value(skeleton, 'slots');
var slotIndex = ds_map_find_value(_self, 'slotIndex');
var slot = ds_list_find_value(slots, slotIndex);

attachmentName = ds_list_find_value(attachmentNames, frameIndex);
var attachment = 0;

if (is_string(attachmentName)) {
   attachment = Skeleton_getAttachmentForSlotIndex(skeleton, slotIndex, attachmentName);
}

Slot_setAttachment(slot, attachment);
