/// @description Insert description here
if (instance_exists(obj_player)) {
	with (obj_player) {
		if (place_meeting(x, y + 1, other) && !place_meeting(x, y, other) && !place_meeting(x+other.x_vel,y,par_solid)) {
			x += other.x_vel;
		}
		
		if(place_meeting(x, y + abs(other.y_vel), other) && !place_meeting(x, y, other) && !place_meeting(x,y+other.y_vel,par_solid)) {
			y += other.y_vel;
		}
	}
}


if (place_meeting(x + x_vel, y, obj_platform_stop) || place_meeting(x + x_vel, y, par_solid)) x_vel *= -1;

if (place_meeting(x, y + y_vel, obj_platform_stop) || place_meeting(x, y + y_vel, par_solid)) {
	if (instance_exists(obj_player)) {
		obj_player.y -= sign(y_vel)*2;	
	}
	y_vel *= -1;
}
x += x_vel;
y += y_vel;