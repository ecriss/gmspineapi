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
var from = argument[1];
var to = argument[2];
var duration = argument[3];

var toEntry;
var fromEntry = ds_map_find_value(_self, 'entries');

while(fromEntry) {
  if (ds_map_find_value(fromEntry, 'animation') == from) {
  
     //Find existing ToEntry
     toEntry = ds_map_find_value(fromEntry, 'toEntries');
     while (toEntry) {

        if (ds_map_find_value(toEntry, 'animation') == to) {
            ds_map_replace(toEntry, 'duration', duration);
            exit;
        }

        toEntry = ds_map_find_value(toEntry, 'next');

     }
     break;
  }
  fromEntry = ds_map_find_value(fromEntry, 'next');
}

if (!fromEntry) {
  fromEntry = _FromEntry_create(from);
  ds_map_add(fromEntry, 'next', ds_map_find_value(_self, 'entries'));
  ds_map_replace(_self, 'entries', fromEntry);
}

toEntry = _ToEntry_create(to, duration);
ds_map_add(toEntry, 'next', ds_map_find_value(fromEntry, 'toEntries'));
ds_map_replace(fromEntry, 'toEntries', toEntry);

