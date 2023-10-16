/// @description Insert description here
// You can write your code in this editor

ps = part_system_create_layer("lay_bg_decoration",false);
pt = part_type_create();

// set default emitter
pe = part_emitter_create(ps);
part_emitter_region(ps, pe, bbox_left, bbox_right, bbox_bottom, bbox_bottom, ps_shape_line, ps_distr_linear);

// setup a default particle
part_type_blend(pt, 0);
part_type_sprite(pt, spr_lava_bubble, 0, 0, 0);
part_type_size(pt, 0.25, 1, 0, random(0.05));
part_type_scale(pt, 1, 1);
part_type_color3(pt, make_color_rgb(221.45, 107.34, 17.26), make_color_rgb(255, 172.50, 0), make_color_rgb(255, 233.82, 75.00));
part_type_alpha3(pt, 1, 0.5, .25);
part_type_life(pt, image_yscale*20, image_yscale*25);
//part_type_orientation(pt, 0, 359, 0, 1.85, false);
part_type_speed(pt, 0.33, 0.75, 0, 0.1);
part_type_direction(pt, 88, 92, 0, 0.1);
part_type_gravity(pt, 0, 0);


part_emitter_stream(ps, pe, pt, image_xscale/10); // where 1 is the number of particles












