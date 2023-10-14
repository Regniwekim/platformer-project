/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_player) && rectangle_in_rectangle(obj_player.bbox_left,obj_player.bbox_top,obj_player.bbox_right,obj_player.bbox_bottom,bbox_left-2,bbox_top-2,bbox_right+2,bbox_bottom+2) == 1) {
	global.camera_follow = id;
}