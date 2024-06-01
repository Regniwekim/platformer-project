//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

return {
    
    keyboard_and_mouse:
    {
        up:    [input_binding_key(vk_up),    input_binding_key("W")],
        down:  [input_binding_key(vk_down),  input_binding_key("S")],
        left:  [input_binding_key(vk_left),  input_binding_key("A")],
        right: [input_binding_key(vk_right), input_binding_key("D")],
		
		//in game verbs
		jump: input_binding_key(vk_space),
		attack: input_binding_mouse_button(mb_left),
		grapple: input_binding_mouse_button(mb_right),
		grapple_reel: input_binding_key(vk_shift),
		glide: input_binding_key("Q"),
		run: input_binding_key(vk_shift),
		pause: input_binding_key(vk_escape),
		
        
		//menu verbs
        accept:  [input_binding_key(vk_space), input_binding_key(vk_enter)],
        cancel:  [input_binding_key(vk_backspace),input_binding_key(vk_escape)], 
    },
    
    gamepad:
    {
        up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],
        down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
        left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
        right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
        
        //in game verbs
		jump:  input_binding_gamepad_button(gp_face1),
		attack: input_binding_gamepad_button(gp_face3),
		//run:  input_binding_gamepad_button(gp_face3),
		glide:  input_binding_gamepad_button(gp_shoulderl),
		grapple:  input_binding_gamepad_button(gp_shoulderr),
		grapple_reel:  input_binding_gamepad_button(gp_shoulderrb),
		pause: input_binding_gamepad_button(gp_start),
		aim_up:    input_binding_gamepad_axis(gp_axislv, true),
        aim_down:  input_binding_gamepad_axis(gp_axislv, false),
        aim_left:  input_binding_gamepad_axis(gp_axislh, true),
        aim_right: input_binding_gamepad_axis(gp_axislh, false),
		
		//menu verbs
		accept:  input_binding_gamepad_button(gp_face1),
        cancel:  input_binding_gamepad_button(gp_face2),
           
    }
    
};

input_chord_create("drop",0,"down","jump")