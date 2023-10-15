/// @description Insert description here
// You can write your code in this editor
if (instance_nearest(obj_player.x,obj_player.y,obj_grapple_point) = id && point_distance(x,y,obj_player.x,obj_player.y) < obj_player.dash_distance_max) {
	image_index = 1;
} else {
	image_index = 0;	
}

if (active == 1) {
	arrow_direction = point_direction(obj_player.x,obj_player.y,x,y);
}