// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_ground() {	
	
	if (input_check("run")) {
		run_multiplier_current = run_multiplier;
	} else run_multiplier_current = 1;
	
	if (input_check("down")) {
		if (abs(x_vel_current) > walk_speed_standard*1.2) {
			set_state(player_state_slide);
		} else {
			crouch_multiplier_current = crouch_multiplier;
		}
	} else crouch_multiplier_current = 1;
	
	//sprite switching
	if (sprite_index = spr_land && abs(x_vel_current) > 1) set_sprite(spr_idle,true,0.5);
	if (animation_end() && sprite_index = spr_land) set_sprite(spr_idle,true,0.5);
	
	
	if (sprite_index != spr_land) {
		if (xinput = 0) {
			if (x_vel_current != 0) {
				set_state(player_state_skid);
			} else if (input_check("down")) {
				set_sprite(spr_crouch,,0.5);
			} else {
				set_sprite(spr_idle,,0.5);
			}
		} else {
			if (sign(xinput) != sign(x_vel_current) && abs(x_vel_current) >= walk_speed_standard) set_state(player_state_skid);
			if (input_check("down")) {
				set_sprite(spr_crouch_walk,,abs(x_vel_current)/step_size);
			} else {
				if (abs(x_vel_current) > walk_speed_standard) {
					set_sprite(spr_run,,abs(x_vel_current)/step_size);
				} else {
					set_sprite(spr_walk,,abs(x_vel_current)/step_size);
				}
			}
		}
		
	}

	player_jump_ground();	
	player_input_jump();	
	player_input_ladder();	
	player_input_grapple();
	
	horizontal_movement();	
	vertical_movement();
	
	if (!on_ground()) set_state(player_state_air);
	
	wall_dir = xinput;
}

function player_state_jump() {
	
	if (animation_end()) image_speed = 0;
	
	can_jump--;
	jump_buffer--;
	
	if (!input_check("jump")) y_vel_current *= 0.5;
		
	if (y_vel_current > 0) set_state(player_state_air);
	
	player_input_jump();
	
	player_input_glide()
	
	player_input_walljump();
	
	player_input_ladder();
	
	player_input_grapple();
	
	horizontal_movement();
	
	vertical_movement();	
	
	if (on_ground()) {
		set_state(player_state_ground);
	}
}

function player_state_air() {
	
	if (animation_end()) image_speed = 0;
	
	can_jump--;
	jump_buffer--;	
	
	player_input_jump();
	
	player_input_glide()
	
	player_input_walljump();
	
	player_input_grapple();
	
	player_input_ladder();
	
	horizontal_movement();
	
	vertical_movement();
	
	if (on_ground()) {
		set_state(player_state_ground);
	}		
}

function player_state_glide() {
	
	can_jump--;
	jump_buffer--;	
	
	if animation_end() image_speed = 0;	
	
	if (place_meeting(x,y,obj_fan_zone)) {
		var _fan_zone = instance_place(x,y,obj_fan_zone);
		if (instance_exists(_fan_zone)) {
			if (_fan_zone.y_thrust != 0) {
				y_vel_current = approach(y_vel_current,y_vel_max*sign(_fan_zone.y_thrust)*global.time_dilation_current,abs(_fan_zone.y_thrust)*acceleration_current*global.time_dilation_current);
			}
			if (_fan_zone.x_thrust != 0) {
				x_vel_current = approach(x_vel_current,x_vel_max*_fan_zone.x_thrust*global.time_dilation_current,abs(_fan_zone.x_thrust)*acceleration_current*global.time_dilation_current);
			}
		}
	} else {
		if (y_vel_current < 0) y_vel_current *= 0.85;
		if (y_vel_current > y_vel_max * gravity_multiplier) y_vel_current = approach(y_vel_current,y_vel_max * gravity_multiplier * global.time_dilation_current, gravity_current * 2 * global.time_dilation_current);
	}
	
	player_input_jump();
	
	player_input_walljump();
	
	player_input_grapple();
	
	player_input_ladder();
	
	horizontal_movement();
	
	vertical_movement();
	
	if (!input_check("glide")) set_state(player_state_air);
	
	if (on_ground()) set_state(player_state_ground);	
}

function player_state_cling() {
	
	if animation_end()	image_speed = 0;
	
	gravity_multiplier = 0.15;
	
	if (place_meeting(x-1,y,par_solid)) wall_dir = 1;
	else wall_dir = -1;
		
	if (y_vel_current < 0) y_vel_current *= 0.85;
	if (y_vel_current > y_vel_max * gravity_multiplier) y_vel_current = approach(y_vel_current,y_vel_max * gravity_multiplier * global.time_dilation_current, gravity_current * 2 * global.time_dilation_current);
	
	if (input_check_pressed("jump")) {
		x_vel_current = jump_height_current*wall_dir*0.25;
		y_vel_current = -jump_height_current;
		//wall_dir = -wall_dir;
		set_state(player_state_jump);
	}
	
	if ((place_meeting(x-1,y,par_solid) && input_check("right")) || (place_meeting(x+1,y,par_solid) && input_check("left")) || (!place_meeting(x-1,y,par_solid) && !place_meeting(x+1,y,par_solid))) {
		sticky_current--;	
	} else {
		sticky_current = sticky_max;	
	}
	
	if (sticky_current <= 0) set_state(player_state_air);
	
	player_jump_ground()
	
	player_input_grapple();
	
	vertical_movement();	
	
	if (on_ground()) {
		facing = -facing;
		set_state(player_state_ground);
	}
}

function player_state_ladder() {
		if (sprite_index != spr_player_ladder) {
			y_vel_current = 0;
			image_index = 0;
			image_speed = 0;
		}
		sprite_index = spr_player_ladder;
		gravity_multiplier = 0;
		can_jump = coyote_time;
		y_vel_current = _yinput * climb_speed;
		image_index += _yinput;
		
		player_input_grapple();
		
		player_input_jump();
}

function player_state_skid() {

	if (animation_end()) image_speed = 0;
	
	if (on_ground() && ((skid_dir ? x_vel_current <= 0 : x_vel_current >= 0) || (skid_dir ? input_check("right") : input_check("left")))) set_state(player_state_ground);
	
	if (!on_ground()) set_state(player_state_air);
	
	
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}
	
	player_jump_ground();
	
	player_input_jump();
	
	player_input_grapple();
	
	vertical_movement();	
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
}

function player_state_slide() {
	
	if (animation_end()) image_speed = 0;	
	
	player_jump_ground();
	
	player_input_jump();
	
	player_input_grapple();
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
	
	vertical_movement();
	
	if (on_ground() && ((slide_dir ? x_vel_current <= 0 : x_vel_current >= 0) || !input_check("down"))) set_state(player_state_ground);
	
	if (!on_ground()) set_state(player_state_air);
	
}

function player_state_grapple() {
	
	var _chain_angle_acceleration = -0.2 * dcos(chain_direction);
	
	_chain_angle_acceleration += xinput * acceleration_current;
	
	chain_length += yinput * 3; //approach(chain_length,32,(1/chain_length)*max_chain_length*y_vel_max*1.5)
	chain_angle_velocity += _chain_angle_acceleration;
	chain_direction += chain_angle_velocity;
	chain_angle_velocity *= 0.99;
	
	chain_x = grapple_hook.x + lengthdir_x(chain_length,chain_direction);
	chain_y = grapple_hook.y + lengthdir_y(chain_length,chain_direction);
	
	x_vel_current = clamp(chain_x - x,-x_vel_max*2,x_vel_max*2);
	y_vel_current = clamp(chain_y - y,-y_vel_max*2,y_vel_max*2);
	
	if (input_check_pressed("jump")) {
		y_vel_current = -jump_height_current;
		multijump_current--;
		set_state(player_state_jump);
	}
	
	//if (place_meeting(x+x_vel_current,(sign(y_vel_current) ? bbox_bottom : bbox_top)+y_vel_current,grapple_point)) set_state(player_state_air);

	if (!input_check("grapple")) {
		set_state(player_state_air);
	}
	
	player_input_glide();
	
	player_input_walljump();
	
	player_input_ladder();
	
}