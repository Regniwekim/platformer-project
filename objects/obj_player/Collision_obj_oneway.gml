/// @description Insert description here
// You can write your code in this editor

if (y_vel_current > 0) {
	if (!place_meeting(x,y-y_vel_current,other.id)) {
		y_vel_current = 0;
		y += other.bbox_top - bbox_bottom;
	}
}



