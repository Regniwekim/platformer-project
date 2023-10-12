// set threshold based on speed
// walking into a wall or upward _slope
function entity_collision() {
	repeat(abs(x_vel_current)) {
		if (!place_meeting(x+sign(x_vel_current),y,par_solid)) {
			x += sign(x_vel_current);	
		} else {
			x_vel_current = 0;
			y_vel_current = 0;
		}
	}
	
	repeat(abs(y_vel_current)) {
		if (!place_meeting(x,y+sign(y_vel_current),par_solid)) {
			y += sign(y_vel_current);	
		} else {
			x_vel_current = 0;
			y_vel_current = 0;
		}
	}
	/*
	if (place_meeting(x + x_vel_current, y, par_solid)) {
		while (!place_meeting(x + sign(x_vel_current), y, par_solid)) {
		    x += sign(x_vel_current);
		}
		x_vel_current = 0;
		y_vel_current = 0;
	}
	
	x += x_vel_current*global.time_dilation_current;

	if (place_meeting(x, y + y_vel_current, par_solid)) {
		while (!place_meeting(x, y + sign(y_vel_current), par_solid)) {
		        y += sign(y_vel_current);
		}
		x_vel_current = 0;
		y_vel_current = 0;
	}

	y += y_vel_current*global.time_dilation_current;
	*/
}