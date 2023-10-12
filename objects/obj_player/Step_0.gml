/// @description Things that update regardless of state
if (active) {
	
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
	aim_dir = point_direction(0,0,xinput,yinput);

	if (xinput != 0) {
		facing = xinput;
	}
	
	xscale = approach(xscale,facing,0.33);
	
	step_size = (sprite_get_width(sprite_index)/image_number)*2;

	state();
	
	actor_collision();
}