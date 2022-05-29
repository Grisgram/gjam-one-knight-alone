/// @description 

// Inherit the parent event
event_inherited();

image_xscale = (CAM_WIDTH * 0.8) / sprite_width;
image_yscale = (CAM_HEIGHT * 0.5) / sprite_height;
x = CAM_CENTER_X;
y = CAM_CENTER_Y;
depth++;

scribbletext = undefined;
spawned = false;

button = undefined;

global.running_popup = self;

show_text = function(text) {
	scribbletext = scribble(text, "popup").starting_format("acme28out", c_white);
}

add_home_button = function() {
	button = instance_create_layer(x,y,layer,TextButton);
	var by = CAM_CENTER_Y + 130;
	var bx = CAM_CENTER_X - 200;
	with (button) {
		min_width = 400;
		text = LG("play_strings/main_menu");
		on_left_click = function() {
			hide_popup();
			instance_destroy(global.running_popup);
			instance_destroy();
			animation_clear_pool();
			FADE_CONTROLLER.move_to_room("rmMain");
		}
		draw_on_gui = false;
		font_to_use = "acme28out";
		y = by;
		x = bx;
	}
}

new Animation(self, 0, 60, acLinearAlphaIn)
	.add_finished_trigger(function() {
		spawned = true;
	});
	

