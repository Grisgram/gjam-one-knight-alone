/// @description 

// Inherit the parent event
event_inherited();

if (states.active_state.name != "hidden" && mouse_is_over) {
	if (actor_data.value_string_hp != "")
		draw_text_scribble(SELF_VIEW_CENTER_X, SELF_VIEW_TOP_EDGE - 32, actor_data.value_string_hp);
	if (actor_data.value_string_shield != "")
		draw_text_scribble(SELF_VIEW_CENTER_X, SELF_VIEW_BOTTOM_EDGE  + 24, actor_data.value_string_shield);
	if (actor_data.value_string_weapon != "")
		draw_text_scribble(SELF_VIEW_CENTER_X, SELF_VIEW_BOTTOM_EDGE + 64, actor_data.value_string_weapon);
}
