#macro gravity_standard 0.6
#macro gravity_current (gravity_standard * gravity_multiplier)
#macro friction_stadard 0.8
#macro friction_current (friction_stadard * friction_multiplier)
#macro coyote_time_frames 6
#macro terminal_velocity 10
#macro C_SLOPE_ATTRACT_RANGE 4
#macro C_ON_HORIZONTAL_FRAMES 6
#macro C_ON_VERTICAL_FRAMES 8
#macro C_ON_WALL_FRICTION 0.3
#macro C_VARIABLE_JUMP_FRICTION 0.6
#macro jump_buffer_frames 15
#macro C_COLLISION_ONE_WAY_BUFFER 1
#macro C_COLLISION_ONE_WAY_MOVE 2

#macro DEPTH_SYSTEM -16000

#macro VIEW_WIDTH 540
#macro VIEW_HEIGHT 220
#macro GUI_WIDTH  1080
#macro GUI_HEIGHT 1080
#macro ZOOM_MIN 0.1
#macro ZOOM_MAX 4
#macro ZOOM_SPEED 0.1

#macro FRAME_SPEED room_speed * delta_time * 0.000001

#macro view view_camera[0]
#macro TILE_SIZE 16
#macro COL_TILES layer_tilemap_get_id("lay_solid_tiles")
#macro camera_width camera_get_view_width(view_camera[0])
#macro camera_height camera_get_view_height(view_camera[0])
