/// This script contains mappings from binding labels - a combination of keyboard key names, mouse button
/// names, and abstract gamepad names - to more friendly terms that you can show a player. Typically you'd
/// set up this function to return sprites such that you can draw gamepad icons as visual icons.
/// 
/// Default values in this script reflect the particular, and sometimes unexpected, buttons that each gamepad
/// binding maps to on the actual physical hardware. There are a handful of special cases at the top of the
/// script that are used to handle errors or misconfigurations.



//Special case: When a non-binding value is being evaluated
//              This should only happen if Input is given an invalid input argument
input_icon_not_a_binding("Not a binding");

//Special case: When an empty binding is being evaluated
input_icon_empty("Empty");



//Optional remapping for keyboard and mouse
//This is useful for turning keyboard keys into sprite icons to match other assets, or for returning formatted strings (e.g. for use with Scribble)
//Any keyboard key label not in this struct will simply fall through and return the key name
input_icons_keyboard_and_mouse()
//Put extra .add() commands here to add icons to keyboard and mouse
.add("W", spr_keyboard_w)
.add("A", spr_keyboard_a)
.add("S", spr_keyboard_s)
.add("D", spr_keyboard_d)
.add("arrow up", spr_keyboard_up)
.add("arrow left", spr_keyboard_left)
.add("arrow down", spr_keyboard_down)
.add("arrow right", spr_keyboard_right)
.add("space", spr_keyboard_space)
.add("shift", spr_keyboard_shift)
.add("Q", spr_keyboard_q)
.add("mouse button left", spr_mouse_left_click)
.add("mouse button right", spr_mouse_right_click)

/*
        up:    [input_binding_key(vk_up),    input_binding_key("W")],
        down:  [input_binding_key(vk_down),  input_binding_key("S")],
        left:  [input_binding_key(vk_left),  input_binding_key("A")],
        right: [input_binding_key(vk_right), input_binding_key("D")],
		
		//in game verbs
		jump: input_binding_key(vk_space),
		grapple: input_binding_mouse_button(mb_left),
		glide: input_binding_key("Q"),
		run: input_binding_key(vk_shift),
		pause: input_binding_key(vk_escape),
*/


#region Gamepads

//Xbox One and Series S|X controllers
input_icons_gamepad(INPUT_GAMEPAD_TYPE_XBOX_ONE)

//basic xbox buttons
.add("gamepad face south",         spr_xbox_a)
.add("gamepad face east",          spr_xbox_b)
.add("gamepad face west",          spr_xbox_x)
.add("gamepad face north",         spr_xbox_y)
.add("gamepad shoulder l",         spr_xbox_left_bumper)
.add("gamepad shoulder r",         spr_xbox_right_bumper)
.add("gamepad trigger l",          spr_xbox_left_trigger)
.add("gamepad trigger r",          spr_xbox_right_trigger)
.add("gamepad dpad left",          spr_xbox_dpad_left)
.add("gamepad dpad right",		   spr_xbox_dpad_right)
.add("gamepad dpad up",            spr_xbox_dpad_up)
.add("gamepad dpad down",          spr_xbox_dpad_down)

.add("gamepad thumbstick l left",  spr_joystick_l_left)
.add("gamepad thumbstick l right", spr_joystick_l_right)
.add("gamepad thumbstick l up",    spr_joystick_l_up)
.add("gamepad thumbstick l down",  spr_joystick_l_down)
.add("gamepad thumbstick l click", spr_joystick_l_click)

.add("gamepad thumbstick r left",  spr_joystick_r_left)
.add("gamepad thumbstick r right", spr_joystick_r_right)
.add("gamepad thumbstick r up",    spr_joystick_r_up)
.add("gamepad thumbstick r down",  spr_joystick_r_down)
.add("gamepad thumbstick r click", spr_joystick_r_click)
.add("gamepad select",             "view")
.add("gamepad start",              "menu")


//Series S|X only
.add("gamepad misc 1",             "share")

//Elite and third party controllers
.add("gamepad paddle 1",           "P1")
.add("gamepad paddle 2",           "P2")
.add("gamepad paddle 3",           "P3")
.add("gamepad paddle 4",           "P4")

//PlayStation 5
input_icons_gamepad(INPUT_GAMEPAD_TYPE_PS5)
//basic ps buttons
.add("gamepad face south",         spr_ps_x)
.add("gamepad face east",          spr_ps_circle)
.add("gamepad face west",          spr_ps_square)
.add("gamepad face north",         spr_ps_triangle)
.add("gamepad shoulder l",         spr_ps_l1)
.add("gamepad shoulder r",         spr_ps_r1)
.add("gamepad trigger l",          spr_ps_l2)
.add("gamepad trigger r",          spr_ps_r2)

.add("gamepad dpad left",          spr_ps_dpad_left)
.add("gamepad dpad right",         spr_ps_dpad_right)
.add("gamepad dpad up",            spr_ps_dpad_up)
.add("gamepad dpad down",          spr_ps_dpad_down)

.add("gamepad thumbstick l left",  spr_joystick_l_left)
.add("gamepad thumbstick l right", spr_joystick_l_right)
.add("gamepad thumbstick l up",    spr_joystick_l_up)
.add("gamepad thumbstick l down",  spr_joystick_l_down)
.add("gamepad thumbstick l click", spr_joystick_l_click)

.add("gamepad thumbstick r left",  spr_joystick_r_left)
.add("gamepad thumbstick r right", spr_joystick_r_right)
.add("gamepad thumbstick r up",    spr_joystick_r_up)
.add("gamepad thumbstick r down",  spr_joystick_r_down)
.add("gamepad thumbstick r click", spr_joystick_r_click)	
.add("gamepad select",             "create")
.add("gamepad start",              "options")
.add("gamepad touchpad click",     "touchpad click")

//Not available on the PlayStation 5 console itself but available on other platforms
.add("gamepad misc 1",             "mic")

//DualSense Edge
.add("gamepad paddle 1",           "RB")
.add("gamepad paddle 2",           "LB")

//Switch handheld/dual JoyCon/Pro Controller
input_icons_gamepad(INPUT_GAMEPAD_TYPE_SWITCH)
.add("gamepad face south",         "B")
.add("gamepad face east",          "A")
.add("gamepad face west",          "Y")
.add("gamepad face north",         "X")
.add("gamepad shoulder l",         "L")
.add("gamepad shoulder r",         "R")
.add("gamepad trigger l",          "ZL")
.add("gamepad trigger r",          "ZR")
.add("gamepad select",             "minus")
.add("gamepad start",              "plus")
.add("gamepad dpad left",          "dpad left")
.add("gamepad dpad right",         "dpad right")
.add("gamepad dpad up",            "dpad up")
.add("gamepad dpad down",          "dpad down")

.add("gamepad thumbstick l left",  "thumbstick l left")
.add("gamepad thumbstick l right", "thumbstick l right")
.add("gamepad thumbstick l up",    "thumbstick l up")
.add("gamepad thumbstick l down",  "thumbstick l down")
.add("gamepad thumbstick l click", "thumbstick l click")
 
.add("gamepad thumbstick r left",  "thumbstick r left")
.add("gamepad thumbstick r right", "thumbstick r right")
.add("gamepad thumbstick r up",    "thumbstick r up")
.add("gamepad thumbstick r down",  "thumbstick r down")
.add("gamepad thumbstick r click", "thumbstick r click")
  
//Not available on the Switch console itself but available on other platforms
.add("gamepad guide",              "home")
.add("gamepad misc 1",             "capture")

//Left-hand Switch JoyCon
//This setup assums horizontal hold type
input_icons_gamepad(INPUT_GAMEPAD_TYPE_JOYCON_LEFT)
.add("gamepad face south",         "face south")
.add("gamepad face east",          "face east")
.add("gamepad face west",          "face west") 
.add("gamepad face north",         "face north")
.add("gamepad shoulder l",         "SL")
.add("gamepad shoulder r",         "SR")
.add("gamepad start",              "minus")

.add("gamepad thumbstick l left",  "thumbstick left")
.add("gamepad thumbstick l right", "thumbstick right")
.add("gamepad thumbstick l up",    "thumbstick up")
.add("gamepad thumbstick l down",  "thumbstick down")
.add("gamepad thumbstick l click", "thumbstick click")

//Not available on the Switch console itself but available on other platforms
.add("gamepad select",             "capture")

//Right-hand Switch JoyCon
//This setup assums horizontal hold type
input_icons_gamepad(INPUT_GAMEPAD_TYPE_JOYCON_RIGHT)
.add("gamepad face south",         "face south")
.add("gamepad face east",          "face east")
.add("gamepad face west",          "face west") 
.add("gamepad face north",         "face north")
.add("gamepad shoulder l",         "SL")
.add("gamepad shoulder r",         "SR")
.add("gamepad start",              "plus")

.add("gamepad thumbstick l left",  "thumbstick left")
.add("gamepad thumbstick l right", "thumbstick right")
.add("gamepad thumbstick l up",    "thumbstick up")
.add("gamepad thumbstick l down",  "thumbstick down")
.add("gamepad thumbstick l click", "thumbstick click")

//Not available on the Switch console itself but available on other platforms
.add("gamepad select",             "home")

//Xbox 360
input_icons_gamepad(INPUT_GAMEPAD_TYPE_XBOX_360)
.add("gamepad face south",         spr_xbox_a)
.add("gamepad face east",          spr_xbox_b)
.add("gamepad face west",          spr_xbox_x)
.add("gamepad face north",         spr_xbox_y)
.add("gamepad shoulder l",         spr_xbox_left_bumper)
.add("gamepad shoulder r",         spr_xbox_right_bumper)
.add("gamepad trigger l",          spr_xbox_left_trigger)
.add("gamepad trigger r",          spr_xbox_right_trigger)
.add("gamepad dpad left",          spr_xbox_dpad_left)
.add("gamepad dpad right",		   spr_xbox_dpad_right)
.add("gamepad dpad up",            spr_xbox_dpad_up)
.add("gamepad dpad down",          spr_xbox_dpad_down)

.add("gamepad thumbstick l left",  spr_joystick_l_left)
.add("gamepad thumbstick l right", spr_joystick_l_right)
.add("gamepad thumbstick l up",    spr_joystick_l_up)
.add("gamepad thumbstick l down",  spr_joystick_l_down)
.add("gamepad thumbstick l click", spr_joystick_l_click)

.add("gamepad thumbstick r left",  spr_joystick_r_left)
.add("gamepad thumbstick r right", spr_joystick_r_right)
.add("gamepad thumbstick r up",    spr_joystick_r_up)
.add("gamepad thumbstick r down",  spr_joystick_r_down)
.add("gamepad thumbstick r click", spr_joystick_r_click)

//PlayStation 4
input_icons_gamepad(INPUT_GAMEPAD_TYPE_PS4)
.add("gamepad face south",         spr_ps_x)
.add("gamepad face east",          spr_ps_circle)
.add("gamepad face west",          spr_ps_square)
.add("gamepad face north",         spr_ps_triangle)
.add("gamepad shoulder l",         spr_ps_l1)
.add("gamepad shoulder r",         spr_ps_r1)
.add("gamepad trigger l",          spr_ps_l2)
.add("gamepad trigger r",          spr_ps_r2)

.add("gamepad dpad left",          spr_ps_dpad_left)
.add("gamepad dpad right",         spr_ps_dpad_right)
.add("gamepad dpad up",            spr_ps_dpad_up)
.add("gamepad dpad down",          spr_ps_dpad_down)

.add("gamepad thumbstick l left",  spr_joystick_l_left)
.add("gamepad thumbstick l right", spr_joystick_l_right)
.add("gamepad thumbstick l up",    spr_joystick_l_up)
.add("gamepad thumbstick l down",  spr_joystick_l_down)
.add("gamepad thumbstick l click", spr_joystick_l_click)

.add("gamepad thumbstick r left",  spr_joystick_r_left)
.add("gamepad thumbstick r right", spr_joystick_r_right)
.add("gamepad thumbstick r up",    spr_joystick_r_up)
.add("gamepad thumbstick r down",  spr_joystick_r_down)
.add("gamepad thumbstick r click", spr_joystick_r_click)	

.add("gamepad touchpad click", "touchpad click")

//PlayStation 1-3
input_icons_gamepad(INPUT_GAMEPAD_TYPE_PSX)
.add("gamepad face south",         spr_ps_x)
.add("gamepad face east",          spr_ps_circle)
.add("gamepad face west",          spr_ps_square)
.add("gamepad face north",         spr_ps_triangle)
.add("gamepad shoulder l",         spr_ps_l1)
.add("gamepad shoulder r",         spr_ps_r1)
.add("gamepad trigger l",          spr_ps_l2)
.add("gamepad trigger r",          spr_ps_r2)

.add("gamepad dpad left",          spr_ps_dpad_left)
.add("gamepad dpad right",         spr_ps_dpad_right)
.add("gamepad dpad up",            spr_ps_dpad_up)
.add("gamepad dpad down",          spr_ps_dpad_down)

.add("gamepad thumbstick l left",  spr_joystick_l_left)
.add("gamepad thumbstick l right", spr_joystick_l_right)
.add("gamepad thumbstick l up",    spr_joystick_l_up)
.add("gamepad thumbstick l down",  spr_joystick_l_down)
.add("gamepad thumbstick l click", spr_joystick_l_click)

.add("gamepad thumbstick r left",  spr_joystick_r_left)
.add("gamepad thumbstick r right", spr_joystick_r_right)
.add("gamepad thumbstick r up",    spr_joystick_r_up)
.add("gamepad thumbstick r down",  spr_joystick_r_down)
.add("gamepad thumbstick r click", spr_joystick_r_click)	

//Nintendo Gamecube
input_icons_gamepad(INPUT_GAMEPAD_TYPE_GAMECUBE)
.add("gamepad face south",         "A")
.add("gamepad face east",          "X")
.add("gamepad face west",          "B")
.add("gamepad face north",         "Y")
.add("gamepad shoulder r",         "Z")
.add("gamepad trigger l",          "L")
.add("gamepad trigger r",          "R")
.add("gamepad start",              "start")
.add("gamepad dpad left",          "dpad left")
.add("gamepad dpad right",         "dpad right")
.add("gamepad dpad up",            "dpad up")
.add("gamepad dpad down",          "dpad down")

.add("gamepad thumbstick l left",  "thumbstick l left")
.add("gamepad thumbstick l right", "thumbstick l right")
.add("gamepad thumbstick l up",    "thumbstick l up")
.add("gamepad thumbstick l down",  "thumbstick l down")

.add("gamepad thumbstick r left",  "thumbstick r left")
.add("gamepad thumbstick r right", "thumbstick r right")
.add("gamepad thumbstick r up",    "thumbstick r up")
.add("gamepad thumbstick r down",  "thumbstick r down")

//The following icons are for Switch GameCube controllers and adapters only
.add("gamepad thumbstick l click", "thumbstick l click")
.add("gamepad thumbstick r click", "thumbstick r click")
.add("gamepad guide",              "home")
.add("gamepad misc 1",             "capture")

////A couple additional examples for optional gamepad types (see __input_define_gamepad_types)
//
////Nintendo 64
//input_icons(INPUT_GAMEPAD_TYPE_N64)
//.add("gamepad face south",         "A")
//.add("gamepad face east",          "B")
//.add("gamepad shoulder l",         "L")
//.add("gamepad shoulder r",         "R")
//.add("gamepad trigger l",          "Z")
//.add("gamepad start",              "start")
//.add("gamepad dpad up",            "dpad up")
//.add("gamepad dpad down",          "dpad down")
//.add("gamepad dpad left",          "dpad left")
//.add("gamepad dpad right",         "dpad right")
//.add("gamepad thumbstick l left",  "thumbstick left")
//.add("gamepad thumbstick l right", "thumbstick right")
//.add("gamepad thumbstick l up",    "thumbstick up")
//.add("gamepad thumbstick l down",  "thumbstick down")
//.add("gamepad thumbstick r left",  "C left")
//.add("gamepad thumbstick r right", "C right")
//.add("gamepad thumbstick r up",    "C up")
//.add("gamepad thumbstick r down",  "C down")
//
////Sega Saturn
//input_icons(INPUT_GAMEPAD_TYPE_SATURN)
//.add("gamepad face south", "A")
//.add("gamepad face east",  "B")
//.add("gamepad face west",  "X")
//.add("gamepad face north", "Y")
//.add("gamepad shoulder l", "L")
//.add("gamepad shoulder r", "Z")
//.add("gamepad trigger l",  "R")
//.add("gamepad trigger r",  "C")
//.add("gamepad select",     "mode")
//.add("gamepad start",      "start")
//.add("gamepad dpad up",    "dpad up")
//.add("gamepad dpad down",  "dpad down")
//.add("gamepad dpad left",  "dpad left")
//.add("gamepad dpad right", "dpad right")

#endregion
