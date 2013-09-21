var _self = argument[0];
var stateIndex = argument[1];

var state = ds_list_find_value(ds_map_find_value(_self, 'states'), stateIndex);
AnimationState_clearAnimation(state);
