// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function approach(start, end, shift);
/// @param {real} _start the starting value
/// @param {real} _end the ending value
/// @param {real} _shift the amount to shift start to end

function approach(_start, _end, _shift)
{
	if (_start < _end)
	{
		return min(_start + _shift, _end);	
	} else
	{
		return max(_start - _shift, _end);	
	}
}

function animation_end()
{
	return (image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe ? 1 : game_get_speed(gamespeed_fps)) >= image_number);	
}

function set_sprite(_sprite,_anim_reset = false,_image_speed = 1)
{
	if (_anim_reset && sprite_index != _sprite)
	{
		image_index = 0;
	}
	sprite_index = _sprite;	
	image_speed = _image_speed * global.time_dilation_current;
}

function draw_text_stroke(_x,_y,_string,_stroke_color = c_black,_stroke_width = 1,_text_color = c_white)
{
	
	draw_set_color(_stroke_color);
	for (var i=-_stroke_width;i<_stroke_width;i++)
	{
		for (var j=-_stroke_width;j<_stroke_width;j++)
		{
			draw_text(_x,_y,_string);
		}
	}
	draw_set_color(_text_color);
	draw_text(_x,_y,_string);
}

function in_view(_buffer = TILE_SIZE)
{
	return (bbox_right > camera_get_view_x(view) - _buffer && bbox_left < camera_get_view_x(view) + global.view_width + _buffer && bbox_bottom > camera_get_view_y(view) - _buffer && bbox_top < camera_get_view_y(view) + global.view_height) + _buffer;
}

function init_sprites()
{
	var _i = 0;
	repeat(argument_count)
	{
		sprites[$ argument[_i]] = asset_get_index("spr_"+ argument[_i]);
		_i++;
	}
}

function get_sprite()
{
	return sprites[$ fsm.get_current_state()];	
}