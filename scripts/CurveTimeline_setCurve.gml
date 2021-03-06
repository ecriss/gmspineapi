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
var cx1 = argument[2];
var cy1 = argument[3];
var cx2 = argument[4];
var cy2 = argument[5];

var subdiv_step = 1.0 / SPINEAPI_CURVE_SEGMENTS;
var subdiv_step2 = subdiv_step * subdiv_step;
var subdiv_step3 = subdiv_step2 * subdiv_step;
var pre1 = 3 * subdiv_step;
var pre2 = 3 * subdiv_step2;
var pre4 = 6 * subdiv_step2;
var pre5 = 6 * subdiv_step3;
var tmp1x = -cx1 * 2 + cx2;
var tmp1y = -cy1 * 2 + cy2;
var tmp2x = (cx1 - cx2) * 3 + 1;
var tmp2y = (cy1 - cy2) * 3 + 1;

var i = frameIndex * 6;
var curves = ds_map_find_value(this, 'curves');

curves[i] = cx1 * pre1 + tmp1x * pre2 + tmp2x * subdiv_step3;
curves[i + 1] = cy1 * pre1 + tmp1y * pre2 + tmp2y * subdiv_step3;
curves[i + 2] = tmp1x * pre4 + tmp2x * pre5;
curves[i + 3] = tmp1y * pre4 + tmp2y * pre5;
curves[i + 4] = tmp2x * pre5;
curves[i + 5] = tmp2y * pre5;

ds_map_replace(this, 'curves', curves);
