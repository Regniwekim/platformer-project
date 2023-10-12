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
	image_speed = _image_speed * global.time_dilation_current;
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

function in_view() {
	return (bbox_right > camera_get_view_x(view) && bbox_left < camera_get_view_x(view)+global.view_width && bbox_bottom > camera_get_view_y(view) && bbox_top < camera_get_view_y(view) + global.view_height);
}

function tilemap_autotile(_map, _cx, _cy, _addTile) 
{
                
    // _map     : The tilemap id
    // _cx, _cy : The cell x/y of the tile (not room x/y)
    // _addTile : sets tile empty or not (true/false)
                
    // Set (cx, cy) 
    tilemap_set(_map, _addTile, _cx, _cy);
 
    var _row = _cx + 2, _col = _cy + 2;
    _cx--;
    _cy--;
    
    // Set mask for 3x3 area centered on (cx, cy)
    for (var _tx = _cx, _mask = 0; _tx < _row; _tx++)
        for (var _ty = _cy; _ty < _col; _ty++)
        {       
            if tilemap_get(_map, _tx, _ty) { 
                // The mask consists of powers of 2, so take advantage of bitwise
                                            
                _mask = 0                                                                         // = 0
                    + ((tilemap_get(_map, _tx-1, _ty) > 0) << 3)                                  // + 8
                    + ((tilemap_get(_map, _tx+1, _ty) > 0) << 4);                                 // + 16
                
                if (tilemap_get(_map, _tx, _ty-1)) _mask = _mask | 2                              // OR 2
                    + ( tilemap_get(_map, _tx-1, _ty-1) && tilemap_get(_map, _tx-1, _ty))         // +  1
                    + ((tilemap_get(_map, _tx+1, _ty-1) && tilemap_get(_map, _tx+1, _ty)) << 2);  // +  4
                
                if (tilemap_get(_map, _tx, _ty+1)) _mask = _mask | 64                             // OR 64
                    + ((tilemap_get(_map, _tx-1, _ty+1) && tilemap_get(_map, _tx-1, _ty)) << 5)   // +  32
                    + ((tilemap_get(_map, _tx+1, _ty+1) && tilemap_get(_map, _tx+1, _ty)) << 7);  // + 128
                
            } else _mask = -1;
            
            // Large switch of constants is a jump-table of O(1) at runtime no worries 
            switch _mask 
            {
                case 255 : _mask = 47; break; case 254 : _mask =  1; break; case 251 : _mask =  2; break; 
                case 250 : _mask =  3; break; case 248 : _mask = 20; break; case 223 : _mask =  8; break; 
                case 222 : _mask =  9; break; case 219 : _mask = 10; break; case 218 : _mask = 11; break; 
                case 216 : _mask = 22; break; case 214 : _mask = 16; break; case 210 : _mask = 17; break; 
                case 208 : _mask = 34; break; case 127 : _mask =  4; break; case 126 : _mask =  5; break; 
                case 123 : _mask =  6; break; case 122 : _mask =  7; break; case 120 : _mask = 21; break; 
                case 107 : _mask = 24; break; case 106 : _mask = 26; break; case 104 : _mask = 36; break; 
                case  95 : _mask = 12; break; case  94 : _mask = 13; break; case  91 : _mask = 14; break; 
                case  90 : _mask = 15; break; case  88 : _mask = 23; break; case  86 : _mask = 18; break; 
                case  82 : _mask = 19; break; case  80 : _mask = 35; break; case  75 : _mask = 25; break; 
                case  74 : _mask = 27; break; case  72 : _mask = 37; break; case  66 : _mask = 32; break; 
                case  64 : _mask = 42; break; case  31 : _mask = 28; break; case  30 : _mask = 29; break; 
                case  27 : _mask = 30; break; case  26 : _mask = 31; break; case  24 : _mask = 33; break; 
                case  22 : _mask = 40; break; case  18 : _mask = 41; break; case  16 : _mask = 43; break; 
                case  11 : _mask = 38; break; case  10 : _mask = 39; break; case   8 : _mask = 45; break; 
                case   2 : _mask = 44; break; case   0 : _mask = 46; break; case  -1 : _mask =  0; break;
            }
            
            // Set the new index
            tilemap_set(_map, _mask, _tx, _ty);
        }
}