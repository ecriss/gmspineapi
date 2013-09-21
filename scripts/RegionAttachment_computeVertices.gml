var _self = argument[0];
var x1 = argument[1];
var y1 = argument[2];
var bone = argument[3];
var vertices = argument[4];

/*UV indices*/
var VERTEX_X1 = 0, 
VERTEX_Y1 = 1, 
VERTEX_X2 = 2, 
VERTEX_Y2 = 3, 
VERTEX_X3 = 4, 
VERTEX_Y3 = 5, 
VERTEX_X4 = 6, 
VERTEX_Y4 = 7;

var offset = ds_map_find_value(_self, 'offset');
x1 += ds_map_find_value(bone, 'worldX');
y1 += ds_map_find_value(bone, 'worldY');

var m00 = ds_map_find_value(bone, 'm00');
var m10 = ds_map_find_value(bone, 'm10');
var m11 = ds_map_find_value(bone, 'm11');
var m01 = ds_map_find_value(bone, 'm01');

var ox1 = ds_list_find_value(offset, VERTEX_X1);
var oy1 = ds_list_find_value(offset, VERTEX_Y1);
var ox2 = ds_list_find_value(offset, VERTEX_X2);
var oy2 = ds_list_find_value(offset, VERTEX_Y2);
var ox3 = ds_list_find_value(offset, VERTEX_X3);
var oy3 = ds_list_find_value(offset, VERTEX_Y3);
var ox4 = ds_list_find_value(offset, VERTEX_X4);
var oy4 = ds_list_find_value(offset, VERTEX_Y4);

var vx1 = ox1 * m00 + oy1 * m01 + x1;
var vy1 = ox1 * m10 + oy1 * m11 + y1;
var vx2 = ox2 * m00 + oy2 * m01 + x1;
var vy2 = ox2 * m10 + oy2 * m11 + y1;
var vx3 = ox3 * m00 + oy3 * m01 + x1;
var vy3 = ox3 * m10 + oy3 * m11 + y1;
var vx4 = ox4 * m00 + oy4 * m01 + x1;
var vy4 = ox4 * m10 + oy4 * m11 + y1;

ds_list_insert(vertices, VERTEX_X1, vx1);
ds_list_insert(vertices, VERTEX_Y1, vy1);
ds_list_insert(vertices, VERTEX_X2, vx2);
ds_list_insert(vertices, VERTEX_Y2, vy2);
ds_list_insert(vertices, VERTEX_X3, vx3);
ds_list_insert(vertices, VERTEX_Y3, vy3);
ds_list_insert(vertices, VERTEX_X4, vx4);
ds_list_insert(vertices, VERTEX_Y4, vy4);


