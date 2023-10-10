function player_create() {
spr_idle = spr_player_idle;
spr_jump = spr_player_jump;
spr_fall = spr_player_fall;
spr_air_jump = spr_player_air_jump;
spr_glide = spr_player_air_jump;
spr_ladder = spr_player_jump;
spr_slide = spr_player_slide;
spr_skid = spr_player_skid;
spr_walk = spr_player_walk;
spr_run = spr_player_run;
spr_land = spr_player_land;
spr_wall_slide = spr_player_wall_slide;
spr_wall_land = spr_player_wall_land;
spr_crouch = spr_player_crouch_idle;
spr_crouch_walk = spr_player_crouch_walk;

//number of pixels covered per step divided by the number of frames per step = pixels moved per frame at image_speed = 1
crouch_step_size = 19/6;
run_step_size = 18/2;
walk_step_size = 13/5;
step_size = sprite_get_width(sprite_index)/image_number;

active = true;

xinput = 0;
yinput = 0;

air_resistance = 0.75;
water_resistance = 0.5;	

walk_speed_standard = 2;
walk_speed_multiplier = 1;
run_multiplier = 3;
run_multiplier_current = 1;
crouch_multiplier = 0.33;
crouch_multiplier_current = 1;
walk_speed_current = walk_speed_standard*walk_speed_multiplier;

acceleration_standard = 0.2; //0.046875????
acceleration_multiplier = 1;
acceleration_current = acceleration_standard*acceleration_multiplier

braking_standard = 1; //0.5
braking_multiplier = 1;
braking_current = braking_standard*braking_multiplier;

jump_height_standard = 8;
jump_height_multiplier = 1;
jump_height_current = jump_height_standard*jump_height_multiplier;

friction_stadard = 1; //0.046875
friction_multiplier = 1;
friction_current = friction_stadard*friction_multiplier;

gravity_standard = 0.5;
gravity_multiplier = 1;
gravity_current = gravity_standard * gravity_multiplier;

resistance_standard = 1;
resistance_air = 0.5;
resistance_water = 0.5;
resistance_ground = 1;
resistance_multiplier = 1;
resistance_current = resistance_standard*resistance_multiplier;

x_vel_current = 0;
y_vel_current = 0;
x_vel_max = 6; //16
y_vel_max = 10; //16

jump_height_standard = 8;
jump_height_multiplier = 1;
jump_height_current = jump_height_standard*jump_height_multiplier;
coyote_time = 6;
can_jump = coyote_time;
jump_buffer = 0;
multijump_current = 0;
multijump_max = 0;

walljump_unlocked = 0;
dash_unlocked = 0;
glider_unlocked = 0;
grapple_hook_unlocked = 0;

sticky_current = 4;
sticky_max = sticky_current;

climb_speed = 0;

facing = 1;
mask_index = spr_player_mask;
radius = sprite_get_width(mask_index)/2;
slope = 0;
slide_dir = 0;
oneway = 0;

can_wall_jump = 1;
wall_dir = facing;

echo_x = x;
echo_y = y;
echo_sprite = sprite_index;
echo_frame = image_index;
echo_facing = facing;

state = player_state_ground;
state_previous = state;

view_width = 1920/3;
view_height = 1080/3;

global.camera = instance_create_layer(x,y,"lay_entities",obj_camera,
{
	view_width : 1920/3,
	view_height : 1080/3,
	target_x : clamp(x - (other.view_width/2) + (x_vel_current*3) + (facing*32) ,0,room_width-other.view_width),
	current_x : camera_get_view_x(view),
	target_y : clamp(y - (other.view_height/2),0,room_height-other.view_height),
	current_y : camera_get_view_y(view),
	camera_speed : 0.1
});

with (global.camera) {
	camera_set_view_pos(view,target_x,target_y);
}

}