var _self = argument[0];
var u = argument[1];
var v = argument[2];
var u2 = argument[3];
var v2 = argument[4];
var rotate = argument[5];

/*UV indices*/
var VERTEX_X1 = 0, 
VERTEX_Y1 = 1, 
VERTEX_X2 = 2, 
VERTEX_Y2 = 3, 
VERTEX_X3 = 4, 
VERTEX_Y3 = 5, 
VERTEX_X4 = 6, 
VERTEX_Y4 = 7;

var uvs = ds_map_find_value(_self, 'uvs');
if (rotate) {
  ds_list_insert(uvs, VERTEX_X2, u);
  ds_list_insert(uvs, VERTEX_Y2, v2);
  ds_list_insert(uvs, VERTEX_X3, u);
  ds_list_insert(uvs, VERTEX_Y3, v);
  ds_list_insert(uvs, VERTEX_X4, u2);
  ds_list_insert(uvs, VERTEX_Y4, v);
  ds_list_insert(uvs, VERTEX_X1, u2);
  ds_list_insert(uvs, VERTEX_Y1, v2);
} else {
  ds_list_insert(uvs, VERTEX_X1, u);
  ds_list_insert(uvs, VERTEX_Y1, v2);
  ds_list_insert(uvs, VERTEX_X2, u);
  ds_list_insert(uvs, VERTEX_Y2, v);
  ds_list_insert(uvs, VERTEX_X3, u2);
  ds_list_insert(uvs, VERTEX_Y3, v);
  ds_list_insert(uvs, VERTEX_X4, u2);
  ds_list_insert(uvs, VERTEX_Y4, v2);
}
