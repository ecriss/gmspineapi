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
var frameIndex = argument[1];
var percent = argument[2];

var dfy,ddfx,ddfy,dddfx,dddfy;
var x1, y1, i;

var curveIndex = frameIndex * 6;

var curves = ds_map_find_value(_self, 'curves');
var dfx = ds_list_find_value(curves, curveIndex);

if (dfx == SPINEAPI_CURVE_LINEAR) return percent;
if (dfx == SPINEAPI_CURVE_STEPPED) return 0;

dfy   = ds_list_find_value(curves,curveIndex + 1);
ddfx  = ds_list_find_value(curves,curveIndex + 2);
ddfy  = ds_list_find_value(curves,curveIndex + 3);
dddfx = ds_list_find_value(curves,curveIndex + 4);
dddfy = ds_list_find_value(curves,curveIndex + 5);

x1 = dfx; y1 = dfy;
i = SPINEAPI_CURVE_SEGMENTS - 2;

while (1) {

    if (x1 >= percent) {
       var lastX = x1 - dfx;
       var lastY = y1 - dfy;
       return lastY + (y1 - lastY) * (percent - lastX) / (x1 - lastX);
    }

    if (i == 0) break;
    
    i--;
    dfx += ddfx;
    dfy += ddfy;
    ddfx += dddfx;
    ddfy += dddfy;
    x1 += dfx;
    y1 += dfy;
    
}

return y1 + (1 - y1) * (percent - x1) / (1 - x1);
