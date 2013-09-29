
var this = argument[0];
var stateIndex = argument[1];

var state = SkeletonAnimation_getAnimationState(this, stateIndex);
return AnimationState_isComplete(state);
