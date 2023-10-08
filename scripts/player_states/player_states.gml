// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_ground(){
	
	if (state_previous != player_state_ground) {
		set_sprite(spr_land,true);
		run_multiplier = 1.5;
		acceleration_multiplier = 1;
		braking_multiplier = 1;
		jump_height_multiplier = 1;
		friction_multiplier = 1;
		gravity_multiplier = 1;
		jump_height_multiplier = 1;
		sticky_current = sticky_max;
		state_previous = player_state_ground;
	}
	
	
	horizontal_movement();
	
	if (input_check("run")) {
		run_multiplier_current = run_multiplier;
	} else run_multiplier_current = 1;
	
	if (input_check("down")) {
		crouch_multiplier_current = crouch_multiplier;
	} else crouch_multiplier_current = 1;
	
	
	//sprite switching
	if (sprite_index = spr_land && abs(x_vel_current) > 1) set_sprite(spr_idle,true);
	if (animation_end() && sprite_index = spr_land) set_sprite(spr_idle,true);
	
	
	if (sprite_index != spr_land) {
		if (xinput = 0) {
			if (abs(x_vel_current) > walk_speed_standard) set_state(player_state_skid);
			if (input_check("down")) {
				set_sprite(spr_crouch);
			} else set_sprite(spr_idle);
		} else {
			if (sign(xinput) != sign(x_vel_current) && abs(x_vel_current) > walk_speed_standard) set_state(player_state_skid);
			if (input_check("down")) {
				set_sprite(spr_crouch_walk);
				image_speed = abs(x_vel_current)/crouch_step_size;//abs(x_vel_current*3)/x_vel_max;//1.8 pixels per frame movement
			} else {
				set_sprite(spr_walk);
				image_speed = abs(x_vel_current)/walk_step_size;
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
	multijump_current = multijump_max;
		
	if (input_check_pressed("jump")) {
		if (place_meeting(x,y+1,obj_oneway) && input_check("down")) {
			y++;
			set_state(player_state_air);
		} else {
			y_vel_current = -jump_height_current;	
			set_state(player_state_jump);
		}
	}
	
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}
	
	if (!on_ground()) set_state(player_state_air);
	
	wall_dir = xinput;
}

function player_state_jump() {
	if (state_previous != player_state_jump) {
		set_sprite(spr_jump,true);
		image_speed = 1;
		run_multiplier = 1.5;
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
		
	if (y_vel_current > 0) {
		set_state(player_state_air);	
	}
	
	if ((place_meeting(x+1,y,par_solid) && input_check("right")) || (place_meeting(x-1,y,par_solid) && input_check("left"))) {
		set_state(player_state_cling);	
	}
	
	horizontal_movement();
		
	can_jump--;
	jump_buffer--;
}

function player_state_air() {
	if (state_previous != player_state_air) {
		set_sprite(spr_fall,true);
		image_speed = 1;
		run_multiplier = 1.5;
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
	
	
	if (input_check_pressed("jump")) {
		if (can_jump > 0) {
			y_vel_current = -jump_height_current;
			can_jump = 0;
		} else if (place_meeting(x,y+(y_vel_current*coyote_time),par_solid)) {
			jump_buffer = coyote_time;
		} else if (multijump_current > 0) {
			y_vel_current = -jump_height_current;
			multijump_current--;
		}
	}
	can_jump--;
	jump_buffer--;
	
	horizontal_movement();
	
	if ((place_meeting(x+1,y,par_solid) && input_check("right")) || (place_meeting(x-1,y,par_solid) && input_check("left"))) {
		set_state(player_state_cling);	
	}
	
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}
	
	if (on_ground()) {
		set_state(player_state_ground);
	}
		
}

function player_state_cling() {
	if (state_previous != player_state_cling) {
		set_sprite(spr_wall_land,true,2)
		run_multiplier = 1.5;
		acceleration_multiplier = 1;
		braking_multiplier = 1;
		jump_height_multiplier = 1;
		friction_multiplier = 1;
		gravity_multiplier = 0.15;
		jump_height_multiplier = 1;
		sticky_current = sticky_max;
		state_previous = player_state_cling;
	}
	
	if animation_end() {
		image_index = image_number - 1;
		image_speed = 0;
	}
	
	gravity_multiplier = 0.15;
	
	if (place_meeting(x-1,y,par_solid)) wall_dir = 1;
	else wall_dir = -1;
		
	if (y_vel_current < 0) y_vel_current *= 0.85;
	if (y_vel_current > y_vel_max * gravity_multiplier) y_vel_current = approach(y_vel_current,y_vel_max * gravity_multiplier, gravity_current * 2);
	
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
		set_sprite(spr_skid,true);
		braking_multiplier = 2;
		sticky_current = sticky_max;
		state_previous = player_state_skid;
	}
	
	if (animation_end()) image_speed = 0;
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current);
	
	if (on_ground() && ((skid_dir < 0 && x_vel_current >= 0) || (skid_dir > 0 && x_vel_current <= 0))) set_state(player_state_ground);
	
	if (!on_ground()) set_state(player_state_air);
	
	if (jump_buffer > 0) {
		y_vel_current = -jump_height_current;	
	}
	jump_buffer = 0;
	can_jump = coyote_time;
		
	if (input_check_pressed("jump")) {
		if (place_meeting(x,y+1,obj_oneway) && input_check("down")) {
			y++;
			set_state(player_state_air);
		} else {
			y_vel_current = -jump_height_current;	
			set_state(player_state_jump);
		}
	}
	
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}
}