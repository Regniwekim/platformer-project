// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function player_event_tick(_tick)
{
	actor_event_tick(_tick);
	
	input_left = input_check("left");
	input_right = input_check("right");
	input_up = input_check("up");
	input_down = input_check("down");
	input_pressed_jump = input_check_pressed("jump");
	input_jump = input_check("jump");
	
}
function actor_collision()
{
	
	// set threshold based on speed
	var _tolerance = 1 +  ceil(abs(x_vel_current));
	var _slope = false;
	// walking into a wall or upward _slope
	if (place_meeting(x + x_vel_current, y, par_collider))
	{
	
		// moving up slopes
		for (var i = 1; i <= _tolerance; i++) {
		    if (!place_meeting(x + x_vel_current, y - i, par_collider) && !place_meeting(x + x_vel_current, y - i, obj_oneway_stairs)) {
		        _slope = true;
		        y -= i / sqrt(2);
		        break;
		    }
		}

		// not a _slope? then it’s a wall
		if (!_slope) {
			while (!place_meeting(x + sign(x_vel_current), y, par_collider)) {
		        x += sign(x_vel_current);
		    }
		    x_vel_current = 0;
		}
	
		if (state == player_state_grapple) {
			chain_direction = point_direction(grapple_hook.x,grapple_hook.y,x,y);
			chain_angle_velocity = 0;
		}
	}

	// nothing ahead? check for downward slopes!
	else
	{
		// moving down slopes
		for (var i = 0; i <= _tolerance; i++) {
			if (!place_meeting(x + x_vel_current, y + 1, par_collider) && place_meeting(x + x_vel_current, y + i + 1, par_collider)) {
			    y += i;
			    break;
			}
		}
	}
	
	if (_slope)
	{
		x += x_vel_current*global.time_dilation_current / sqrt(2);
	}
	else
	{
		x += x_vel_current*global.time_dilation_current
	}

	// note that vertical code has NO _slope logic
	if (place_meeting(x, y + y_vel_current, par_collider)) {
		while (!place_meeting(x, y + sign(y_vel_current), par_collider)) {
		        y += sign(y_vel_current);
		}
		y_vel_current = 0;
		if (state == player_state_grapple) {
			chain_direction = point_direction(grapple_hook.x,grapple_hook.y,x,y);
			chain_angle_velocity = 0;
		}
	}


	//one way platform collisions
	if (place_meeting(x, y + y_vel_current, obj_horizontal_oneway) && y_vel_current > 0 && !place_meeting(x,y,obj_horizontal_oneway)) {
		while (!place_meeting(x, y + 1,obj_horizontal_oneway)) {
			y++;
		}
		y_vel_current = 0;
	}

	y += y_vel_current*global.time_dilation_current;

}

function horizontal_movement()
{
	walk_speed_current = walk_speed_standard * walk_speed_multiplier * resistance_current;
	x_vel_current = approach(x_vel_current,walk_speed_current*xinput,acceleration_current*braking_current*resistance_current*friction_current*global.time_dilation_current);
}

function vertical_movement()
{
	y_vel_current = approach(y_vel_current, y_vel_max * gravity_multiplier, gravity_current*global.time_dilation_current);
}

function default_stats()
{
	blink = 0;
	horizontal_move = true;
	vertical_move = true;
	acceleration_multiplier = 1;
	braking_multiplier = 1;
	jump_height_multiplier = 1;
	friction_multiplier = 1;
	gravity_multiplier = 1;
	jump_height_multiplier = 1;
	resistance_multiplier = resistance_standard;
	image_speed = 0.5;
}

function default_stats_player()
{
	global.time_dilation_target = global.time_dilation_standard;
	mask_index = spr_player_mask_stand;
}

function set_state(_state)
{
	//execute state leave
	if (state != _state) {
		leave_state(state);
		enter_state(_state);
	}
}

function leave_state(_state)
{
	switch (_state) {
		case player_state_ground:
			break;
		
		case player_state_jump:
			break;
		
		case player_state_air:
			break;
		
		case player_state_cling:
			break;
		
		case player_state_glide:
			break;
		
		case player_state_ladder:
			break;
		
		case player_state_grapple:
			instance_destroy(grapple_hook);
			break;
		
		case player_state_skid:
			break;
		
		case player_state_slide:
			break;
		
		case player_state_dash:
			break;
		
		default:
			//do nothing
			break;
	}
	state_previous = state;
}

function enter_state(_state)
{
	switch (_state) {
		#region ground
		case player_state_ground:
			horizontal_move = true;
			vertical_move = true;
			if (state_previous = player_state_air || state_previous = player_state_jump || state_previous = player_state_glide || state_previous = player_state_grapple)
			{
				var _vel = point_distance(0,0,x_vel_current,y_vel_current);
				if (_vel > walk_speed_standard*run_multiplier*0.75 && abs(x_vel_current) > 1)
				{
					set_sprite(spr_roll,true,1);
				}
				else
				{
					yscale = 0.6;
					xscale = 1.3;
					set_sprite(spr_land,true,1);
				}
			} else
			{
				set_sprite(spr_idle,true,0.5);	
			}
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;
			walk_speed_multiplier = run_multiplier;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			break;
		#endregion
		
		#region crouch
		case player_state_crouch:
			horizontal_move = true;
			vertical_move = true;
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;	
			walk_speed_multiplier = crouch_multiplier;
			mask_index = spr_player_mask_crouch;
			break;
		#endregion
		
		#region jump
		case player_state_jump:
			horizontal_move = true;
			vertical_move = true;
			default_stats();
			default_stats_player();
			sticky_current = sticky_max;	
			resistance_multiplier = resistance_air;
			if (sprite_index != spr_air_jump)
			{
				set_sprite(spr_jump,true,1);
			}
			if (multijump_current = global.multijump_max)
			{
				audio_play_sound(snd_jump1,0,false);
			} else
			{
				audio_play_sound(snd_jump3,0,false);	
			}
			break;
		#endregion
		
		#region air
		case player_state_air:
			
			default_stats();
			default_stats_player();
			sticky_current = sticky_max;	
			resistance_multiplier = resistance_air;
			set_sprite(spr_fall,true,1);
			break;
		#endregion
		
		#region cling
		case player_state_cling:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;
			gravity_multiplier = 0.15;
			xscale = facing*0.66;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			set_sprite(spr_wall_land,true,1)
			break;
		#endregion
		
		#region wallclimb
		case player_state_wallclimb:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;	
			gravity_multiplier = 0;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			set_sprite(spr_wall_land,true,1)
			break;
		#endregion
		
		#region glide
		case player_state_glide:
			set_sprite(spr_glide,true,0);
			audio_play_sound(snd_impact3,0,false);
			image_index = image_number-1;
			default_stats();
			default_stats_player();
			sticky_current = sticky_max;	
			gravity_multiplier = 0.15;
			resistance_multiplier = resistance_air;
			break;
		#endregion
		
		#region ladder
		case player_state_ladder:
			break;
		#endregion
		
		#region grapple
		case player_state_grapple:
			default_stats();
			default_stats_player();
			sticky_current = sticky_max;	
			set_sprite(spr_glide,true,0);
			image_index = image_number-1;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			resistance_multiplier = resistance_air;
			chain_length = point_distance(x,y-(sprite_get_height(sprite_index)/2),grapple_hook.x,grapple_hook.y);
			max_chain_length = chain_length;
			chain_direction = point_direction(grapple_hook.x,grapple_hook.y,x,y-(sprite_get_height(sprite_index)/2));
			chain_x = x;
			chain_y = y;
			chain_angle_velocity = lengthdir_x(x_vel_current,chain_direction)*-sign(x_vel_current);
			grapple_reel_active = false;
			break;
		#endregion
		
		#region skid
		case player_state_skid:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;	
			skid_dir = x_vel_current;
			braking_multiplier = 2;
			dash_count_current = dash_count_max;
			set_sprite(spr_skid,true,0.5);			
			break;
		#endregion
		
		#region slide
		case player_state_slide:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;	
			slide_dir = sign(x_vel_current);
			braking_multiplier = 0.75;
			friction_multiplier = 0.75;
			dash_count_current = dash_count_max;
			set_sprite(spr_slide,true,0.5);
			mask_index = spr_player_mask_slide;
			break;
		#endregion
		
		#region dash
		case player_state_dash:
			default_stats();
			default_stats_player();
			gravity_multiplier = 0;
			dash_timer_current = dash_timer_max;
			global.time_dilation_target = global.time_dilation_standard;
			obj_game_manager.camera_current_x += lengthdir_x(dash_speed*5,dash_direction);
			obj_game_manager.camera_current_y += lengthdir_y(dash_speed*5,dash_direction);
			break;
		#endregion
		
		#region dash targeting
		case player_state_dash_targeting:
			default_stats();
			global.time_dilation_target = global.time_dilation_slow;
			break;
		#endregion
		
		#region push
		
		case player_state_push:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;
			walk_speed_multiplier = run_multiplier;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			set_sprite(spr_player_push,true,0.5);
			break;
		#endregion
		
		#region ledge		
		case player_state_ledge_grab:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;
			gravity_multiplier = 0.25;
			xscale = facing*0.66;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			set_sprite(spr_player_fall,true,1);
			break;		
		#endregion
		
		#region ledge		
		case player_state_ledge_climb:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;
			gravity_multiplier = 0.25;
			xscale = facing*0.66;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			set_sprite(spr_player_ledge_climb,false,0.35);
			image_index = 1;
			break;		
		#endregion
		
		#region attack1
		case player_state_attack1:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;
			gravity_multiplier = 0.25;
			xscale = facing*0.66;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			set_sprite(spr_player_punch1,true,0.5);
			break;
		#endregion
		
		#region attack2
		case player_state_attack2:
			default_stats();
			default_stats_player();
			can_jump = coyote_time_frames;
			dash_timer_current = dash_timer_max;
			sticky_current = sticky_max;
			gravity_multiplier = 0.25;
			xscale = facing*0.66;
			multijump_current = global.multijump_max;
			dash_count_current = dash_count_max;
			set_sprite(spr_player_punch2,true,0.5);
			break;
		#endregion
		
		
		#region default
		default:
			default_stats();
			break;
		#endregion

	}
	state_mask = mask_index;
	state = _state;
}

function on_ground()
{
	return (place_meeting(x,y+1,par_collider) ||(place_meeting(x,y+1,obj_horizontal_oneway) && !place_meeting(x,y,obj_horizontal_oneway)) || on_vertical);
}

function is_state()
{
	for (var i=0;i<argument_count;i++) {
		if (state = argument[i]) return true;
	}
}

function on_oneway()
{
	var _on_oneway = place_meeting(x,y+1,obj_horizontal_oneway);
	
	if !_on_oneway return noone;
	
	var _inside_oneway = place_meeting(x,y,obj_horizontal_oneway);
	
	if !_inside_oneway return _on_oneway;
	
	if _on_oneway == _inside_oneway return noone;
	
	return _on_oneway;
}

function player_input_jump()
{
	if (input_check_pressed("jump"))
		
		{
		var _plat = instance_place(x,y+2,par_collider);
		if (instance_exists(_plat))
		{
			x_vel_current += _plat.x_vel;
		}
		
		if (place_meeting(x,y+1,obj_horizontal_oneway) && !place_meeting(x,bbox_bottom+1,par_collider) && input_check("down"))
		{
			y+=2;
			set_state(player_state_air);
		}
		
		else if (can_jump > 0) { //jump and coyote jump
		y_vel_current = -jump_height_current;
		set_state(player_state_jump);
			
		} else if (place_meeting(x,y+(y_vel_current*coyote_time_frames),par_collider) && y_vel_current > 0) { //jump buffer
			jump_buffer = coyote_time_frames;
	
		} else if (multijump_current > 0) { //multijump
			if (sprite_index != spr_air_jump) {
				set_sprite(spr_air_jump,true,0.5);	
			}
			y_vel_current = -jump_height_current;
			multijump_current--;
			set_state(player_state_jump);
		} 		
	}
}

function player_jump_ground()
{
	if (jump_buffer > 0) {
		y_vel_current = -jump_height_current;
		set_state(player_state_jump);
	}
	
	jump_buffer = 0;
	can_jump = coyote_time_frames;
	multijump_current = global.multijump_max;
}

function player_input_wallcling() {
	
	if ((
	(place_meeting(bbox_right+1,bbox_bottom,par_collider) && place_meeting(bbox_right+1,bbox_top,par_collider) && input_check("right")) ||
	(place_meeting(bbox_left-1,bbox_bottom,par_collider) && place_meeting(bbox_left-1,bbox_top,par_collider) && input_check("left"))
	) && global.walljump_unlocked && !global.wallclimb_unlocked && !on_ground())
	{
		set_state(player_state_cling);
	}
}

function player_input_wallclimb()
{
	if (place_meeting(facing ? bbox_right+1 : bbox_left-1,y,par_collider) && (facing ? input_check("right") : input_check("left")) && global.wallclimb_unlocked)
	{
		set_state(player_state_wallclimb);
	}
}

function player_input_ladder()
{
	if (place_meeting(x,y,obj_ladder) && input_check("up")) {
		set_state(player_state_ladder);	
	}	
}

function player_input_glide()
{
	if (y_vel_current >= 0 && input_check("glide") && global.glider_unlocked) {
		set_state(player_state_glide);
	}
}

function player_input_grapple()
{
	if (input_check_pressed("grapple") && global.grapple_unlocked)
	{
		if (instance_exists(grapple_hook))
		{
			instance_destroy(grapple_hook,true);			
		} else
		{
			grapple_direction = aim_direction;
			grapple_hook = instance_create_depth(x,y-(sprite_get_height(sprite_index)/2),depth+1,obj_grapple_hook);
			with (grapple_hook)
			{
				rotation = other.grapple_direction;
			}
					
		}
	}
	if (instance_exists(grapple_hook) && (!input_check("grapple") || point_distance(x,y-(sprite_get_height(sprite_index)/2),grapple_hook.x,grapple_hook.y) > grapple_distance_max))
	{
		instance_destroy(grapple_hook);
	}
}

function player_input_bash()
{
	var _nearest_dash_point = instance_nearest(x,y,obj_grapple_point);
	
	if (!dash_targeting) {
		if (instance_exists(_nearest_dash_point) && point_distance(x,y, _nearest_dash_point.x, _nearest_dash_point.y) <= dash_distance_max && global.bash_unlocked && dash_count_current != 10) {
			if (input_check("grapple")) {
				dash_point = _nearest_dash_point;
				dash_targeting = true;
			}
		}
	}
	
	if (dash_targeting && instance_exists(dash_point)) {
		global.time_dilation_target = global.time_dilation_slow;
		dash_point.active = 1;
		dash_point.arrow_distance++;
		
		if (!input_check("grapple")) {
			dash_direction = point_direction(x,y,dash_point.x,dash_point.y);
			with (obj_grapple_point) {
				active = 0;
				arrow_distance = 0;
			}
			dash_count_current--;
			//dash_point = noone;
			dash_targeting = false;
			set_state(player_state_dash);
		}
	
		if (point_distance(x,y,dash_point.x,dash_point.y) > dash_distance_max) {
			with (obj_grapple_point) {
				active = 0;
				arrow_distance = 0;
			}
			global.time_dilation_target = global.time_dilation_standard;
			if (on_ground()) {
				set_state(player_state_ground);	
			} else {
				set_state(player_state_air);	
			}		
		}
	
		
	}
}

function player_target_grapple()
{
	if (input_check("grapple_reel"))
	{
		var _gp = [0,0];
		var _ax = x + lengthdir_x(90+(45*facing),grapple_distance_max);
		var _ay = y - (sprite_get_height(sprite_index)/2) + lengthdir_y(90+(45*facing),grapple_distance_max);
		if (collision_line(x, y-(sprite_get_height(sprite_index)/2), _ax, _ay, par_collider, false, false))
		{
			_gp = raycast(x, y - (sprite_get_height(sprite_index)/2), _ax, _ay, par_collider); 
		}
		if (is_array[_gp])
		{
			draw_crosshair = true;
			crosshair_angle++;
			crosshair_size = abs((sin(crosshair_angle*0.05)))+0.5;
			crosshair_x = _gp[0];
			crosshair_y = _gp[1];
		}
	}
	
	
	if (draw_crosshair && !input_check("grapple_reel") && !instance_exists(grapple_hook))
	{
		grapple_direction = point_direction(x,y-(sprite_get_height(sprite_index)/2),crosshair_x,crosshair_y);
		grapple_hook = instance_create_depth(x,y-(sprite_get_height(sprite_index)/2),depth+1,obj_grapple_hook);
		with (grapple_hook)
		{
			rotation = other.grapple_direction;
		}
		draw_crosshair = false;
	}
}

function player_input_ledge_grab()
{
	if ((
	(place_meeting(bbox_right+1,bbox_bottom,par_collider) && !place_meeting(bbox_right+1,bbox_top,par_collider) && input_check("right")) ||
	(place_meeting(bbox_left-1,bbox_bottom,par_collider) && !place_meeting(bbox_left-1,bbox_top,par_collider) && input_check("left"))) &&
	!on_ground() && global.walljump_unlocked && !global.wallclimb_unlocked)
	{
		set_state(player_state_ledge_grab);
	}
}