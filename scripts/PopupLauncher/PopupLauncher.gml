/*
    popups
*/
function create_level_start_popup() {
	show_popup();
	var wnd = instance_create_layer(0,0,LAYER_POPUP,PopupWindow);
	with (wnd) {
		image_blend = APP_THEME_BLACK;
		show_text(sprintf(LG("play_strings/level_start"), GAME.level_number, GAME.time_data.get_level_time_frame_string()));
		new Animation(self, 150, 30, acLinearAlphaOut)
			.add_finished_trigger(function() {
				hide_popup();
				instance_destroy(global.running_popup);
				instance_destroy();
			}
		);
	}
}

function create_game_over_popup(won) {
	show_popup();
	var txt = won ? LG("play_strings/game_over_win") : LG("play_strings/game_over_lose");
	var wnd = instance_create_layer(0,0,LAYER_POPUP,PopupWindow);
	with (wnd) {
		image_blend = won ? c_yellow : c_red;
		show_text(txt);
		add_home_button();
	}
}


