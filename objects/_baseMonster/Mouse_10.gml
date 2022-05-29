/// @description 

// Inherit the parent event
event_inherited();

if (states.active_state.name != "hidden")
	tooltip_show(Tooltip, actor_data.get_tooltip_text());
	
