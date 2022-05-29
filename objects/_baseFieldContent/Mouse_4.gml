/// @description command queueing

if (HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

if (!field.map_coords.is_same_as_player() && field.is_neighbour_of_player()) {
	 // remember this as the last clicked object if in another room
	 LAST_CLICKED_CONTENT = id;
 }

