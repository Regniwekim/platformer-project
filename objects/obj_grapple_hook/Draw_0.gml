/// @description Insert description here
// You can write your code in this editor

for (var i=0;i<chain_links;i++) {
	draw_sprite_ext(spr_grapple_chain,0,
	x+lengthdir_x(i*link_size,chain_direction),
	y+lengthdir_y(i*link_size,chain_direction),
	1,1,chain_direction,c_white,1)
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);