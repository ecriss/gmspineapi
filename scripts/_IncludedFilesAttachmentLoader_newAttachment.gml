var this = argument[0];
var skin = argument[1];
var type = argument[2];
var name = argument[3];

var sprite = -1;

if(type == SPINEAPI_ATTACHMENT_REGION) {
  var imageFile = name + '.png';
  if (file_exists(imageFile)) {
  
    if (!ds_map_exists(skin, imageFile)) {
      sprite = sprite_add(imageFile, 1, 0, 0, 0, 0);
      ds_map_add(skin, imageFile, sprite);
    } else {
      sprite = ds_map_find_value(skin, imageFile);
    }
    
  } else {

  }
  
} else {

} 

attachment = RegionAttachment_create(name);
ds_map_add(attachment, 'rendererObject', sprite);

if (sprite > -1) {
    ds_map_add(attachment, 'regionOffsetX', sprite_get_xoffset(sprite));
    ds_map_add(attachment, 'regionOffsetY', sprite_get_yoffset(sprite));
    ds_map_add(attachment, 'regionWidth', sprite_get_width(sprite));
    ds_map_add(attachment, 'regionHeight', sprite_get_height(sprite));
    ds_map_add(attachment, 'regionOriginalWidth', sprite_get_width(sprite));
    ds_map_add(attachment, 'regionOriginalHeight', sprite_get_height(sprite));
    //var uvs = sprite_get_uvs(sprite, 0);
    //RegionAttachment_setUVs(attachment, uvs[0], uvs[1], uvs[2], uvs[3], 0);
} else {
  show_debug_message("**** COULD NOT LOAD attachment: " + name);
}

return attachment;
