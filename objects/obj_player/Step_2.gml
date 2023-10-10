/// @description Insert description here
// You can write your code in this editor
with (global.camera) {
	camera_set_view_size(view,view_width,view_height);
	target_x = clamp(other.x - (view_width/2) + (other.x_vel_current*3) + (other.facing*32) ,0,room_width-view_width);	
	current_x = camera_get_view_x(view);
	target_y = clamp(other.y - (view_height/2),0,room_height-view_height);
	current_y = camera_get_view_y(view);
	camera_set_view_pos(view,lerp(current_x,target_x,camera_speed),lerp(current_y,target_y,camera_speed));
}