/// @description Insert description here
// You can write your code in this editor

draw_set_halign(fa_left);
draw_set_valign(fa_top);
if (instance_exists(camy)) {
	draw_text_stroke(8,8,string(camy.bbox_top) + " , " + string(camy.bbox_bottom));
}
