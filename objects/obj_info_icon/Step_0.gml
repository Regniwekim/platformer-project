if (instance_exists(obj_player) && point_distance(x,y,obj_player.x,obj_player.y) < global.view_height/3) {
	active = true;	
} else active = false;

if (active) {
switch (draw_direction) {
	case 0:
	halign = (fa_left);
	valign = (fa_middle);
	xx = bbox_right + TILE_SIZE;
	yy = bbox_top + (sprite_get_height(sprite_index)/2);
	break;
		
	case 1:
	halign = (fa_center);
	valign = (fa_bottom);
	xx = bbox_left + (sprite_get_width(sprite_index)/2);
	yy = bbox_top - TILE_SIZE;
	break;
		
	case 2:
	halign = (fa_right);
	valign = (fa_middle);
	xx = bbox_left - TILE_SIZE;
	yy = bbox_top + (sprite_get_height(sprite_index)/2);
	break;
		
	case 3:
	halign = (fa_center);
	valign = (fa_top);
	xx = bbox_left + (sprite_get_width(sprite_index)/2);
	yy = bbox_bottom + TILE_SIZE;
	break;
		
	default:
	halign = (fa_left);
	valign = (fa_middle);
	xx = x + TILE_SIZE;
	yy = bbox_top + (sprite_get_height(sprite_index)/2);
	break;
}
my_input_icon =  input_binding_get_icon(input_binding_get(my_input));
}