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
	xinput = input_check_opposing("left","right");
	yinput = input_check_opposing("up","down");

	if (input_source_using(INPUT_GAMEPAD))
	{
	    //If we're using a gamepad, limit the cursor to 130px away from the player
	    input_cursor_limit_circle(x, y, 130);
    
	    //We also set an "elastic" rule so that the cursor automatically springs back towards the player
	    //Since we've moved the elastic centre we also want to move the cursor itself by the same amount to keep the cursor in sync
	    input_cursor_elastic_set(x, y, 0.2, undefined, true);
	}
	else
	{
	    //If we're not using the gamepad then remove both the limit and the elastic
	    //This allows the cursor to move totally freely as you'd expect with mouse aiming
	    input_cursor_elastic_remove();
	    input_cursor_limit_remove();
	}

	if (point_distance(x, y, input_cursor_x(), input_cursor_y()) > 10)
	{
	    aim_direction = point_direction(x, y, input_cursor_x(), input_cursor_y());
	}

	if (xinput != 0) {
		facing = xinput;
	}
	
	xscale = approach(xscale,facing,0.33);
	
	step_size = (sprite_get_width(sprite_index)/image_number)*2;

	state();
	
	actor_collision();
}