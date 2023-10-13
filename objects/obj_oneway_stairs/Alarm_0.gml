/// @description Insert description here
// You can write your code in this editor

if (image_xscale >= 1 ?
(place_meeting(bbox_left - 1, bbox_bottom + 1, obj_oneway_stairs)) :
(place_meeting(bbox_right + 1, bbox_bottom + 1, obj_oneway_stairs))) {
	if (image_xscale >= 1 ?
	(place_meeting(bbox_right + 1, bbox_top - 1, obj_oneway_stairs)) :
	(place_meeting(bbox_left - 1, bbox_top - 1, obj_oneway_stairs))) {
		image_index = 0;	
	} else {
		image_index = 1;
		draw_corner = true;
	}
} else {
	image_index = 2;
	draw_corner = true;
}