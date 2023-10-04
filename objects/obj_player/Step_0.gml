/// @description Insert description here
// You can write your code in this editor

//things that update regardless of state



//calculate movement
if (active) {
	
	walk_speed_current = walk_speed_standard*walk_speed_multiplier;
	acceleration_current = acceleration_standard*acceleration_multiplier
	braking_current = braking_standard*braking_multiplier;
	jump_height_current = jump_height_standard*jump_height_multiplier;
	friction_current = friction_stadard*friction_multiplier;
	gravity_current = gravity_standard * gravity_multiplier;
	jump_height_current = jump_height_standard*jump_height_multiplier;
	
	walk_speed_current = walk_speed_standard*walk_speed_multiplier*friction_current*resistance_current;
	acceleration_current = acceleration_standard*acceleration_multiplier*friction_current*resistance_current;
	
	//input
	xinput = input_check("right") - input_check("left");
	yinput = input_check("down") - input_check("up");
	
	gravity_current = gravity_standard * gravity_multiplier
	y_vel_current = approach(y_vel_current, y_vel_max * gravity_multiplier, gravity_current);

	if (xinput != 0) {
		facing = xinput;	
	}

	if (input_check_pressed("interact")) {
		var _tx = echo_x;
		var _ty = echo_y;
		echo_sprite = sprite_index;
		echo_frame = image_index;
		echo_facing = facing;
		echo_x = x;
		echo_y = y;
		x = _tx;
		y = _ty;
	}

	bounce += 0.05;

	state();
	
	entity_collision();
}