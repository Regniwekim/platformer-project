/// @description Insert description here
// You can write your code in this editor



if (active == 1) {
	draw_set_color(c_fuchsia);
	draw_circle(x,y,sprite_get_width(sprite_index),true);
	
	draw_line_width(x+lengthdir_x(-arrow_distance/3,arrow_direction),
			  y+lengthdir_y(-arrow_distance/3,arrow_direction),
			  x+lengthdir_x(arrow_distance,arrow_direction),
			  y+lengthdir_y(arrow_distance,arrow_direction),2);
}

draw_self();