/// @description 

// Inherit the parent event
event_inherited();

last_value = -1;

proper_value = string_upper(string_copy(value_to_track, 1, 1)) + string_skip_start(value_to_track, 1);

scribble_add_text_effects = function(scribbletext) {
	if (word_wrap)
		scribbletext.wrap(nine_slice_data.width);
	scribbletext.scale_to_box(sprite_width, sprite_height);
}


