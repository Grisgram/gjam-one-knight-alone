/*
    short_description_here
*/
function ask_for_exit() {
	msg_show_yes_no(LG("play_strings/exit_title"), LG("play_strings/exit_to_main"), 
		function() {
			FADE_CONTROLLER.move_to_room("rmMain");
		});
}

