event_inherited();

fsm
.add_child("actor_walk","player_walk", {
	enter: function()
	{
		default_stats();
	},
	step: function()
	{
		if (input_run)
		{
			fsm.change("player_run");
		}
	
		if (input_down)
		{
			if (abs(x_vel_current) > walk_speed_standard*1.2)
			{
				fsm.change("player_slide");
			} else
			{
				fsm.change("player_crouch");
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
	}
});