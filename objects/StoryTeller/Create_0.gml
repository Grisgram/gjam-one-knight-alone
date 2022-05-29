/// @description 

// Inherit the parent event
event_inherited();

typist_active = false;

reset_text = function(_text) {
	typist = scribble_typist();
	typist.in(0.5, 0.25);
	scrib = scribble(LG_resolve(_text), MY_NAME+string(string_length(_text))).starting_format("acme24out", c_white);
}

reset_text(text);
