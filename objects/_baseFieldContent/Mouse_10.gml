/// @description mouse_is_over=true
if (!field.is_part_of_level || in_animation() || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

if (states.has_active_state()) {
	switch(states.active_state.name) {
		case "closed":	outline_color = SCRIBBLE_COLORS.c_lgreen; break;
		case "locked":	outline_color = c_orange; break;
		case "open":
		case "used":	outline_color = c_grey; break;
	}
}

// Inherit the parent event
event_inherited();

