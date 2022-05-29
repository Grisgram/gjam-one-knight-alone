/// @description move player here

if (!is_part_of_level || map_coords.is_same_as_player() || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

if (states.active_state.name == "open") {
	if (is_neighbour_of_player(false) && GAME.player_object.states.active_state.name == "idle") {
		//var monster = contents != undefined && object_is_ancestor(contents, _baseMonster);
		with (GAME.player_object) 
			move(other.map_coords.x, other.map_coords.y, false);
	} else
		floating_text(GAME.player_object, LG("player_strings/too_far_away"),, PLAYER_CHAT_OFFSET_Y);
}


