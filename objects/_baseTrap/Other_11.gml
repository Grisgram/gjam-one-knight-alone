/// @description player enter field

// Inherit the parent event
event_inherited();

if (!field.is_part_of_level || !field.map_coords.is_same_as_player()) exit;

if (states.active_state.name == "hidden") {
	states.set_state("appear");
	floating_text(self, LG("player_strings/trap_curses*"),,PLAYER_CHAT_OFFSET_Y * 2,120,2.5,APP_THEME_ACCENT);
}

