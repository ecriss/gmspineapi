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
var frameIndex = argument[1];
var percent = argument[2];

var dfy,ddfx,ddfy,dddfx,dddfy;
var x1, y1, i;

var curveIndex = frameIndex * 6;

var curves = ds_map_find_value(this, 'curves');
var dfx = curves[curveIndex];

if (dfx == SPINEAPI_CURVE_LINEAR) return percent;
if (dfx == SPINEAPI_CURVE_STEPPED) return 0;

dfy   = curves[curveIndex + 1];
ddfx  = curves[curveIndex + 2];
ddfy  = curves[curveIndex + 3];
dddfx = curves[curveIndex + 4];
dddfy = curves[curveIndex + 5];

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
