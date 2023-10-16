/// @description Insert description here
// You can write your code in this editor
pt = part_type_create();

// set default emitter
pe = part_emitter_create(global.mg_particle_system);
switch (image_angle)
{
	case 0:
		part_emitter_region(global.mg_particle_system, pe, bbox_left, bbox_left + (TILE_SIZE*thrust), bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_linear);
		break;
		
	case 90:
		part_emitter_region(global.mg_particle_system, pe, bbox_left, bbox_right, bbox_bottom - (TILE_SIZE*thrust), bbox_bottom, ps_shape_rectangle, ps_distr_linear);
		break;
		
	case 180:
		part_emitter_region(global.mg_particle_system, pe, bbox_right - (TILE_SIZE*thrust), bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_linear);
		break;
		
	case 270:
		part_emitter_region(global.mg_particle_system, pe, bbox_left, bbox_right, bbox_top, bbox_top  + (TILE_SIZE*thrust), ps_shape_rectangle, ps_distr_linear);
		break;
		
	default:
		part_emitter_region(global.mg_particle_system, pe, bbox_left, bbox_left + (TILE_SIZE*thrust), bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_linear);
		break;
}

// setup a default particle
part_type_blend(pt, 1);
part_type_shape(pt, pt_shape_line);
part_type_size(pt, 0.2, 0.6, -0.001, 0);
part_type_scale(pt, 0.05, 1.2);
part_type_color3(pt, make_color_rgb(255.00, 255, 255.00), make_color_rgb(189.43, 173.16, 196.25), make_color_rgb(137.30, 125.85, 203.75));
part_type_alpha3(pt, 0.75, 0.05, 0.2);
part_type_life(pt, 30, 120);
part_type_orientation(pt, image_angle+89, image_angle+91, 0, 0, false);
part_type_speed(pt, 0.4*(4/thrust), 3*(4/thrust), 0, 0);
part_type_direction(pt, image_angle-2.5, image_angle+2.5, 0, 0);
part_type_gravity(pt, 0, 0);


part_emitter_stream(global.mg_particle_system, pe, pt, 1); // where 1 is the number of particles