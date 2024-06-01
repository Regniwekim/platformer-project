// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function player_state_ground()
{	
	
	/*
	if (input_check("run"))
	{
		walk_speed_multiplier = run_multiplier;
	} else
	{
		walk_speed_multiplier = 1;
	}
	*/
	
	if (input_check("down"))
	{
		if (abs(x_vel_current) > walk_speed_standard*1.2)
		{
			set_state(player_state_slide);
		} else
		{
			set_state(player_state_crouch);
		}
	}
	
	if ((sprite_index = spr_land && (animation_end() || abs(x_vel_current) > walk_speed_standard/2)) || (sprite_index = spr_roll && animation_end()))
	{
		if (xinput != 0)
		{
			set_sprite(spr_walk,,abs(x_vel_current)/step_size);
		}
		else 
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
				set_state(player_state_skid);
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

	can_jump = coyote_time_frames;
	player_jump_ground();	
	player_input_jump();	
	player_input_ladder();	
	player_input_grapple();
	horizontal_movement();	
	vertical_movement();
	
	if (input_check_pressed("attack"))
	{
		set_state(player_state_attack1);	
	}
	
	if ((xinput = 1 && place_meeting(bbox_right+1,bbox_top,par_collider)) || (xinput = -1 && place_meeting(bbox_left-1,bbox_top,par_collider)))
	{
		push_dir = xinput;
		set_state(player_state_push);
	}
	
	if (!on_ground()) set_state(player_state_air);
	
	wall_dir = facing;
}

function player_state_crouch()
{
	if (xinput == 0)
	{
		set_sprite(spr_crouch_idle,,0.5);		
	} else 
	{
		set_sprite(spr_crouch_walk,,abs(x_vel_current)/step_size);
	}
	
	player_jump_ground();	
	player_input_jump();	
	player_input_ladder();	
	player_input_grapple();
	
	horizontal_movement();	
	vertical_movement();
	
	if (!input_check("down") && !collision_line(bbox_left,bbox_bottom-sprite_get_height(spr_player_mask_stand),bbox_right,bbox_bottom-sprite_get_height(spr_player_mask_stand),par_collider,false,false))
	{
		set_state(player_state_ground);	
	}
	
	if (!on_ground()) set_state(player_state_air);
	
	wall_dir = facing;
}

function player_state_jump()
{
	
	if (animation_end()) image_speed = 0;
	
	can_jump--;
	jump_buffer--;
	
	if (!input_check("jump")) y_vel_current *= 0.5;
		
	if (y_vel_current > 0) set_state(player_state_air);
	
	player_input_jump();
	
	player_input_glide()
	
	player_input_wallcling();
	
	player_input_wallclimb();
	
	player_input_ladder();
	
	player_input_grapple();
	
	player_input_ledge_grab()
	
	horizontal_movement();
	
	vertical_movement();	
	
	if (on_ground()) {
		set_state(player_state_ground);
	}
}

function player_state_air()
{
	
	if (animation_end()) image_speed = 0;
	
	can_jump--;
	jump_buffer--;	
	
	player_input_jump();
	
	player_input_glide()
	
	player_input_wallcling();
	
	player_input_wallclimb();
	
	player_input_grapple();
	
	player_input_ladder();
	
	player_input_ledge_grab()
	
	horizontal_movement();
	
	vertical_movement();
	
	if (on_ground()) {
		set_state(player_state_ground);
	}		
}

function player_state_glide()
{
	
	can_jump--;
	jump_buffer--;	
	
	if animation_end() image_speed = 0;	
	
	if (place_meeting(x,y,obj_fan_zone)) {
		var _fan_zone = instance_place(x,y,obj_fan_zone);
		if (instance_exists(_fan_zone) && _fan_zone.thrust != 0)
		{
			var _vx = lengthdir_x(_fan_zone.thrust,_fan_zone.image_angle);
			var _vy = lengthdir_y(_fan_zone.thrust,_fan_zone.image_angle);
			if (_fan_zone.image_angle == 0 || _fan_zone.image_angle == 180)
			{
				x_vel_current = approach(x_vel_current,x_vel_max*_vx*global.time_dilation_current,abs(_fan_zone.thrust)*acceleration_current*global.time_dilation_current);
			}
			if (_fan_zone.image_angle == 90 || _fan_zone.image_angle == 270)
			{
				y_vel_current = approach(y_vel_current,y_vel_max*_vy*global.time_dilation_current,abs(_fan_zone.thrust)*acceleration_current*global.time_dilation_current);
			}
		}
	}else {
		
		if (y_vel_current < 0) y_vel_current *= 0.85;
		if (y_vel_current > y_vel_max * gravity_multiplier) y_vel_current = approach(y_vel_current,y_vel_max * gravity_multiplier * global.time_dilation_current, gravity_current * 2 * global.time_dilation_current);
	}
	
	player_input_jump();
	
	player_input_wallcling();
	
	player_input_wallclimb();
	
	player_input_grapple();
	
	player_input_ladder();
	
	player_input_ledge_grab()
	
	horizontal_movement();
	
	vertical_movement();
	
	if (!input_check("glide")) set_state(player_state_air);
	
	if (on_ground()) set_state(player_state_ground);	
}

function player_state_cling()
{
	
	if animation_end()	image_speed = 0;
	
	if (y_vel_current < 0) y_vel_current *= 0.85;
	if (y_vel_current > y_vel_max * gravity_multiplier) y_vel_current = approach(y_vel_current,y_vel_max * gravity_multiplier * global.time_dilation_current, gravity_current * 2 * global.time_dilation_current);
	
	if (input_check_pressed("jump") && (wall_dir ? place_meeting(bbox_right+1,y,par_collider) : place_meeting(bbox_left-1,y,par_collider))) {
		x_vel_current = jump_height_current*-wall_dir*0.75;
		y_vel_current = -jump_height_current;
		wall_dir = -wall_dir;
		set_state(player_state_jump);
	}
	
	if ((place_meeting(x-1,y,par_collider) && input_check("right")) || (place_meeting(x+1,y,par_collider) && input_check("left")) || (!place_meeting(x-1,y,par_collider) && !place_meeting(x+1,y,par_collider))) {
		sticky_current--;	
	} else {
		sticky_current = sticky_max;	
	}
	
	if (sticky_current <= 0) set_state(player_state_air);
	
	player_jump_ground();
	
	player_input_grapple();
	
	player_input_ledge_grab()
	
	vertical_movement();
	
	if (on_ground()) {
		facing = -facing;
		set_state(player_state_ground);
	}
}

function player_state_wallclimb()
{	
	if (animation_end() && sprite_index = spr_wall_land || yinput != 0)
	{
		set_sprite(spr_wall_climb,false,0);	
	}
	
	if (y_vel_current < 0) y_vel_current *= 0.85;
	if (y_vel_current > y_vel_max * gravity_multiplier) y_vel_current = approach(y_vel_current,y_vel_max * gravity_multiplier * global.time_dilation_current, gravity_current * 2 * global.time_dilation_current);
	
	y_vel_current = yinput*climbing_speed;
	image_speed = -yinput/2;
	
	if (place_meeting(x-1,y,par_collider)) 
	{
		wall_dir = 1;
	} else{
		wall_dir = -1;
	}
	
	if (input_check_pressed("jump")) {
		x_vel_current = jump_height_current*wall_dir*0.75;
		y_vel_current = -jump_height_current;
		wall_dir = -wall_dir;
		set_state(player_state_jump);
	}
	
	if ((place_meeting(x-1,y,par_collider) && input_check("right")) || (place_meeting(x+1,y,par_collider) && input_check("left")) || (!place_meeting(x-1,y,par_collider) && !place_meeting(x+1,y,par_collider))) {
		sticky_current--;	
	} else {
		sticky_current = sticky_max;	
	}
	
	if (sticky_current <= 0) set_state(player_state_air);
	
	player_jump_ground()
	
	player_input_grapple();	
	
	player_input_ledge_grab()
	
	if (on_ground()) {
		facing = -facing;
		set_state(player_state_ground);
	}	
}

function player_state_ladder()
{
		if (sprite_index != spr_player_ladder) {
			y_vel_current = 0;
			image_index = 0;
			image_speed = 0;
		}
		sprite_index = spr_player_ladder;
		gravity_multiplier = 0;
		can_jump = coyote_time_frames;
		y_vel_current = _yinput * climb_speed;
		image_index += _yinput;
		
		player_input_grapple();
		
		player_input_jump();
}

function player_state_skid()
{

	if (animation_end()) image_speed = 0;
	
	if (on_ground() && ((skid_dir ? x_vel_current <= 0 : x_vel_current >= 0) || (skid_dir ? input_check("right") : input_check("left")))) set_state(player_state_ground);
	
	if (!on_ground()) set_state(player_state_air);
	
	
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}
	
	player_jump_ground();
	
	player_input_jump();
	
	player_input_grapple();
	
	vertical_movement();	
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
}

function player_state_slide()
{
	set_sprite(spr_slide,,0.5);
	
	if (animation_end()) image_speed = 0;
	
	player_jump_ground();
	
	player_input_jump();
	
	player_input_grapple();
	
	x_vel_current = approach(x_vel_current,0,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
	
	vertical_movement();
	
	if (!input_check("down") && !collision_line(bbox_left,bbox_bottom-sprite_get_height(spr_player_mask_stand),bbox_right,bbox_bottom-sprite_get_height(spr_player_mask_stand),par_collider,false,false))
	{
		set_state(player_state_ground);	
	}
	
	if ((slide_dir ? x_vel_current <= 0 : x_vel_current >= 0))
	{
		set_state(player_state_crouch);
	}
	if (!on_ground()) set_state(player_state_air);
	
}

function player_state_grapple()
{
	
	var _chain_angle_acceleration = -0.2 * dcos(chain_direction);	
	
	var _curve = animcurve_get(ac_grapple_acceleration);
	var _channel = _curve.channels[0];
	var _val = animcurve_channel_evaluate(_channel,(1-(chain_length/max_chain_length))*(max_chain_length/grapple_distance_max));
	
	
	//if (on_ground()) chain_length--;
		
	
	
	if (input_check_pressed("grapple"))
	{
		max_chain_length = chain_length;
	}
	
	if (input_check("grapple_reel"))
	{
		grapple_reel_active = true;
		chain_length = approach(chain_length,0,_val);//clamp(chain_length+yinput * 3,0,grapple_distance_max); //approach(chain_length,32,(1/chain_length)*max_chain_length*y_vel_max*1.5)	
	}
	else
	{
		_chain_angle_acceleration += xinput * 0.1;
		chain_angle_velocity += _chain_angle_acceleration;
		chain_direction += chain_angle_velocity;
		chain_angle_velocity *= 0.99;
	}
	
	chain_x = grapple_hook.x + lengthdir_x(chain_length,chain_direction);
	chain_y = grapple_hook.y + lengthdir_y(chain_length,chain_direction);
	
	x_vel_current = clamp(chain_x - x,-y_vel_max,y_vel_max);
	y_vel_current = clamp(chain_y - y,-y_vel_max,y_vel_max);
	
	if (chain_length <= 1)
	{
		set_sprite(spr_crouch_idle,,0.5);	
	}
	
	if (input_check_pressed("jump")) {
		y_vel_current = -jump_height_current;
		multijump_current--;
		set_state(player_state_jump);
	}
	
	if (!input_check("grapple") || (!input_check("grapple_reel") && grapple_reel_active && chain_length > 1)) {
		if (on_ground())
		{
			set_state(player_state_ground);
		}
		else
		{
			set_state(player_state_air);
		}
		
	}
	
		
	player_input_glide();
	
	player_input_wallcling();
	
	player_input_wallclimb();
	
	player_input_ledge_grab()
	
	player_input_ladder();
	
}

function player_state_dash()
{
	global.time_dilation_target = global.time_dilation_standard;
	dash_timer_current--;
	x_vel_current = lengthdir_x(dash_speed,dash_direction);
	y_vel_current = lengthdir_y(dash_speed,dash_direction);
	
	player_input_wallcling();
	
	player_input_wallclimb();
	
	player_input_ledge_grab()
	
	if (dash_timer_current <= 0) {
		if (on_ground()) {
			set_state(player_state_ground)
		} else {
			set_state(player_state_air);
		}
	}
}

function player_state_dash_targeting()
{
	default_stats();
	set_sprite(sprite_index,false,min(image_speed,global.time_dilation_current));
}

function player_state_push()
{
	if (xinput = 0)
	{
		set_sprite(spr_player_push_idle,true,0.5);	
	}
	else if (xinput = push_dir)
	{
		set_sprite(spr_player_push,true,0.5);
	}
	else if (xinput = -push_dir)
	{
		set_state(player_state_ground);	
	}
	
	can_jump = coyote_time_frames;
	player_jump_ground();	
	player_input_jump();	
	player_input_ladder();	
	player_input_grapple();
	horizontal_movement();	
	vertical_movement();
	
	if (input_check("down"))
	{
		set_state(player_state_crouch);	
	}
	
	if (!on_ground()) set_state(player_state_air);
}

function player_state_ledge_grab()
{
	if animation_end() image_speed = 0;
	
	var _block = instance_place(x+facing,y,par_collider);
	
	if (wall_dir ? place_meeting(bbox_right+1,bbox_top,par_collider) : place_meeting(bbox_left-1,bbox_top,par_collider))
	{
		y_vel_current = 0;
		set_sprite(spr_player_ledge_climb,true,0.5);
		if (image_index >= 1)
		{
			image_index = 1;
			image_speed = 0;
		}
		if (input_check_pressed("jump")) 
		{
			if (xinput == wall_dir)
			{
			set_state(player_state_ledge_climb);
			} else
			{
				x_vel_current = jump_height_current*-wall_dir*0.75;
				y_vel_current = -jump_height_current;
				wall_dir = -wall_dir;
				set_state(player_state_jump);
			}
		}
	}
	else
	{
		if (input_check_pressed("jump"))
		{
			x_vel_current = jump_height_current*-wall_dir*0.75;
			y_vel_current = -jump_height_current;
			wall_dir = -wall_dir;
			set_state(player_state_jump);
		}
		if (y_vel_current < 0) y_vel_current *= 0.85;
		if (y_vel_current > y_vel_max * gravity_multiplier) y_vel_current = approach(y_vel_current,y_vel_max * gravity_multiplier * global.time_dilation_current, gravity_current * 2 * global.time_dilation_current);
		vertical_movement();
	}
	
	if ((place_meeting(bbox_left-1,y,par_collider) && input_check("right")) || (place_meeting(bbox_right+1,y,par_collider) && input_check("left")) || (!place_meeting(bbox_left-1,y,par_collider) && !place_meeting(bbox_right+1,y,par_collider)))
	{
		sticky_current--;	
	}
	else
	{
		sticky_current = sticky_max;	
	}
	
	if (sticky_current <= 0) set_state(player_state_air);
	
	player_jump_ground();
	
	player_input_grapple();
	
	if (on_ground()) {
		facing = -facing;
		set_state(player_state_ground);
	}
}

function player_state_ledge_climb()
{
	if animation_end() 
	{
		if (sprite_index = spr_player_ledge_climb) {
			var _block = instance_place(x+facing,y,par_collider);
			if (_block != noone)
			{
				y = _block.bbox_top;
			}
			x += facing * 13;
			set_sprite(spr_player_stand,true,0.5);
		}
		else
		{
			set_state(player_state_ground);
		}
	}
}

function player_state_attack1()
{
	x_vel_current *= 0.9;
	
	if (image_index == 1)
	{
		instance_create_depth(x + (facing*8),y,depth+1,obj_hurtbox,
		{
			team : 0,
			xscale : facing,
			sprite : spr_player_punch1hb
		});	
	}
	
	if (image_index >= 3 && image_index < image_number-1 && input_check_pressed("attack"))
	{
		set_state(player_state_attack2);	
	}
	
	if (image_index >= image_number-1)
	{
		set_state(player_state_ground);	
	}
}

function player_state_attack2()
{
	if (image_index == 1)
	{
		instance_create_depth(x + (facing*8),y,depth+1,obj_hurtbox,
		{
			team : 0,
			xscale : facing,
			sprite : spr_player_punch2hb
		});	
	}
	
	if (image_index >= image_number-1)
	{
		set_state(player_state_ground);	
	}
}