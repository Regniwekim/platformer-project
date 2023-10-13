/// @description Insert description here
// You can write your code in this editor

#region camera stuff
if (!instance_exists(global.camera_follow) && instance_exists(obj_player)) {
	global.camera_follow = obj_player;		
}

var _cam_width = lerp(camera_width,global.view_width*global.camera_follow.zoom,0.1);
var _cam_height = lerp(camera_height,global.view_height*global.camera_follow.zoom,0.1);
camera_set_view_size(view, _cam_width, _cam_height);
camera_current_x = camera_get_view_x(view);
camera_current_y = camera_get_view_y(view);

if (global.camera_follow = obj_player) {
	
	
#region horizontal camera movement
var _camera_zone_x_list = ds_list_create();
if (collision_line(camera_current_x,obj_player.y-2,camera_current_x+global.view_width,obj_player.y-2,obj_camera_zone,false,false)) {

	var _num_x = collision_line_list(camera_current_x,obj_player.y-2,camera_current_x+global.view_width,obj_player.y-2,obj_camera_zone,false,false,_camera_zone_x_list,false);
	if (_num_x > 0) {
		var _camera_zone_left = noone;
		var _camera_zone_right = noone;
		for (var i=0;i<_num_x;i++) {
			if 	(_camera_zone_x_list[| i].left_block){
				if (instance_exists(_camera_zone_left)) {
					if (_camera_zone_x_list[| i].bbox_right < _camera_zone_left.bbox_right) {
						_camera_zone_left = _camera_zone_x_list[| i];
					}
				} else {
					_camera_zone_left = _camera_zone_x_list[| i];
				}
			}
			if 	(_camera_zone_x_list[| i].right_block){
				if (instance_exists(_camera_zone_right)) {
					if 	(_camera_zone_x_list[| i].bbox_left > _camera_zone_right.bbox_left){
						_camera_zone_right = _camera_zone_x_list[| i];
					}
				} else {
					_camera_zone_right = _camera_zone_x_list[| i];
				}
			}
		}
			
		if (instance_exists(_camera_zone_left) && obj_player.x > _camera_zone_left.bbox_right) {
			camera_target_x = clamp(
			obj_player.x - (global.view_width/2) + (obj_player.x_vel_current*3) + (obj_player.facing*TILE_SIZE),
			max(0,_camera_zone_left.bbox_right - TILE_SIZE),
			room_width - global.view_height);
				
		}else if (instance_exists(_camera_zone_right) && obj_player.x < _camera_zone_right.bbox_left) {
			camera_target_x = clamp(
			obj_player.x - (global.view_width/2) + (obj_player.x_vel_current*3) + (obj_player.facing*TILE_SIZE),
			0, min(room_width,_camera_zone_right.bbox_left + TILE_SIZE)-global.view_width);
				
		} else {
			camera_target_x = clamp(obj_player.x - (global.view_width/2) + (obj_player.x_vel_current*3) + (obj_player.facing*TILE_SIZE), 0, room_width-global.view_width);
		}
	} else {
		camera_target_x = clamp(obj_player.x - (global.view_width/2) + (obj_player.x_vel_current*3) + (obj_player.facing*TILE_SIZE), 0, room_width-global.view_width);
	}

} else {
	camera_target_x = clamp(obj_player.x - (global.view_width/2) + (obj_player.x_vel_current*3) + (obj_player.facing*TILE_SIZE), 0, room_width-global.view_width);
	ds_list_destroy(_camera_zone_x_list);
}
	
#endregion

#region vertical camera movement
var _camera_zone_y_list = ds_list_create();
if (collision_line(obj_player.x,camera_current_y,obj_player.x,camera_current_y+global.view_height,obj_camera_zone,false,false)) {
		
	var _num_y = collision_line_list(obj_player.x,camera_current_y,obj_player.x,camera_current_y+global.view_height,obj_camera_zone,false,false,_camera_zone_y_list,false);
	if (_num_y > 0) {
		var _camera_zone_up = noone;
		var _camera_zone_down = noone;
		for (var i=0;i<_num_y;i++) {
			if 	(_camera_zone_y_list[| i].up_block){
				if (instance_exists(_camera_zone_up)) {
					if (_camera_zone_y_list[| i].bbox_bottom < _camera_zone_up.bbox_bottom) {
						_camera_zone_up = _camera_zone_y_list[| i];
					}
				} else {
					_camera_zone_up = _camera_zone_y_list[| i];
				}
			}
			if 	(_camera_zone_y_list[| i].down_block){
				if (instance_exists(_camera_zone_down)) {
					if 	(_camera_zone_y_list[| i].bbox_top > _camera_zone_down.bbox_top){
						_camera_zone_down = _camera_zone_y_list[| i];
					}
				} else {
					_camera_zone_down = _camera_zone_y_list[| i];
				}
			}
		}
		if (instance_exists(_camera_zone_up) && obj_player.bbox_top > _camera_zone_up.bbox_bottom) {
			camera_target_y = clamp(
			obj_player.y - (global.view_height/2),
			max(0,_camera_zone_up.bbox_bottom - TILE_SIZE),
			room_height-global.view_height);
		}else if (instance_exists(_camera_zone_down) && obj_player.bbox_bottom < _camera_zone_down.bbox_top) {
			camera_target_y = clamp(
			obj_player.y - (global.view_height/2),
			0, max(0,_camera_zone_down.bbox_bottom - TILE_SIZE)-global.view_height);
		} else {
			camera_target_y = clamp(obj_player.y - (global.view_height/2), -TILE_SIZE, room_height-global.view_height);
		}
	} else {
		camera_target_y = clamp(obj_player.y - (global.view_height/2), -TILE_SIZE, room_height-global.view_height);
	}
} else {
	camera_target_y = clamp(obj_player.y - (global.view_height/2), -TILE_SIZE, room_height-global.view_height);
	ds_list_destroy(_camera_zone_y_list);
}
#endregion

} else {
	camera_target_x = clamp(global.camera_follow.x - (global.view_width/2), 0, room_width-global.view_width);
	camera_current_x = camera_get_view_x(view);
	camera_target_y = clamp(global.camera_follow.y - (global.view_height/2), 0, room_height-global.view_height);
	camera_current_y = camera_get_view_y(view);
}

if (abs(camera_current_x - camera_target_x) < global.view_width && abs(camera_current_y - camera_target_y) < global.view_height) {
	camera_current_x = lerp(camera_current_x,camera_target_x,camera_speed);
	camera_current_y = lerp(camera_current_y,camera_target_y,camera_speed);
} else {
	camera_current_x = camera_target_x;
	camera_current_y = camera_target_y;
}

camera_set_view_pos(view,camera_current_x+random_range(-global.screen_shake,global.screen_shake),camera_current_y+random_range(-global.screen_shake,global.screen_shake));

#endregion

if (global.screen_shake != 0) {
	global.time_dilation_current = 0.2;
} else {
	global.time_dilation_current = global.time_dilation_standard;	
}