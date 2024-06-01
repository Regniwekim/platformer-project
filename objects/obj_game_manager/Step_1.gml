/// @description Insert description here
// You can write your code in this editor

#region time control
global.time_dilation_current = lerp(global.time_dilation_current,global.time_dilation_target,0.1);//approach(global.time_dilation_current,global.time_dilation_target,max(0.05,abs(global.time_dilation_current-global.time_dilation_target)/5));
#endregion

#region camera control

if (instance_exists(obj_player))
{
	if (!instance_exists(global.camera_follow)) {
		global.camera_follow = obj_player;
	}
	else if global.camera_follow != obj_player &&
	rectangle_in_rectangle(obj_player.bbox_left,obj_player.bbox_top,obj_player.bbox_right,obj_player.bbox_bottom,
	global.camera_follow.bbox_left-2,global.camera_follow.bbox_top-2,global.camera_follow.bbox_right+2,global.camera_follow.bbox_bottom+2) != 1 {
		global.camera_follow = obj_player;
	}
}

global.screen_shake = approach(global.screen_shake,0,max(0.05,global.screen_shake/10));

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

with (obj_info_icon) {
	switch (my_action) {
		case "jump":
			my_string = global.jump_tutorial_text;
			break;
		case "oneway":
			my_string = global.oneway_tutorial_text;
			break;
		case "run":
			my_string = global.run_tutorial_text;
			break;
		case "glide":
			my_string = global.glider_tutorial_text;
			break;
		case "walljump":
			my_string = global.walljump_tutorial_text;
			break;
		case "grapple":
			my_string = global.grapple_hook_tutorial_text;
			break;
		default:
			my_string = "";
			break;
	}
}

#endregion

if keyboard_check_pressed(ord("P"))
{
    global.debug = !global.debug;
    show_debug_overlay(global.debug);
}

if keyboard_check_pressed(ord("O"))
{
	global.screen_shake = random_range(4,10);
}