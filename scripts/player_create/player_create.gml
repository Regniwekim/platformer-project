function player_create() {
spr_idle = spr_player_idle;
spr_jump = spr_player_jump;
spr_fall = spr_player_fall;
spr_ladder = spr_player_jump;
spr_slide = spr_player_slide;
spr_walk = spr_player_walk;
spr_land = spr_player_land;
spr_wall_slide = spr_player_wall_slide;
spr_wall_land = spr_player_wall_land;

active = true;

xinput = 0;
yinput = 0;

air_resistance = 0.75;
water_resistance = 0.5;	

walk_speed_standard = 5;
walk_speed_multiplier = 1;
run_multiplier = 1.5;
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
sticky_current = 4;
sticky_max = sticky_current;

climb_speed = 0;

facing = 1;
mask_index = spr_player_mask;
radius = sprite_get_width(mask_index)/2;
slope = 0;
slide_dir = 0;

can_wall_jump = 1;
wall_dir = facing;

echo_x = x;
echo_y = y;
echo_sprite = sprite_index;
echo_frame = image_index;
echo_facing = facing;

state = player_state_ground;
state_previous = state;
}