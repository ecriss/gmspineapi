var _self = argument[0];
var frameIndex = argument[1];
var percent = argument[2];

var dfy,ddfx,ddfy,dddfx,dddfy;
var x1, y1, i;

var curveIndex = frameIndex * 6;

var curves = ds_map_find_value(_self, 'curves');
var dfx = ds_list_find_value(curves, curveIndex);

if (dfx == ds_map_find_value(_self, 'CURVE_LINEAR')) return percent;
if (dfx == ds_map_find_value(_self, 'CURVE_STEPPED')) return 0;

	dfy   = ds_list_find_value(curves,curveIndex + 1);
	ddfx  = ds_list_find_value(curves,curveIndex + 2);
	ddfy  = ds_list_find_value(curves,curveIndex + 3);
	dddfx = ds_list_find_value(curves,curveIndex + 4);
	dddfy = ds_list_find_value(curves,curveIndex + 5);

x1 = dfx, y1 = dfy;
	i =ds_map_find_value(_self, 'CURVE_SEGMENTS') - 2;

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
