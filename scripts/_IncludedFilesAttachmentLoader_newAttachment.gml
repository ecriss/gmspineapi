var _self = argument[0];
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

if (sprite == -1) {
  show_debug_message("**** COULD NOT LOAD attachment: " + name);
}

return attachment;
