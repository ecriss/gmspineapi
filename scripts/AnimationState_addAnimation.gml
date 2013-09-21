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
var animation = argument[1];
var loop = argument[2];
var delay = argument[3];

var existingEntry;
var previousAnimation;
var entry = ds_map_create();

ds_map_add(entry, 'animation', animation);
ds_map_add(entry, 'loop', loop);

existingEntry = ds_map_find_value(_self, 'queue');

if (existingEntry) {

  while (ds_map_find_value(existingEntry, 'next')) {
    existingEntry = ds_map_find_value(existingEntry, 'next');
  }
  
  ds_map_replace(existingEntry, 'next', entry);
  previousAnimation = ds_map_find_value(existingEntry, 'animation');
    
} else {

  ds_map_replace(_self, 'queue', entry);
  previousAnimation = ds_map_find_value(_self, 'animation');
  
}

if (delay <= 0) {

  if (previousAnimation) {
    delay = ds_map_find_value(previousAnimation, 'duration') - AnimationStateData_getMix(ds_map_find_value(_self, 'data'), previousAnimation, animation) + delay;
  } else {
    delay = 0;
  }
  
}

ds_map_replace(entry, 'delay', delay);
