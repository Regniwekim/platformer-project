/// @description Insert description here
// You can write your code in this editor

ps = part_system_create();
part_system_depth(ps,depth+1);
pt = part_type_create();

// set default emitter
pe = part_emitter_create(ps);
part_emitter_region(ps, pe, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_gaussian);

// setup a default particle
part_type_blend(pt, 1);
part_type_shape(pt, pt_shape_line);
part_type_size(pt, 0.2, 0.6, -0.001, 0);
part_type_scale(pt, 0.05, 1.2);
part_type_color3(pt, make_color_rgb(255.00, 255, 255.00), make_color_rgb(189.43, 173.16, 196.25), make_color_rgb(137.30, 125.85, 203.75));
part_type_alpha3(pt, 0.75, 0.05, 0.2);
part_type_life(pt, 30, 120);
part_type_orientation(pt, image_angle-1, image_angle+1, 0, 0, false);
part_type_speed(pt, 0.4, 3, 0, 0);
part_type_direction(pt, image_angle+87.5, image_angle+92.5, 0, 0);
part_type_gravity(pt, 0, 0);


part_emitter_stream(ps, pe, pt, 1); // where 1 is the number of particles

var _fan_zone = instance_create_depth(x,y,depth+1,obj_fan_zone,
{
	image_angle : image_angle,
	image_yscale : (y_thrust != 0 ? y_thrust * 4 : -x_thrust * 4),
	x_thrust : x_thrust,
	y_thrust : y_thrust
});