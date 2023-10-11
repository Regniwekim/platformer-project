/// @description Insert description here
// You can write your code in this editor

#region time control
global.time_dilation_current = approach(global.time_dilation_current,global.time_dilation_target,0.1);
#endregion

#region camera control

if (!instance_exists(global.camera_follow) && instance_exists(obj_player)) {
	global.camera_follow = obj_player;		
}

global.screen_shake = approach(global.screen_shake,0,max(0.05,global.screen_shake/10));

#endregion