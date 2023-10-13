// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function actor_collision(){
// set threshold based on speed
var _tolerance = 1 +  ceil(abs(x_vel_current));
// walking into a wall or upward _slope
if (place_meeting(x + x_vel_current, y, par_solid)) {
	    var _slope = false;
	    // moving up slopes
	for (var i = 1; i <= _tolerance; i++) {
	        if (!place_meeting(x + x_vel_current, y - i, par_solid) && !place_meeting(x + x_vel_current, y - i, obj_oneway_stairs)) {
	            _slope = true;
	            y -= i;
	            break;
	        }
	}

	// not a _slope? then it’s a wall
	if (!_slope) {
	        while (!place_meeting(x + sign(x_vel_current), y, par_solid)) {
	        x += sign(x_vel_current);
	    }
	    x_vel_current = 0;
	}
	if (state == player_state_grapple) {
		chain_direction = point_direction(grapple_hook.x,grapple_hook.y,x,y);
		chain_angle_velocity = 0;
	}
}

// nothing ahead? check for downward slopes!
else if (on_ground()) {
	    // moving down slopes
	for (var i = 0; i <= _tolerance; i++) {
	        if (!place_meeting(x + x_vel_current, y + i + 1, par_solid)) {
	            y += i;
	            break;
	        }
	}
}
	
x += x_vel_current*global.time_dilation_current;

// note that vertical code has NO _slope logic
if (place_meeting(x, y + y_vel_current, par_solid)) {
	while (!place_meeting(x, y + sign(y_vel_current), par_solid)) {
	        y += sign(y_vel_current);
	}
	y_vel_current = 0;
	if (state == player_state_grapple) {
		chain_direction = point_direction(grapple_hook.x,grapple_hook.y,x,y);
		chain_angle_velocity = 0;
	}
}


//one way platform collisions
if (place_meeting(x, y + y_vel_current, obj_oneway) && y_vel_current > 0 && !place_meeting(x,y,obj_oneway)) {
	while (!place_meeting(x, y + 1,obj_oneway)) {
		y++;
	}
	y_vel_current = 0;		
}

y += y_vel_current*global.time_dilation_current;

}

function horizontal_movement() {
	x_vel_current = approach(x_vel_current,walk_speed_current*xinput*resistance_current*run_multiplier_current*crouch_multiplier_current,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
}

function vertical_movement() {
	y_vel_current = approach(y_vel_current, y_vel_max * gravity_multiplier, gravity_current*global.time_dilation_current);
}

function set_state(_state) {
	//execute state leave
	if (state != _state) {
		leave_state(state);
		enter_state(_state);
		state_previous = state;
		state = _state;
	}
}

function leave_state(_state) {
	switch (_state) {
		case player_state_ground:
		break;
		
		case player_state_jump:
		break;
		
		case player_state_air:
		break;
		
		case player_state_cling:
		break;
		
		case player_state_glide:
		break;
		
		case player_state_ladder:
		break;
		
		case player_state_grapple:
			instance_destroy(grapple_hook);
		break;
		
		case player_state_skid:
		break;
		
		case player_state_slide:
		break;

	}
}

function enter_state(_state) {
	switch (_state) {
		case player_state_ground:
			if (state_previous = player_state_air || state_previous = player_state_jump || state_previous = player_state_glide || state_previous = player_state_grapple) {
				set_sprite(spr_land,true,0.5);
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
		break;
		
		case player_state_jump:
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
		break;
		
		case player_state_air:
			set_sprite(spr_fall,true,1);
			acceleration_multiplier = 1;
			braking_multiplier = 1;
			jump_height_multiplier = 1;
			friction_multiplier = 1;
			gravity_multiplier = 1;
			jump_height_multiplier = 1;
			resistance_multiplier = resistance_air;
			sticky_current = sticky_max;
		break;
		
		case player_state_cling:
			set_sprite(spr_wall_land,true,1)
			acceleration_multiplier = 1;
			braking_multiplier = 1;
			jump_height_multiplier = 1;
			friction_multiplier = 1;
			gravity_multiplier = 0.15;
			jump_height_multiplier = 1;
			sticky_current = sticky_max;
			resistance_multiplier = resistance_ground;
			multijump_current = global.multijump_max;
		break;
		
		case player_state_glide:
			set_sprite(spr_glide,true,0);
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
		break;
		
		case player_state_ladder:
		break;
		
		case player_state_grapple:
			set_sprite(spr_glide,true,0);
			image_index = image_number-1;
			acceleration_multiplier = 1;
			braking_multiplier = 1;
			jump_height_multiplier = 1;
			friction_multiplier = 1;
			gravity_multiplier = 1;
			jump_height_multiplier = 1;
			resistance_multiplier = resistance_ground;
			sticky_current = sticky_max;
			chain_length = point_distance(x,y-(sprite_get_height(sprite_index)/2),grapple_hook.x,grapple_hook.y);
			max_chain_length = chain_length;
			chain_direction = point_direction(grapple_hook.x,grapple_hook.y,x,y-(sprite_get_height(sprite_index)/2));
			chain_x = x;
			chain_y = y;
			chain_angle_velocity = x_vel_current;
		break;
		
		case player_state_skid:
			skid_dir = x_vel_current;
			if (abs(x_vel_current) > walk_speed_standard) {
				set_sprite(spr_skid,true,);
			}
			braking_multiplier = 2;
			acceleration_multiplier = 1;
			jump_height_multiplier = 1;
			friction_multiplier = 1;
			gravity_multiplier = 0.15;
			jump_height_multiplier = 1;
			resistance_multiplier = resistance_ground;
			sticky_current = sticky_max;
		break;
		
		case player_state_slide:
			slide_dir = sign(x_vel_current);
			set_sprite(spr_slide,true,);
			braking_multiplier = 0.5;
			friction_multiplier = 0.75;
			sticky_current = sticky_max;
		break;

	}
}

function on_ground() {
	return (place_meeting(x,y+1,par_solid) || (place_meeting(x,y+1,obj_oneway) && !place_meeting(x,y,obj_oneway)));
}

function is_state() {
	for (var i=0;i<argument_count;i++) {
		if (state = argument[i]) return true;
	}
}

function on_oneway() {
	var _on_oneway = place_meeting(x,y+1,obj_oneway);
	
	if !_on_oneway return noone;
	
	var _inside_oneway = place_meeting(x,y,obj_oneway);
	
	if !_inside_oneway return _on_oneway;
	
	if _on_oneway == _inside_oneway return noone;
	
	return _on_oneway;
}

function player_input_jump() {
	if (input_check_pressed("jump")) { //drop through one way
		if (place_meeting(x,y+1,obj_oneway) && input_check("down")) {
			y++;
			set_state(player_state_air);
		}
		
		else if (can_jump > 0) { //jump and coyote jump
		y_vel_current = -jump_height_current;
		set_state(player_state_jump);
			
		} else if (place_meeting(x,y+(y_vel_current*coyote_time),par_solid) && y_vel_current > 0) { //jump buffer
			jump_buffer = coyote_time;
	
		} else if (multijump_current > 0) { //multijump
			if (sprite_index != spr_air_jump) {
				set_sprite(spr_air_jump,true,0.5);	
			}
			y_vel_current = -jump_height_current;
			multijump_current--;
			set_state(player_state_jump);
		} 		
	}
}

function player_jump_ground() {
	if (jump_buffer > 0) {
		y_vel_current = -jump_height_current;
		set_state(player_state_jump);
	}
	
	jump_buffer = 0;
	can_jump = coyote_time;
	multijump_current = global.multijump_max;	
}

function player_input_walljump() {
	if (global.walljump_unlocked && ((place_meeting(x+1,y,par_solid) && input_check("right")) || (place_meeting(x-1,y,par_solid) && input_check("left")))) {
		set_state(player_state_cling);	
	}	
}

function player_input_ladder() {
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}	
}

function player_input_glide() {
	if (y_vel_current >= 0 && input_check("glide") && global.glider_unlocked) {
		set_state(player_state_glide);
	}
}

function player_input_grapple() {
	
	/*
	if (instance_exists(obj_grapple_point)) {
		var _gp = instance_nearest(input_cursor_x(),input_cursor_y(),obj_grapple_point);
			if (point_distance(x,y,_gp.x,_gp.y) < global.view_width/1.5)	{
				grapple_point = _gp;
				grapple_direction = point_direction(x,y-(sprite_get_height(sprite_index)/2),grapple_point.x,grapple_point.y);
			} else grapple_point = noone;
	} else grapple_point = noone;
	*/
	
	if (input_check_pressed("grapple") && global.grapple_unlocked) {
		if (instance_exists(grapple_hook)) {
				instance_destroy(grapple_hook,true);
				set_state(player_state_air);
				
		} else /*if (instance_exists(grapple_point) && !instance_exists(obj_grapple_hook))*/ {
			grapple_direction = aim_direction;
			grapple_hook = instance_create_depth(x,y-(sprite_get_height(sprite_index)/2),depth+1,obj_grapple_hook,{
				x_vel_current : lengthdir_x(30,grapple_direction),
				y_vel_current : lengthdir_y(30,grapple_direction),
				rotation : grapple_direction
			});
		}
	}
	if (!input_check("grapple") && instance_exists(grapple_hook)) instance_destroy(grapple_hook);
}