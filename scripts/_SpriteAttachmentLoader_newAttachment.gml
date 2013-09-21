//
var _self = argument[0];
var skin = argument[1];
var type = argument[2];
var name = argument[3];

var sprite = -1;

if(type == SPINEAPI_ATTACHMENT_REGION ) {
    sprite = asset_get_index(name);
} else {
  //not supported
}

attachment = RegionAttachment_create(name);
ds_map_add(attachment, 'rendererObject', sprite);

return attachment;
