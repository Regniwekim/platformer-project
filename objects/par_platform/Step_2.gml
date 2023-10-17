/// @description Insert description here
if (instance_exists(obj_player)) {
	if (place_meeting(x,y-1,obj_player)) {
		with (obj_player) {
			if (place_meeting(x, y + 1, other) && !place_meeting(x, y, other) && !place_meeting(x+other.x_vel,y,obj_wall)) {
				x += other.x_vel*global.time_dilation_current;
			}
		
			if(place_meeting(x, y + abs(other.y_vel), other) && !place_meeting(x, y, other) && !place_meeting(x,y+other.y_vel,obj_wall)) {
				y += other.y_vel*global.time_dilation_current;
			}
		}
	}
}

if (place_meeting(x + x_vel, y, obj_platform_stop) || place_meeting(x + x_vel, y, obj_wall)) x_vel *= -1;

if (place_meeting(x, y + y_vel, obj_platform_stop) || place_meeting(x, y + y_vel, obj_wall)) {
	if (instance_exists(obj_player) && place_meeting(x,y-1,obj_player)) {
		obj_player.y -= sign(y_vel)*2;
	}
	y_vel *= -1;
}

x += x_vel*global.time_dilation_current;
y += y_vel*global.time_dilation_current;