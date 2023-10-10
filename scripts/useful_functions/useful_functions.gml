// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function approach(start, end, shift);
/// @param {real} _start the starting value
/// @param {real} _end the ending value
/// @param {real} _shift the amount to shift start to end

function approach(_start, _end, _shift){
	if (_start < _end) {
		return min(_start + _shift, _end);	
	} else {
		return max(_start - _shift, _end);	
	}
}

function animation_end() {
	return image_index == image_number-1;	
}

function set_sprite(_sprite,_anim_reset = false,_image_speed = 1) {
	sprite_index = _sprite;
	if (_anim_reset) {
		image_index = 0;
	}
	image_speed = _image_speed;
}

function draw_text_stroke(_x,_y,_string,_stroke_color = c_black,_stroke_width = 1,_text_color = c_white) {
	
	draw_set_color(_stroke_color);
	for (var i=-_stroke_width;i<_stroke_width;i++) {
		for (var j=-_stroke_width;j<_stroke_width;j++) {
			draw_text(_x,_y,_string);
		}
	}
	draw_set_color(_text_color);
	draw_text(_x,_y,_string);
}