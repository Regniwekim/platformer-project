/// @description Insert description here
// You can write your code in this editor

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_stroke(camera_current_x + (global.view_width/2),camera_current_y + (global.view_height/2),"X");
draw_text_stroke(camera_current_x,camera_current_y + (global.view_height/2),"X");
draw_text_stroke(camera_current_x + global.view_width,camera_current_y + (global.view_height/2),"X");

draw_text_stroke(camera_target_x + (global.view_width/2),camera_target_y + (global.view_height/2),"T");










