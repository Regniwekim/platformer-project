/// @description Insert description here
// You can write your code in this editor

#region time control
global.time_dilation_current = lerp(global.time_dilation_current,global.time_dilation_target,0.1);//approach(global.time_dilation_current,global.time_dilation_target,max(0.05,abs(global.time_dilation_current-global.time_dilation_target)/5));
#endregion

#region camera control

if (instance_exists(obj_player) 
&& global.camera_follow != obj_player 
&& rectangle_in_rectangle(obj_player.bbox_left,obj_player.bbox_top,obj_player.bbox_right,obj_player.bbox_bottom,
global.camera_follow.bbox_left-2,global.camera_follow.bbox_top-2,global.camera_follow.bbox_right+2,global.camera_follow.bbox_bottom+2) != 1) {
	global.camera_follow = obj_player;		
}

global.screen_shake = approach(global.screen_shake,0,max(0.05,global.screen_shake/10));

#endregion