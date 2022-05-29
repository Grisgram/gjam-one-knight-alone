/// @description perform pixelation

if (mode == fade_run_mode.inactive) exit;

if (mode == fade_run_mode.wait_for_fade_in) {
	fade_in_countdown--;
	if (fade_in_countdown <= 0)
		start_fade_in();
	exit;
}

frame_counter++;
fx_set_parameter(fx, "g_CellSize", 
	mode == fade_run_mode.fade_out ? 
		frame_counter * px_per_step : 
		max_pixelation - frame_counter * px_per_step);

if (frame_counter == duration_frames) {
	frame_counter = 0;
	mode = fade_run_mode.inactive;
	layer_set_visible(pixel_layer_name, false);
	if (goto_room != undefined) {
		var rid = asset_get_index(goto_room);
		goto_room = undefined;
		room_goto(rid);
	}
}

