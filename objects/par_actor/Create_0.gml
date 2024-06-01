event_inherited();

step_size = (sprite_get_width(sprite_index)/image_number)*2;
xscale = image_xscale;
blink = 0;
facing = sign(image_xscale);
xinput = 0;
yinput = 0;
x_vel_current = 0;
y_vel_current = 0;

walk_speed_multiplier = 1;
acceleration_multiplier = 1;
braking_multiplier = 1;
friction_multiplier = 1;
gravity_multiplier = 1;
resistance_multiplier = 1;

walk_speed_current = walk_speed_standard;
acceleration_current = acceleration_standard;
resistance_current = resistance_standard;

sprites = {};
xscale = 1;
yscale = 1;

horizontal_move = true;
vertical_move = true;

/*
fsm = new SnowState("actor_idle");

fsm
.event_set_default_function("draw", function() {
	// Draw this no matter what state we are in
	// (Unless it is overridden, ofcourse)
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
})

.event_set_default_function("enter", function() {
	default_stats();
	//get_sprite(); //grab the sprite based on the state we entered
})

.add("actor_idle",{	
	enter: function()
	{
		fsm.inherit();
		x_vel_current = 0;	
	},
	step: function()
	{
		if (xinput != 0) fsm.change("actor_walk");
		if (!on_vertical) fsm.change("actor_air");
	}
})

.add("actor_walk",{
	step: function()
	{
		if (xinput == 0) fsm.change("actor_idle");	
		if (!on_vertical) fsm.change("actor_air");
	}
})

.add("actor_air", {
	enter: function()
	{
		fsm.inherit();
		resistance_multiplier = resistance_air;
	},
	step: function()
	{
		if (on_vertical)
		{
			if (xinput != 0)
			{
				fsm.change("actor_walk");
			} else
			{
				if (y_vel_current > terminal_velocity/2)
				{
					fsm.change("actor_land");
				} else
				{
					fsm.change("actor_idle");
				}
			}
		}
	}
})

.add("actor_land", {
	enter: function()
	{
		fsm.inherit();
		horizontal_move = false;
	},
	step: function()
	{
		if (animation_end())
		{
			if (xinput != 0) {
				fsm.change("actor_walk");	
			} else
			{
				fsm.change("actor_idle");	
			}
		}
	}
})

.add_child("actor_land","actor_hurt", {
	enter: function()
	{
		fsm.inherit();
		
	},
	step: function()
	{
		fsm.inherit();
		blink++;
	},
	
	draw: function()
	{
		fsm.inherit();
		//some kind of flashing or blinking thingie?
	}
})