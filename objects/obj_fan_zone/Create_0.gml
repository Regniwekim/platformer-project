/// @description Insert description here
// You can write your code in this editor


global.ps = part_system_create_layer("lay_particles",false);
part_system_automatic_draw(global.ps, true);
part_system_draw_order(global.ps, true);

var _ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_line);
part_type_size(_ptype1, 0.05, 0.2, 0, 0.05);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 2, 6, 0, 0);
part_type_direction(_ptype1, 85, 95, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 90, 90, 0, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 10, 30);

var _pemit1 = part_emitter_create(global.ps);
part_emitter_relative(global.ps,_pemit1,true);
part_emitter_region(global.ps, _pemit1, x, x+48, y, y+320, ps_shape_rectangle, ps_distr_gaussian);
part_emitter_stream(global.ps, _pemit1, _ptype1, 20);

part_system_position(global.ps, x, y);