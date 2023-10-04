function player_begin_step(){

}

function player_step(){
	//entity_gravity();
	//entity_collision();
	//script_execute(state);
	
	//horizontal movement
	var _xinput = input_check("right") - input_check("left");
	if (_xinput != 0) {
		facing = _xinput;	
	}
	if ((x_vel_current > 0 && _xinput <= 0) || (x_vel_current < 0 && _xinput >= 0)) {
		braking_multiplier = 1.5;	
	}else {
		braking_multiplier = 1;	
	}
	acceleration_current = acceleration_standard*acceleration_multiplier
	braking_current = braking_standard*braking_multiplier;
	jump_height_current = jump_height_standard*jump_height_multiplier;
	friction_current = friction_stadard*friction_multiplier;
	gravity_current = gravity_standard * gravity_multiplier;
	
	x_vel_current = approach(x_vel_current,x_vel_max*facing*resistance_current,acceleration_current*braking_current*resistance_current);
	
	jump_buffer--;
	
	if (on_ground()) {
		
		can_jump = coyote_time;
		jump_buffer = -1;
		if (jump_buffer > 0) {
			y_vel_current = -jump_height_current;	
		}
		//wall collision
		while (collision_main()) {
			x -= angle_sin;
			y -= angle_cos;
		}
		while (collision_ground() && !collision_main()) {
			x += angle_sin;
			y -= angle_cos;
		}
		resistance_current = resistance_ground;
		angle_current = find_angle(angle_current,radius,radius);
		
	} else {
		can_jump--;
		angle_current = 0;
		y_vel_current = approach(y_vel_current,y_vel_max*gravity_multiplier,gravity_current);
		resistance_current = resistance_air;
	}
	
	angle_cos = cos(degtorad(angle_current));
	angle_sin = sin(degtorad(angle_current));
	
	if (input_check("jump")) {
		if (on_ground()) {
			if (place_meeting(x,y+1,obj_oneway) && input_check("down")) {
				y++;
			} else y_vel_current = -jump_height_current;	
		} else {
			if (can_jump > 0) {
				y_vel_current = -jump_height_current;
			}
			jump_buffer = coyote_time;
		}
	}
	
	//apply movement
	if (x_vel_current > 0) {
		repeat(abs(x_vel_current)) {
			if (!collision_right()) {
				x += angle_cos;
				y -= angle_sin;
			}
		}
	}	
	if (x_vel_current < 0) {
		repeat(abs(x_vel_current)) {
			if (!collision_left()) {
				x -= angle_cos;
				y += angle_sin;
			}
		}
	}	
	if (y_vel_current > 0) {
		repeat(abs(y_vel_current)) {
			if (!collision_top()) {
				y++
			}
		}
	}	
	if (y_vel_current < 0) {
		repeat(abs(y_vel_current)) {
			if (!collision_bottom()) {
				y--;
			}
		}
	}
	
	//wall collision
	while(collision_right()) {
		x -= angle_cos;
		y += angle_sin;
	}
	while(collision_left()) {
		x += angle_cos;
		y -= angle_sin;
	}
	
	//landing
	if (y_vel_current >= 0 && !on_ground() && collision_bottom() && (collision_left() || collision_right())) {
		y_vel_current = 0;
		angle_current = find_angle(angle_current,radius,radius)
	}
}

function player_end_step(){

}