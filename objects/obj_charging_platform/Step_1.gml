switch (state) {
	case "idle":
		if (place_meeting(x+1,y-1,obj_player))
		{
			state = "charging";
		}
		break;
		
	case "charging":
		charge_current++;
		if (charge_current >= charge_max) 
		{
			state = "charge";
		}
		break;
	
	case "charge":
		var _vx = lengthdir_x(vel_charge,image_angle);
		var _vy = lengthdir_y(vel_charge,image_angle);
		x_vel = approach(x_vel,_vx,acceleration);
		y_vel = approach(y_vel,_vy,acceleration);
		x += x_vel*global.time_dilation_current;
		y += y_vel*global.time_dilation_current;
		charge_current = approach(charge_current,0,2);
		if (place_meeting(x+x_vel,y+y_vel,[obj_wall,obj_platform_stop]))
		{
			if (place_meeting(x,y-1,obj_player))
			{
				obj_player.x_vel_current += x_vel;
				obj_player.y_vel_current += y_vel-4;
			}
			x_vel = 0;
			y_vel = 0;
			state = "retreat";
		}
		break;
		
	case "retreat":
		var _dir = point_direction(x,y,start_x,start_y);
		var _rx = lengthdir_x(vel_retreat,_dir);
		var _ry = lengthdir_y(vel_retreat,_dir);
		var _dist = point_distance(x,y,start_x,start_y);
		x_vel = approach(x_vel,_rx,acceleration);
		y_vel = approach(y_vel,_ry,acceleration);
		x = approach(x,start_x,-x_vel*global.time_dilation_current);
		y = approach(y,start_y,y_vel*global.time_dilation_current);
		if (_dist <= 0)
		{
			x_vel = 0;
			y_vel = 0;
			state = "idle";
		}
		break;
}

/// @description Insert description here
if (instance_exists(obj_player)) {
	if (place_meeting(x,y-1,obj_player)) {
		with (obj_player) {
			if (place_meeting(x, y + 1, other) && !place_meeting(x, y, other)) {
				x += other.x_vel*global.time_dilation_current;
			}
		
			if(place_meeting(x, y + abs(other.y_vel), other) && !place_meeting(x,y+other.y_vel,obj_wall)) {
				y += other.y_vel*global.time_dilation_current;
			}
		}
	}
}