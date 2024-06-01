/// @description
draw_sprite_ext(sprite_index,image_index,x,y,xscale,yscale,image_angle,image_blend,image_alpha);

if (global.debug)
{
	draw_sprite_ext(mask_index,image_index,x,y,1,1,0,c_white,0.4);

	draw_set_color(c_lime);
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true);

	draw_set_color(c_red);
	draw_line(x-4,bbox_bottom-sprite_get_height(spr_player_mask_stand),x+4,bbox_bottom-sprite_get_height(spr_player_mask_stand));
}

draw_set_color(c_lime);
draw_circle(input_cursor_x(),input_cursor_y(),8,true);

if (state = player_state_glide) {
	var _h = sprite_get_height(sprite_index);
	draw_sprite(spr_glider,0,x,y-_h);
}

if (draw_crosshair)
{
	draw_sprite_ext(spr_crosshair,0,crosshair_x,crosshair_y,crosshair_size,crosshair_size,crosshair_angle,image_blend,image_alpha);	
}

draw_set_colour(c_white);