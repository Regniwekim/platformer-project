draw_self();




if (active) {
	draw_set_halign(halign);
	draw_set_valign(valign);
	draw_set_font(fnt_monogram);
	var _text =  $"{my_press} {my_input_icon} to {my_action}";
	draw_text(xx,yy,_text);
}