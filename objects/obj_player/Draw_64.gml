/// @description Insert description here
// You can write your code in this editor

if (global.debug)
{
	draw_set_halign(fa_left);

	draw_text_stroke(8,8,"state: " + script_get_name(state));

	draw_text_stroke(8,32,"sprite: " + string(sprite_get_name(sprite_index)));

	draw_text_stroke(8,56,string("mask: " + sprite_get_name(mask_index)));
	
	draw_text_stroke(8,80,string("wall dir: " + string(wall_dir)));
}