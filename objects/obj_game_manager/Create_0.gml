/// @description Insert description here
// You can write your code in this editor

#region player power unlocks
global.multijump_max = 0;
global.walljump_unlocked = 0;
global.wallclimb_unlocked = 0;
global.dash_unlocked = 0;
global.bash_unlocked = 0;
global.glider_unlocked = 0;
global.grapple_unlocked = 0;
global.slowmo_unlocked = 0;
#endregion

#region time control
global.time_dilation_standard = 1;
global.time_dilation_slow = 0.1;
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

#region particles
global.bg_particle_system = part_system_create_layer("lay_bg_particles",true);
global.mg_particle_system = part_system_create_layer("lay_mg_particles",true);
global.fg_particle_system = part_system_create_layer("lay_fg_particles",true);
#endregion

#region controller icons
global.jump_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("jump")));
global.grapple_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("grapple")));
global.grapple_reel_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("grapple_reel")));
global.glide_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("glide")));
global.run_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("run")));
global.up_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("up")));
global.down_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("down")));
global.left_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("left")));
global.right_icon =  sprite_get_name(input_binding_get_icon(input_binding_get("right")));

global.jump_tutorial_text = $"Press [{global.jump_icon}] to jump";
global.oneway_tutorial_text = $"Hold [{global.down_icon}] and press [{global.jump_icon}] to drop down";
global.run_tutorial_text = $"Hold [{global.run_icon}] to jump";
global.glider_tutorial_text = $"Hold [{global.glide_icon}] to deploy your glider";
global.walljump_tutorial_text = $"Press [{global.jump_icon}] to jump off walls";
global.grapple_hook_tutorial_text = $"Press [{global.grapple_icon}] to deply your grappling hook to the nearest [spr_grapple_point]\n Hold [{global.grapple_reel_icon}] to reel yourself in"

#endregion

room_goto(rm_demo);

global.debug = false;