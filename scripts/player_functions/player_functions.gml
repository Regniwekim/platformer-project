// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function entity_collision(){
	// set threshold based on speed
	var _tolerance = 1 +  ceil(abs(x_vel_current));
	// walking into a wall or upward _slope
	if (place_meeting(x + x_vel_current, y, par_solid)) {
	     var _slope = false;
	     // moving up slopes
	    for (var i = 1; i <= _tolerance; i++) {
	         if (!place_meeting(x + x_vel_current, y - i, par_solid)) {
	               _slope = true;
	               y -= i;
	               break;
	         }
	    }

	    // not a _slope? then it’s a wall
	    if (!_slope) {
	         while (!place_meeting(x + sign(x_vel_current), y, par_solid)) {
	         x += sign(x_vel_current);
	        }
	        x_vel_current = 0;
	    }
	}

	// nothing ahead? check for downward slopes!
	else if (on_ground()) {
	     // moving down slopes
	    for (var i = 0; i <= _tolerance; i++) {
	         if (!place_meeting(x + x_vel_current, y + i + 1, par_solid)) {
	               y += i;
	               break;
	         }
	    }
	}
	
	x += x_vel_current;

	// note that vertical code has NO _slope logic
	if (place_meeting(x, y + y_vel_current, par_solid)) {
	    while (!place_meeting(x, y + sign(y_vel_current), par_solid)) {
	         y += sign(y_vel_current);
	    }
	    y_vel_current = 0;
	}


	//one way platform collisions
	if (place_meeting(x, y + y_vel_current, obj_oneway) && y_vel_current > 0 && !place_meeting(x,y,obj_oneway)) {
		while (!place_meeting(x, y + 1,obj_oneway)) {
			y++;
		}
		y_vel_current = 0;		
	}	
	y += y_vel_current;
}

function horizontal_movement() {
	x_vel_current = approach(x_vel_current,walk_speed_current*xinput*resistance_current*run_multiplier_current*crouch_multiplier_current,acceleration_current*braking_current*resistance_current*friction_current);
}

function set_state(_state) {
	//execute state leave
	//state enter script 
	if (state != _state) {
		state_previous = state;
		state = _state;
	}
}

function on_ground() {
	return (place_meeting(x,y+1,par_solid) || (place_meeting(x,y+1,obj_oneway) && !place_meeting(x,y,obj_oneway)));
}

function is_state() {
	for (var i=0;i<argument_count;i++) {
		if (state = argument[i]) return true;
	}
}

function on_oneway() {
	var _on_oneway = place_meeting(x,y+1,obj_oneway);
	
	if !_on_oneway return noone;
	
	var _inside_oneway = place_meeting(x,y,obj_oneway);
	
	if !_inside_oneway return _on_oneway;
	
	if _on_oneway == _inside_oneway return noone;
	
	return _on_oneway;
}