/// @description exit level

event_inherited();

// no queueing of the exit field!
LAST_CLICKED_CONTENT = undefined;

if (!field.map_coords.is_same_as_player() || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

if (states.active_state.name == "locked") {
	floating_text(GAME.player_object, LG("player_strings/exit_locked"),,PLAYER_CHAT_OFFSET_Y);
}


