x += x_vel;
y += y_vel;

if (instance_exists(obj_player))
{
	if (place_meeting(x,y-1,obj_player))
	{
		obj_player.x_vel_current += x_vel;
		obj_player.y_vel_current += y_vel;
	}
}