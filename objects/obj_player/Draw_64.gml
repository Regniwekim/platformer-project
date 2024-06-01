/// @description
if (global.debug)
{
	draw_set_halign(fa_left);

	var _n = 24;
	draw_text_stroke(8,_n,"state: " + script_get_name(state)); _n+=24;

	draw_text_stroke(8,_n,"sprite: " + string(sprite_get_name(sprite_index))); _n+=24;

	draw_text_stroke(8,_n,string("mask: " + sprite_get_name(mask_index))); _n+=24;
	
	draw_text_stroke(8,_n,string("wall dir: " + string(wall_dir))); _n+=24;
}