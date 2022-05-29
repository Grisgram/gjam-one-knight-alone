/// @description track value & align

// Inherit the parent event

if (value_to_track != "" && value_sprite != noone) {
	var v = GAME.player_data[$ value_to_track];
	if (v != last_value) {
		last_value = v;
		text = get_value_string(v, value_sprite);
		tooltip_text = sprintf("{0}: {1}", proper_value, v);
	}
} else
	log("*WARN* PlayerValueLabel has no value/sprite assigned!");

event_inherited();

