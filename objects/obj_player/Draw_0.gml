/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(sprite_index,image_index,x,y,xscale,image_yscale,image_angle,image_blend,image_alpha);

//draw_sprite_ext(mask_index,image_index,x,y,1,1,0,c_white,0.4);


draw_set_color(c_lime);
//draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true);

if (state = player_state_glide) {
	var _h = sprite_get_height(sprite_index);
	draw_sprite(spr_glider,0,x,y-_h);
}


//Choose a nice clear colour for the aiming reticule
draw_set_colour(c_fuchsia);

if (input_source_using(INPUT_GAMEPAD))
{
    //If we're using a gamepad, draw the reticule a fixed distance away from the player
    //This feels a bit nicer than following the cursor exactly
    draw_circle(x + lengthdir_x(130, aim_direction), y + lengthdir_y(130, aim_direction), 6, true);
}
else
{
    //When aiming using the mouse then we'll draw the reticule exactly on the cursor
    draw_circle(input_cursor_x(), input_cursor_y(), 6, true);
}

draw_set_colour(c_white);