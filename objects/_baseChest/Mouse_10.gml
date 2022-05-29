/// @description 

// Inherit the parent event
event_inherited();

if (!field.is_part_of_level || !field.map_coords.is_same_as_player() || !states.has_active_state() || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

if (states.active_state.name == "locked") {
	floating_text(self, 
		sprintf(LG("play_strings/chest_locked"), 
		sprite_get_name(key_sprite)),,-sprite_height-24,30,0.2,c_white);
}

