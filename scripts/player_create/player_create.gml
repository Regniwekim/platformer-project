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
spr_roll = spr_player_roll;
spr_wall_slide = spr_player_wall_slide;
spr_wall_land = spr_player_wall_land;
spr_wall_climb = spr_player_wall_climb;
spr_crouch_idle = spr_player_crouch_idle;
spr_crouch_walk = spr_player_crouch_walk;

//number of pixels covered per step divided by the number of frames per step = pixels moved per frame at image_speed = 1
step_size = (sprite_get_width(sprite_index)/image_number)*2;

active = true;

xinput = 0;
yinput = 0;
aim_direction = 0;

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

friction_multiplier = 1;
gravity_multiplier = 1;

braking_standard = 1; //0.5
braking_multiplier = 1;
braking_current = braking_standard*braking_multiplier;

jump_height_standard = 8;
jump_height_multiplier = 1;
jump_height_current = jump_height_standard*jump_height_multiplier;

resistance_ground = 1;
resistance_standard = resistance_ground;
resistance_air = 0.5;
resistance_water = 0.5;
resistance_ground = 1;
resistance_multiplier = 1;
resistance_current = resistance_ground*resistance_multiplier;

x_vel_current = 0;
y_vel_current = 0;
x_vel_max = 6; //16
y_vel_max = 10; //16

jump_height_standard = 8;
jump_height_multiplier = 1;
jump_height_current = jump_height_standard*jump_height_multiplier;
can_jump = coyote_time_frames;
jump_buffer = 0;
multijump_current = 0;

sticky_current = 4;
sticky_max = sticky_current;

climb_speed = 0;

facing = 1;
mask_index = spr_player_mask;
radius = sprite_get_width(mask_index)/2;
slope = 0;
slide_dir = 0;
oneway = 0;

wall_dir = facing;

echo_x = x;
echo_y = y;
echo_sprite = sprite_index;
echo_frame = image_index;
echo_facing = facing;

xscale = image_xscale;

grapple_hook = noone;
grapple_point = noone;
grapple_direction = 0;
grapple_distance_max = 320;
chain_length = 0;
max_chain_length = 0;
chain_direction = 0;
chain_angle_velocity = 0;
chain_x = x;
chain_y = y;
grapple_reel_active = false;

dash_timer_max = 6;
dash_timer_current = dash_timer_max;
dash_count_max = 1;
dash_count_current = dash_count_max;
dash_distance_max = 120;
dash_targeting = false;
dash_point = noone;
dash_speed = 15;

climbing_speed = 4;

can_walk = true;

state = player_state_ground;
state_previous = state;

}