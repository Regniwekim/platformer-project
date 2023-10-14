draw_self();




if (active) {
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_font(fnt_monogram);
	draw_text_scribble(xx,yy,$"{my_press} [{sprite_get_name(my_input_icon)}] to {my_action}");
}