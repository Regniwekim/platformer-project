/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_player)) {
	draw_chain = true;
	chain_length = point_distance(x,y,obj_player.x,obj_player.y-(sprite_get_height(obj_player.sprite_index)/2));
	chain_links = ceil(chain_length/link_size);
	chain_direction = point_direction(x,y,obj_player.x,obj_player.y-(sprite_get_height(obj_player.sprite_index)/2));
} else {
	draw_chain = false;
	chain_length = 0;
	chain_links = 0;
	chain_direction = 0;
}

repeat(abs(vel)) {
	var _xv = lengthdir_x(1,rotation);
	var _yv = lengthdir_y(1,rotation);
	if (!place_meeting(x+_xv,y+_yv,par_platform)) {
		x += _xv;
		y += _yv;
	} else {
		x_vel_current = 0;
		y_vel_current = 0;
		if (instance_exists(obj_player)) {
			with (obj_player) {
				set_state(player_state_grapple);
			}
		}
	}
}

if (collision_circle(x,y,4,par_platform,false,false)) {
	var _oneway = collision_circle(x,y,4,par_platform,false,false);
	x += _oneway.x_vel;
	y += _oneway.y_vel;
}

/*
var _vel = point_distance(0,0,hsp,vsp);
repeat(abs(_vel))
{
	var _xv = lengthdir_x(1,yoyo_direction);
	var _yv = lengthdir_y(1,ryoyo_direction);
	if (!place_meeting(x+_xv,y+_yv,oGroundTile))
	{
		x += _xv;
		y += _yv;
	} else
	{
		x_vel_current = 0;
		y_vel_current = 0;

	}
}