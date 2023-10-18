/// @description Insert description here
// You can write your code in this editor

switch (active_state)
{
	case actor_state_ground:
		my_state_ground();
		break;
		
	case actor_state_air:
		my_state_air();
		break;
		
	default:
		//do nothing
		break;

}