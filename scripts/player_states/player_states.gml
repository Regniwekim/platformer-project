// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_ground() {
	
	if (state_previous != player_state_ground) {
		if (state_previous = player_state_air) {
			set_sprite(spr_land,true,);
		} else if input_check("down") {
			set_sprite(spr_crouch,,);
		} else {
			set_sprite(spr_idle,,0.5);	
		}
		acceleration_multiplier = 1;
		braking_multiplier = 1;
		jump_height_multiplier = 1;
		friction_multiplier = 1;
		gravity_multiplier = 1;
		jump_height_multiplier = 1;
		sticky_current = sticky_max;
		multijump_current = global.multijump_max;
		state_previous = player_state_ground;
	}	
	
	horizontal_movement();
	
	vertical_movement()
	
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
				//image_speed = abs(x_vel_current)/crouch_step_size;//abs(x_vel_current*3)/x_vel_max;//1.8 pixels per frame movement
			} else {
				if (abs(x_vel_current) > walk_speed_standard) {
					set_sprite(spr_run,,abs(x_vel_current)/step_size);
				} else {
					set_sprite(spr_walk,,abs(x_vel_current)/step_size);
				}
				
				//image_speed = abs(x_vel_current)/walk_step_size;
			}
		}
		
	}
	
	
	//vertical movement	
	if (jump_buffer > 0) {
		y_vel_current = -jump_height_current;
		set_state(player_state_jump);
	}
	
	jump_buffer = 0;
	can_jump = coyote_time;
	multijump_current = global.multijump_max;
	
	player_input_jump();
	
	player_input_ladder();
	
	if (!on_ground()) set_state(player_state_air);
	
	wall_dir = xinput;
}

function player_state_jump() {
	if (state_previous != player_state_jump) {
		if (sprite_index != spr_air_jump) {
			set_sprite(spr_jump,true,1);
		}
		if (multijump_current = global.multijump_max) {
			audio_play_sound(snd_jump1,0,false);
		} else {
			audio_play_sound(snd_jump3,0,false);	
		}
		acceleration_multiplier = 1;
		braking_multiplier = 1;
		jump_height_multiplier = 1;
		friction_multiplier = 1;
		gravity_multiplier = 1;
		jump_height_multiplier = 1;
		resistance_multiplier = resistance_air;
		sticky_current = sticky_max;
		state_previous = player_state_jump;
	}
		
	if (animation_end()) image_speed = 0;
		
	if (!input_check("jump")) y_vel_current *= 0.5;
		
	if (y_vel_current > 0) set_state(player_state_air);
	
	horizontal_movement();
	
	vertical_movement();
	
	player_input_jump();
	
	player_input_walljump();
	
	player_input_ladder();
		
	can_jump--;
	jump_buffer--;
	
	if (on_ground()) {
		set_state(player_state_ground);
	}
}

function player_state_air() {
	if (state_previous != player_state_air) {
		set_sprite(spr_fall,true,);
		image_speed = 1;
		acceleration_multiplier = 1;
		braking_multiplier = 1;
		jump_height_multiplier = 1;
		friction_multiplier = 1;
		gravity_multiplier = 1;
		jump_height_multiplier = 1;
		resistance_multiplier = resistance_air;
		sticky_current = sticky_max;
		state_previous = player_state_air;
	}
	
	if (animation_end()) image_speed = 0;	
	
	horizontal_movement();
	
	vertical_movement();
	
	player_input_jump();
	
	player_input_walljump();
	
	player_input_ladder();
	
	can_jump--;
	jump_buffer--;	
	
	if (on_ground()) {
		set_state(player_state_ground);
	}		
}

function player_state_glide() {
	if (state_previous != player_state_glide) {
		set_sprite(spr_glide,true,0.5);
		audio_play_sound(snd_impact3,0,false);
		image_index = image_number-1;
		acceleration_multiplier = 1;
		braking_multiplier = 1;
		jump_height_multiplier = 1;
		friction_multiplier = 1;
		gravity_multiplier = 0.15;
		jump_height_multiplier = 1;
		resistance_multiplier = resistance_air;
		sticky_current = sticky_max;
		state_previous = player_state_glide;
	}
	
	if animation_end()	image_speed = 0;
	
	if (!input_check("jump")) set_state(player_state_air);
	
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
	
	horizontal_movement();
	
	vertical_movement();
	
	player_input_jump();
	
	player_input_walljump();
	
	player_input_ladder();
	
	can_jump--;
	jump_buffer--;	
	
	if (on_ground()) {
		set_state(player_state_ground);
	}		
}

function player_state_cling() {
	if (state_previous != player_state_cling) {
		set_sprite(spr_wall_land,true,1)
		acceleration_multiplier = 1;
		braking_multiplier = 1;
		jump_height_multiplier = 1;
		friction_multiplier = 1;
		gravity_multiplier = 0.15;
		jump_height_multiplier = 1;
		sticky_current = sticky_max;
		multijump_current = global.multijump_max;
		state_previous = player_state_cling;
	}
	
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
	
	vertical_movement();
	
	if (on_ground()) {
		set_sprite(spr_idle);
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
}

function player_state_skid() {
	if (state_previous != player_state_skid) {
		skid_dir = x_vel_current;
		if (abs(x_vel_current) > walk_speed_standard) {
			set_sprite(spr_skid,true,);
		}
		braking_multiplier = 2;
		sticky_current = sticky_max;
		state_previous = player_state_skid;
	}
	
	if (animation_end()) image_speed = 0;
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
	
	vertical_movement();
	
	if (on_ground() && ((skid_dir ? x_vel_current <= 0 : x_vel_current >= 0) || (skid_dir ? input_check("right") : input_check("left")))) set_state(player_state_ground);
	
	if (!on_ground()) set_state(player_state_air);
	
	
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}
}

function player_state_slide() {
	if (state_previous != player_state_slide) {
		slide_dir = sign(x_vel_current);
		set_sprite(spr_slide,true,);
		braking_multiplier = 0.5;
		friction_multiplier = 0.75;
		sticky_current = sticky_max;
		state_previous = player_state_slide;
	}
	
	if (animation_end()) image_speed = 0;	
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
	
	vertical_movement();
	
	player_input_jump();
	
	if (on_ground() && ((slide_dir ? x_vel_current <= 0 : x_vel_current >= 0) || !input_check("down"))) set_state(player_state_ground);
	
	if (!on_ground()) set_state(player_state_air);
}