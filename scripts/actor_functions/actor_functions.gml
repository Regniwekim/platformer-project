function actor_event_tick(_tick)
{
	// Counters
	jump_buffer = jump_buffer >> 1;
	can_jump = can_jump >> 1;
	
	xinput = input_right-input_left;
	yinput = input_down-input_up;
	acceleration_current = acceleration_standard*acceleration_multiplier;
	resistance_current = resistance_ground*resistance_multiplier;
	jump_height_current = jump_height_standard*jump_height_multiplier;
	walk_speed_current = walk_speed_standard*walk_speed_multiplier*resistance_current;
	if (horizontal_move) x_vel_current = approach(x_vel_current,walk_speed_current*resistance_current*x_input,acceleration_current*resistance_current*global.time_dilation_current);
	if (vertical_move) y_vel_current = approach(y_vel_current,terminal_velocity*resistance_current,gravity_current*resistance_current*global.time_dilation_current);
	// Execute states
	fsm.step();
	move_collide_state(x_vel_current * _tick, y_vel_current * _tick);
}

function actor_state_ground()
{
		
	if (input_run)
	{
		walk_speed_multiplier = run_multiplier;
	} else
	{
		walk_speed_multiplier = 1;
	}
	
	if (input_down)
	{
		if (abs(x_vel_current) > walk_speed_standard*1.2)
		{
			set_state(my_state_slide);
		} else
		{
			set_state(my_state_crouch);
		}
	}
	
	if (animation_end() && (sprite_index = spr_land || sprite_index = spr_roll))
	{
		if (xinput != 0)
		{
			set_sprite(spr_walk,,abs(x_vel_current)/step_size);
		} else 
		{
			set_sprite(spr_idle,true,0.5);
		}
	}
	
	if (sprite_index != spr_land && sprite_index != spr_roll)
	{
		if (xinput == 0)
		{
			if (abs(x_vel_current) >= walk_speed_standard)
			{
				set_state(my_state_skid);
			} else
			{
				set_sprite(spr_idle,,0.5);	
			}
		} else
		{
			if (sign(xinput) != sign(x_vel_current) && abs(x_vel_current) >= walk_speed_standard && can_walk)
			{
				set_state(player_state_skid);
			} else
			{
				if (abs(x_vel_current) > walk_speed_standard && sprite_index != spr_roll)
				{
					set_sprite(spr_run,,abs(x_vel_current)/step_size);
				} else
				{
					set_sprite(spr_walk,,abs(x_vel_current)/step_size);
				}
			}
		}
	}
	
	if (!on_vertical) set_state(my_state_air);
	
	wall_dir = facing;
	actor_jump_ground();
}

function actor_state_crouch()
{
	
}

function actor_state_air()
{
	switch (sign(y_vel_current)) {
		case -1:
			set_sprite(spr_jump,true,0.5);
			break;
		case 0:
			set_sprite(spr_fall,true,0.5);
			break;
		case 1:
			set_sprite(spr_fall,true,0.5);
			break;
		default:
			set_sprite(spr_fall,true,0.5);
			break;
	}
	
	actor_jump_air();
	
	if (!input_jump && y_vel_current <= 0) y_vel_current *= 0.5;
		
	if (on_vertical)
	{
		set_state(my_state_ground);
	}
}

function actor_state_skid()
{
	if (animation_end()) image_speed = 0;
	
	if (on_vertical && ((skid_dir ? x_vel_current <= 0 : x_vel_current >= 0) || (skid_dir ? input_right : input_left))) set_state(my_state_ground);
	
	if (!on_vertical) set_state(my_state_air);

	actor_jump_ground();
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
}

function actor_jump_ground()
{
	if (input_check_jump)
	{
		jump_buffer = jump_buffer_frames;
		if (input_check_down)
		{
			// Drop through one-way platform
			y += C_COLLISION_ONE_WAY_MOVE;
			yprevious += C_COLLISION_ONE_WAY_MOVE; 
			// Setting yprevious is how we "sneak" through the platform in a very simple way
			// Ensure y_vel_current is not zero and positive
			y_vel_current = max(C_COLLISION_ONE_WAY_BUFFER, y_vel_current);
			jump_buffer = 0;
			set_state(actor_state_air);
		}
		else if (jump_buffer)
		{				
			//Maintain movement off moving platforms
			var _plat = instance_place(x,y+2,par_collider);
			if (instance_exists(_plat))
			{
				x_vel_current += _plat.x_vel;
			}
			// Normal jump from the ground
			y_vel_current = -jump_height_current;
			on_vertical = 0;
			jump_buffer = 0;
			can_jump = 0;
			set_state(actor_state_air);
		}
	}
}

function actor_jump_air()
{
	if (input_check_jump)
	{
		jump_buffer = jump_buffer_frames;
	}
	if (jump_buffer)
	{
		if (can_jump--)
		{
		//coyote jump
		y_vel_current = -jump_height_current;
		jump_buffer = 0;
		} else if (multijump_current)
		{
			y_vel_current = -jump_height_current;
			multijump_current--;
			jump_buffer = 0;
			set_state(actor_state_air);
		}
	}
}	

function actor_jump_wall()
{
	if (input_check_jump)
	{
		jump_buffer = jump_buffer_frames;
	}
	
	if (jump_buffer && global.walljump_unlocked)
	{
		//wall jump
		var _jump_angle = 90 + sign(on_horizontal) * jump_wall_angle;
		x_vel_current = lengthdir_x(jump_wall_power, _jump_angle);
		y_vel_current = lengthdir_y(jump_wall_power, _jump_angle);
		on_horizontal = 0;
		jump_buffer = 0;
		set_state(actor_state_air);
	}	
}