event_inherited();

jump_height_standard = 8;
jump_height_multiplier = 1;
wall_stick_current = 0;
jump_buffer = 0;
multijump_current = 0;
wall_dir = 0;
can_jump = coyote_time_frames;
wall_dir = facing;
attack_input = 0;

input_left = input_check("left");
input_right = input_check("right");
input_up = input_check("up");
input_down = input_check("down");
input_run = input_check("run");
input_pressed_jump = input_check_pressed("jump");
input_jump = input_check("jump");

init_sprites(
"player_idle",spr_player_idle,
"player_walk", spr_player_walk,
"player_run",spr_player_run,
"player_crouch_idle",spr_player_crouch_idle,
"player_crouch_walk",spr_player_crouch_walk,
"player_air", spr_player_air,
"player_jump", spr_player_air,
"player_roll",spr_player_roll,
"player_land",spr_player_land
)
fsm = new SnowState("player_idle");

fsm
.history_enable()
.history_set_max_size(20)
.event_set_default_function("draw", function() {
	// Draw this no matter what state we are in
	// (Unless it is overridden, ofcourse)
	draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
})
.event_set_default_function("enter", function() {
	default_stats();
	image_index = 0;
	sprite_index = get_sprite(); //grab the sprite based on the state we entered
})
.add("player_roll", {
	enter: function()
	{
		
	}
})

.add("player_idle", {
	enter: function()
	{
		fsm.inherit();
		image_speed = 0.5;
		x_vel_current = 0;
	},
	step: function()
	{
		if (xinput != 0) fsm.change("player_walk");
		if (!on_vertical) fsm.change("player_air");
	}
})

.add("player_walk", {
	enter: function()
	{
		fsm.inherit();
		default_stats();
		jump_buffer = 0;
	},
	step: function()
	{
		fsm.inherit();
		if (input_run)
		{
			fsm.change("player_run");
		}
	
		if (input_down)
		{
			fsm.change("player_crouch");
		}
		
		if (input_jump)
		{
			jump_buffer = jump_buffer_frames;
		}
		
		if (jump_buffer > 0)
		{
			y_vel_current = -jump_height_current;
			fsm.change("player_jump");
		}
		
		if (xinput == 0)
		{
			if (abs(x_vel_current) >= walk_speed_standard)
			{
				fsm.change("player_skid");
			} else
			{
				fsm.change("player_idle");	
			}
		} else
		{
			if (sign(xinput) != sign(x_vel_current) && abs(x_vel_current) >= walk_speed_standard && can_walk)
			{
				fsm.change("player_skid");
			} else
			{
				set_sprite(spr_walk,,abs(x_vel_current)/step_size);
			}
		}
		
		if (!on_vertical)
		{
			fsm.change("player_air");	
		}
	}
})

.add_child("player_walk","player_run", {
	enter: function()
	{
		fsm.inherit();
		walk_speeed_multiplier = run_multiplier;	
	}
})

.add("player_air", {
	enter: function()
	{
		fsm.inherit();
		image_speed = 0;
	},
	step: function()
	{
		can_jump--;
		jump_buffer--;
		
		image_index = 1 + sign(y_vel_current/3);
		
		if (input_pressed_jump)
		{
			if (can_jump > 0)
			{
				y_vel_current = -jump_height_current;
				fsm.change("player_jump");
			}
			else if (place_meeting(x,y+(y_vel_current*jump_buffer_frames)+1,par_collider))
			{
				jump_buffer = jump_buffer_frames;	
			}
			else if (multijump_current > 0)
			{
				y_vel_current = -jump_height_current;
				fsm.change("player_jump");
			}
		}
		
		if (on_vertical)
		{
			if (jump_buffer > 0)
			{
				y_vel_current = -jump_height_current;
				fsm.change("player_jump");
			}
			else if (abs(x_vel_current) > walk_speed_standard)
			{
				fsm.change("player_roll");
			}
			else
			{
				if (y_vel_current > terminal_velocity/2)
				{
					fsm.change("player_land");
				}
				else
				{
					fsm.change("player_idle");
				}
			}
		}
	}
})

.add_child("player_air", "player_jump", {
	step: function()
	{
		fsm.inherit();
		if (!input_jump) y_vel_current *= 0.5;
		if (y_vel_current >= 0) fsm.change("player_air");
	}
})

.add("player_land", {
	enter: function()
	{
		fsm.inherit();
		yscale = 0.66;
		x_vel_current = 0;	
	},
	step: function()
	{
		if (animation_end())
		{
			if (xinput != 0)
			{
				fsm.change("player_walk");
			}
			else
			{
				fsm.change("player_idle");	
			}
		}
	}
})

.add("player_roll", {
	enter: function()
	{
		fsm.inherit();
		braking_multiplier = 2;
	}
})