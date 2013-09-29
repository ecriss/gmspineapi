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

var i;

var bones = ds_map_find_value(this, 'bones');
var slots = ds_map_find_value(this, 'slots');
var skins = ds_map_find_value(this, 'skins');
var animations = ds_map_find_value(this, 'animations');

var boneCount = ds_map_find_value(this, 'boneCount');
var slotCount = ds_map_find_value(this, 'slotCount');
var skinCount = ds_map_find_value(this, 'skinCount');
var animationCount = ds_map_find_value(this, 'animationCount');

for (i = 0; i < boneCount; ++i) {
  BoneData_dispose(ds_list_find_value(bones, i));
}
ds_list_destroy(bones);

for (i = 0; i < slotCount; ++i) {
  SlotData_dispose(ds_list_find_value(slots, i));
}
ds_list_destroy(slots);

for (i = 0; i < skinCount; ++i) {
  Skin_dispose(ds_list_find_value(skins, i));
}
ds_list_destroy(skins);

for (i = 0; i < animationCount; ++i) {
  Animation_dispose(ds_list_find_value(animations, i));
}
ds_list_destroy(animations);
