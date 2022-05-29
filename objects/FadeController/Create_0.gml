/// @description setup

#macro MAIN_FADE_CONTROLLER	global.__main_fade_controller
#macro FADE_CONTROLLER		global.__fade_controller
FADE_CONTROLLER = self;

enum fade_run_mode {
	inactive = 0,
	fade_out = 1,
	fade_in  = 2,
	wait_for_fade_in = 3,
}

my_room = room;

if (room == rmMain)
	MAIN_FADE_CONTROLLER = self;

fx = layer_get_fx(pixel_layer_name);

mode = fade_in_delay > 0 ? fade_run_mode.wait_for_fade_in : fade_run_mode.fade_in;
frame_counter = 0;

fade_in_countdown = fade_in_delay;

goto_room = undefined;

start_fade_in = function() {
	log("FADE IN " + room_get_name(my_room));
	window_set_cursor(cr_default);
	frame_counter = 0;
	layer_set_visible(pixel_layer_name, true);
	px_per_step = max_pixelation / duration_frames;
	mode = fade_run_mode.fade_in;
}

move_to_room = function(room_name) {
	log("FADE OUT " + room_get_name(my_room));
	window_set_cursor(cr_default);
	layer_set_visible(pixel_layer_name, true);
	goto_room = room_name;
	mode = fade_run_mode.fade_out;
}

if (mode == fade_run_mode.fade_in)
	start_fade_in(); // this gets called if fade_in_delay == 0
