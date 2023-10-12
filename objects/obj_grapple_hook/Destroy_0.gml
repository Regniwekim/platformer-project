/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_player)) {
	with (obj_player) {
		if (on_ground()) {
			set_state(player_state_ground);	
		} else {
			set_state(player_state_air);	
		}
	}
}








