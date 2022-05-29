/*
    start a game
*/
function play_now(){
	FADE_CONTROLLER.move_to_room("rmPlay");
}

function switch_credits_view() {
	static credits_view = false;
	
	credits_view = !credits_view;
	storyTeller.reset_text(credits_view ? "=credits/credits_text" : "=intro_strings/storyline");
}
