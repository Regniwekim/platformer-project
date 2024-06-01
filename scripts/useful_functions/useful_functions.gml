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
	repeat(argument_count div 2)
	{
		sprites[$ argument[_i]] = argument[_i+1];
		_i+=2;
	}
}

function get_sprite()
{
	return asset_get_index(sprites[fsm.get_current_state()]);	
}

function collision_line_point(_x1, _y1, _x2, _y2, _obj, _prec, _notme)
{
	var _rr = collision_line(_x1, _x2, _y1, _y2, _obj, _prec, _notme);
	var _rx = _x2;
	var _ry = _y2;
	if (_rr != noone)
	{
		var _p0 = 0;
		var _p1 = 1;
		repeat(ceil(log2(point_distance(_x1,_y1,_x2,_y2))) + 1)
		{
			var _np = _p0 + (_p1 - _p0) * 0.5;
			var _nx = _x1 + (_x2 - _x1) * _np;
			var _ny = _y1 + (_y2 - _y1) * _np;
			var _px = _x1 + (_x2 - _x1) * _p0;
			var _py = _y1 + (_y2 - _y1) * _p0;
			var _nr = collision_line(_px, _py, _nx, _ny, _obj, _prec, _notme);
			if (_nr != noone)
			{
				_rr = _nr;
				_rx = _nx;
				_ry = _ny;
				_p1 = _np;
			}
			else
			{
				_p0 = _np;	
			}
		}
	}
	var _r = [_rr,_rx,_ry];
	//_r[0] = _rr;
	//_r[1] = _rx;
	//_r[2] = _ry;
	return _r;
}

function raycast(_startx, _starty, _endx, _endy, _target)
{
	var _len = 0;
	var _dir = point_direction(_startx, _starty, _endx, _endy);
	var _max = point_direction(_startx, _starty, _endx, _endy);
	var _rc = [0,0];
	while (_len < _max)
	{
		var _castx = _startx + lengthdir_x(_len, _dir);
		var _casty = _starty + lengthdir_y(_len, _dir);
		if (collision_point(_castx, _casty, _target, false, false))
		{
			_rc[0] = _castx;
			_rc[1] = _casty;
			return _rc;
		}
		_len++;
	}
	return false;
}