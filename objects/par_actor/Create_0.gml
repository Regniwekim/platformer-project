event_inherited();

step_size = (sprite_get_width(sprite_index)/image_number)*2;
facing = sign(image_xscale);
xscale = image_xscale;
wall_dir = facing;
xinput = 0;
yinput = 0;
jump_input = 0;
attack_input = 0;
x_vel_current = 0;
y_vel_current = 0;
walk_speeed_multiplier = 1;
acceleration_multiplier = 1;
braking_multiplier = 1;
friction_multiplier = 1;
gravity_multipler = 1;
resistance_multiplier = 1;
jump_height_multiplier = 1;
wall_stick_current = 0;
jump_buffer = 0;
multijump_current = 0;
wall_dir = 0;
can_jump = coyote_time_frames;
walk_speed_current = walk_speed_standard;
acceleration_current = acceleration_standard;
resistance_current = resistance_standard;
jump_height_current = jump_height_standard;

horizontal_move = true;
vertical_move = true;

fsm = new SnowState("actor_idle");

fsm
.event_set_default_function("draw", function() {
	// Draw this no matter what state we are in
	// (Unless it is overridden, ofcourse)
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, image_yscale, image_angle, image_blend, image_alpha);
})
.add("actor_idle",{
	
})

.add("actor_walk",{
	enter: function()
	{
		default_stats();
		multijump_current = global.multijump_max;
		dash_count_current = dash_count_max;
	},
	step: function()
	{

	
		if (!on_vertical) 
		{
			fsm.change("actor air");
		}
		
		wall_dir = facing;
	}
})
