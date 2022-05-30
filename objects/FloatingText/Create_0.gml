/// @description 

// Inherit the parent event
event_inherited();

anim = undefined;
align_to = undefined;
xoff = 0;

set_align = function(_align_to, _xoffset, _yoffset) {
	align_to = _align_to;
	xoff	 = _xoffset;
	y += _yoffset;
}

draw_scribble_text = function() {
	var mx = x;
	var mxoff = 0;
	var sprw = sprite_width;
	
	if (align_to != undefined) {
		with(align_to) {
			mx = x;
			mxoff = sprite_xoffset;
			sprw = sprite_width;
		}
	
		x = xoff + mx - mxoff + sprw / 2;

		__text_x = x;
	}
	__scribble_text.draw(__text_x, __text_y);
}

