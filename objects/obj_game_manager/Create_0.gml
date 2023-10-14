/// @description Insert description here
// You can write your code in this editor

#region player power unlocks
global.multijump_max = 0;
global.walljump_unlocked = 0;
global.dash_unlocked = 0;
global.bash_unlocked = 0;
global.glider_unlocked = 0;
global.grapple_unlocked = 0;
global.slowmo_unlocked = 0;
#endregion

#region time control
global.time_dilation_standard = 1;
global.time_dilation_slow = 0.2;
global.time_dilation_target = global.time_dilation_standard;
global.time_dilation_current = global.time_dilation_standard;
#endregion

#region Camera stuff

global.view_width = 1920/3;
global.view_height = 1080/3;
window_scale = 2;

camera_target_x = 0;
camera_current_x = camera_get_view_x(view);
camera_target_y = 0;
camera_current_y = camera_get_view_y(view);
camera_speed = 0.2;

global.camera_follow = 0;
global.screen_shake = 0;

camera_set_view_pos(view,camera_target_x,camera_target_y);

window_set_size(global.view_width*window_scale,global.view_height*window_scale);
alarm[0] = 1;

surface_resize(application_surface,global.view_width*window_scale,global.view_height*window_scale);

camera_initialized = false;

#endregion

room_goto(rm_demo);

camy = noone;