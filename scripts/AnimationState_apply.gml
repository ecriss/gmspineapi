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
var skeleton = argument[1];

var alpha;
var animation = ds_map_find_value(_self, 'animation');

if !animation exit;

var previous = ds_map_find_value(_self, 'previous');

if (previous) {
  var previousTime = ds_map_find_value(_self, 'previousTime');
  var previousLoop = ds_map_find_value(_self, 'previousLoop');
  
  Animation_apply(previous, skeleton, previousTime, previousLoop);
  alpha = ds_map_find_value(_self, 'mixTime') / ds_map_find_value(_self, 'mixDuration');
  
  if (alpha >= 1) {
    alpha = 1;
    ds_map_replace(_self, 'previous', 0);
  }

  Animation_mix(animation, skeleton, ds_map_find_value(_self, 'time'), ds_map_find_value(_self, 'loop'), alpha);
  
} else {

  Animation_apply(animation, skeleton, ds_map_find_value(_self, 'time'), ds_map_find_value(_self, 'loop'));
  
}
