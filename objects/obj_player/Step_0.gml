/// @description Insert description here
// You can write your code in this editor

//things that update regardless of state



//calculate movement
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

	if (xinput != 0) {
		facing = xinput;	
	}
	
	step_size = (sprite_get_width(sprite_index)/image_number)*2;

	state();
	
	if (keyboard_check_pressed(ord("P"))) {
		game_set_speed(game_get_speed(gamespeed_fps) == 60 ? 5 : 60,gamespeed_fps);	
	}
	
	entity_collision();
}