state = undefined;
xvel = 0;
image_speed = 0.5;

dummy_state_idle = function()
{
	if (sprite_index != spr_player_idle)
	{
		sprite_index = spr_player_idle;
		image_index = 0;
	}
	
	if (instance_exists(obj_player))
	{
		image_xscale = sign(obj_player.x - x);	
	}
	
	if (place_meeting(x,y,obj_hurtbox))
	{
		var _hb = instance_place(x,y,obj_hurtbox);
		if (_hb != noone)
		{
			xvel = sign(x - _hb.x) * 4;
			state = dummy_state_hurt;
		}
		
	}
}

dummy_state_hurt = function()
{
	if (sprite_index != spr_player_hurt)
	{
		sprite_index = spr_player_hurt;
		image_index = 0;
	}
	
	if (image_index >= image_number - 1)
	{
		state = dummy_state_idle;	
	}
}

state = dummy_state_idle;