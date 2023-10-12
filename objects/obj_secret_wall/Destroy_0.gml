/// @description Insert description here
// You can write your code in this editor

for (var i=floor(bbox_left/TILE_SIZE);i<ceil(bbox_right/TILE_SIZE);i++) {
	for (var j=floor(bbox_top/TILE_SIZE);j<ceil(bbox_bottom/TILE_SIZE);j++) {
		tilemap_autotile(layer_tilemap_get_id("lay_tiles"),i,j,false);	
	}
}