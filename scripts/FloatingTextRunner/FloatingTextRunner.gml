/*
    utility function to show floating text
*/

#macro FLOATING_DEFAULT_DISTANCE	-64
#macro FLOATING_FRAMES_PER_CHAR		2

#macro RUNNING_FLOATINGS			global.running_floatings
RUNNING_FLOATINGS = 0;

function floating_text(owner, _text, _xoffset = 0, _yoffset = 0, min_duration = 120, yspeed = 1, color = c_yellow, count_global = true) {
	var xp = 0;
	var yp = 0;
	with (owner) {
		xp = x;
		yp = y;
		text_color = color;
		text_color_mouse_over = color;
	}
	
	if (count_global) RUNNING_FLOATINGS++;
	var txt = instance_create_layer(xp, yp - 32, LAYER_FLOATING, FloatingText);
	txt.set_align(owner, _xoffset, _yoffset + 32 * RUNNING_FLOATINGS);
	with (txt) {
		text = _text;
	}
	var dur = min_duration + string_length(_text) * FLOATING_FRAMES_PER_CHAR;
	
	with(txt) {
		image_xscale = 1;
		image_yscale = 1;
		image_alpha = 1;
		_count_global = count_global;
		anim = new Animation(txt, 0, dur, acFloatingText)
			.set_move_distance(0, FLOATING_DEFAULT_DISTANCE * yspeed)
			.add_finished_trigger(function() {
				if (_count_global)
					RUNNING_FLOATINGS = max(0, RUNNING_FLOATINGS - 1);
				instance_destroy();
			});
	}
	
	return txt;
}
