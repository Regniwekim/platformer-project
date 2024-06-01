player_create();

bounce = 0;

state = player_state_ground;

global.camera_follow = obj_player;

collision_list = ds_list_create();
on_vertical = 0;
on_horizontal = 0;