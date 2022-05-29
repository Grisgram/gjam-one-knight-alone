/// @description player enters this field

// Inherit the parent event
event_inherited();

with (contents) {
	switch(states.active_state.name) {
		case "usable":
			floating_text(self, LG("play_strings/level_exit"),,-sprite_height/2,60,0.5,APP_THEME_ACCENT);
			break;
		case "locked":
			floating_text(self, LG("player_strings/exit_locked"),,-sprite_height/2,60,0.5,APP_THEME_ACCENT);
			break;
	}
}
