var _self = argument[0];
var stateIndex = argument[1];

var state = SkeletonAnimation_getAnimationState(_self, stateIndex);
return AnimationState_isComplete(state);
