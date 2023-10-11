/// @description Insert description here
// You can write your code in this editor

#region camera stuff

camera_set_view_size(view,global.view_width,global.view_height);

if (global.camera_follow = obj_player) {
	
	camera_current_x = camera_get_view_x(view);
	camera_current_y = camera_get_view_y(view);
	
	var _camera_zone_x = collision_line(camera_current_x,obj_player.y-2,camera_current_x+global.view_width,obj_player.y-2,obj_camera_zone,false,false);
	if (instance_exists(_camera_zone_x)) {
		camera_target_x = clamp(
		obj_player.x - (global.view_width/2) + (obj_player.x_vel_current*3) + (obj_player.facing*32),
		obj_player.x >  _camera_zone_x.bbox_right ?  max(0,_camera_zone_x.bbox_right - TILE_SIZE) : -TILE_SIZE,
		obj_player.x < _camera_zone_x.bbox_left ? min(room_width,_camera_zone_x.bbox_left+TILE_SIZE)-global.view_width : room_width-global.view_width);
	} else {
		camera_target_x = clamp(obj_player.x - (global.view_width/2) + (obj_player.x_vel_current*3) + (obj_player.facing*32), 0, room_width-global.view_width);
	}
	
	var _camera_zone_y = collision_line(obj_player.x,camera_current_y,obj_player.x,camera_current_y+global.view_height,obj_camera_zone,false,false);
	if (instance_exists(_camera_zone_y)) {
		camera_target_y = clamp(
		obj_player.y - (global.view_height/2),
		obj_player.y > _camera_zone_y.bbox_bottom ? max(0,_camera_zone_y.bbox_bottom - TILE_SIZE) : -TILE_SIZE,
		obj_player.y-2 < _camera_zone_y.bbox_top ? min(room_height,_camera_zone_y.bbox_top + TILE_SIZE)-global.view_height : room_height-global.view_height + TILE_SIZE);		
	} else {
		camera_target_y = clamp(obj_player.y - (global.view_height/2), -TILE_SIZE, room_height-global.view_height + TILE_SIZE);
	}
	
} else {
	camera_target_x = clamp(global.camera_follow.x - (global.view_width/2), 0, room_width-global.view_width);
	camera_current_x = camera_get_view_x(view);
	camera_target_y = clamp(global.camera_follow.y - (global.view_height/2), 0, room_height-global.view_height);
	camera_current_y = camera_get_view_y(view);
}


camera_current_x = lerp(camera_current_x,camera_target_x,camera_speed);
camera_current_y = lerp(camera_current_y,camera_target_y,camera_speed);	

camera_set_view_pos(view,camera_current_x+random_range(-global.screen_shake,global.screen_shake),camera_current_y+random_range(-global.screen_shake,global.screen_shake));

#endregion