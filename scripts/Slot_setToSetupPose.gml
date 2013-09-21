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
 
var _self = argument[0];

var data = ds_map_find_value(_self, 'data');
var skeleton  = ds_map_find_value(_self, 'skeleton');
var skelData = ds_map_find_value(skeleton, 'data');
var attachment = 0;

ds_map_replace(_self, 'r', ds_map_find_value(data, 'r'));
ds_map_replace(_self, 'g', ds_map_find_value(data, 'g'));
ds_map_replace(_self, 'b', ds_map_find_value(data, 'b'));
ds_map_replace(_self, 'a', ds_map_find_value(data, 'a'));

var attachmentName = ds_map_find_value(data, 'attachmentName');

if (!is_string(attachmentName)) attachmentName = '';

if (attachmentName != '') {
  var i;
  var slotCount = ds_map_find_value(skelData, 'slotCount');
  var slots = ds_map_find_value(skelData, 'slots');
  
  for (i = 0; i < slotCount; ++i) {
    if (data == ds_list_find_value(slots, i)) {
      attachment = Skeleton_getAttachmentForSlotIndex(skeleton, i, attachmentName);
      break;
    }
  }
}

Slot_setAttachment(_self, attachment);
