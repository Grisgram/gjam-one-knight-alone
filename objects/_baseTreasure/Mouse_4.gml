/// @description open treasure

event_inherited();

if (!field.is_part_of_level || !field.map_coords.is_same_as_player() || !states.has_active_state() || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

if (field.map_coords.is_same_as_player()) {
	switch(states.active_state.name) {
		case "closed":	states.set_state("opening"); break;
		case "open":	floating_text(GAME.player_object, LG("play_strings/already_looted"),,PLAYER_CHAT_OFFSET_Y); break;
		case "locked":
			var mn = MY_NAME;
			with (GAME.player_object) {
				if (GAME.player_data.has_key_for(mn))
					unlock_chest(mn);
				else
					floating_text(GAME.player_object, LG("play_strings/cant_loot"),,PLAYER_CHAT_OFFSET_Y); 
			}
			break;
	}
}
