/// @description check if used

// Inherit the parent event
event_inherited();

if (!field.map_coords.is_same_as_player() || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

switch (states.active_state.name) {
	case "usable": 
		states.set_state("using"); 
		break;
	case "used":
		floating_text(GAME.player_object, LG("player_strings/already_used"),,PLAYER_CHAT_OFFSET_Y);
		break;
}

