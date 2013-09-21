/*
* Based on code by kabecao
* See: http://gmc.yoyogames.com/index.php?showtopic=574464
*/

var _self = argument[0];
var x1 = argument[1];
var y1 = argument[2];

var data = ds_map_find_value(_self, 'data');
var bones = ds_map_find_value(_self, 'bones');
var slots = ds_map_find_value(_self, 'slots');
var skin = ds_map_find_value(_self, 'skin');
var boneCount = ds_map_find_value(_self, 'boneCount');
var flipX = ds_map_find_value(_self, 'flipX');
var flipY = ds_map_find_value(_self, 'flipY');


if flipX = 0 flipX = 1;
else flipX = -1;
if flipY = 0 flipY = 1;
else flipY = -1;

if (!skin) {
    skin = ds_map_find_value(data, 'defaultSkin');
}

var worldX, worldY, worldScaleX, worldScaleY, worldRotation, x1, y1, scaleX, scaleY, rotation, sprite, width, height;

for (i = 0; i < boneCount; ++i) {
  var slot = ds_list_find_value(slots, i);
  var slotData = ds_map_find_value(slot, 'data');
  var slotName = ds_map_find_value(slotData, 'name');
  
  var bone = ds_map_find_value(slot, 'bone');
  var attachment = ds_map_find_value(slot, 'attachment');
  
  if (attachment) {
        
        worldX = ds_map_find_value(bone,'worldX');
        worldY = ds_map_find_value(bone,'worldY');
        worldScaleX = ds_map_find_value(bone,'worldScaleX');
        worldScaleY = ds_map_find_value(bone,'worldScaleY');
        worldRotation = ds_map_find_value(bone,'worldRotation');
        
        
        scaleX = ds_map_find_value(attachment,'scaleX');
        scaleY = ds_map_find_value(attachment,'scaleY');
        x2 = ds_map_find_value(attachment,'x');
        y2 = ds_map_find_value(attachment,'y');
        rotation = ds_map_find_value(attachment,'rotation');
        sprite = ds_map_find_value(attachment,'rendererObject');
        width = ds_map_find_value(attachment,'width');
        height = ds_map_find_value(attachment,'height');
        
        if (sprite > -1) {

          var xPos = lengthdir_x(x2, rotation) - lengthdir_y(y2, rotation);
          var yPos = lengthdir_y(x2, rotation) + lengthdir_x(y2, rotation);
          
          sprite_set_offset(sprite, (width / 2) - xPos, (height / 2) + yPos);
          var color = c_white;//make_color_rgb(ds_map_find_value(slotData, 'r'), ds_map_find_value(slotData, 'g'), ds_map_find_value(slotData, 'b'));
          
          d3d_transform_add_rotation_z(rotation * flipX * flipY);
          d3d_transform_add_scaling((worldScaleX * scaleX), (worldScaleY * scaleY), 1);
          d3d_transform_add_rotation_z(worldRotation * flipX * flipY);
          d3d_transform_add_translation(x1 + worldX, y1 - worldY, 0);
          draw_sprite_ext(sprite, 0, 0, 0, flipX, flipY, 0, color, ds_map_find_value(slotData, 'a') );
          d3d_transform_set_identity();
        }
  }
}
