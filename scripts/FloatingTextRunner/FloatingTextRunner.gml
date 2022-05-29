/*
    utility function to show floating text
*/

#macro FLOATING_DEFAULT_DISTANCE	-64
#macro FLOATING_FRAMES_PER_CHAR		2

function floating_text(owner, _text, _xoffset = 0, _yoffset = 0, min_duration = 30, yspeed = 1, color = c_yellow) {
	var xp = 0;
	var yp = 0;
	with (owner) {
		xp = x;
		yp = y;
		text_color = color;
		text_color_mouse_over = color;
	}
	
	var txt = instance_create_layer(xp, yp - 32, LAYER_FLOATING, FloatingText);
	txt.set_align(owner, _xoffset, _yoffset);
	with (txt) {
		text = _text;
	}
	var dur = min_duration + string_length(_text) * FLOATING_FRAMES_PER_CHAR;
	
	with(txt) {
		image_xscale = 1;
		image_yscale = 1;
		image_alpha = 1;
		new Animation(txt, 0, dur, acFloatingText)
			.set_move_distance(0, FLOATING_DEFAULT_DISTANCE * yspeed)
			.add_finished_trigger(function() {
				instance_destroy();
			});
	}
	
	return dur;
}
