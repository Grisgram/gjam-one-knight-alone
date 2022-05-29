/// @description Watch browser window size changes

event_inherited();

__active = IS_HTML;

curr_width = browser_width;
curr_height = browser_height;

if (__active)
	browser_scrollbars_enable();

/// @function					update_canvas()
/// @description				Update the browser canvas
update_canvas = function() {
	curr_width = browser_width;
	curr_height = browser_height;

	var w = browser_width;
	var h = browser_height;

	// find screen pixel dimensions:
	// this code is from YAL - many people hype that guy but honestly...
	// ... i haven't found much working code from him.
	//var rz = browser_get_device_pixel_ratio();
	//var rw = w * rz;
	//var rh = h * rz;

	// just in case i overlooked something, I keep the rw/rh variables here
	// they don't hurt performance, but for now they are equal to w/h
	var rw = w;
	var rh = h;

	var newwidth, newheight;
	var scale = rw / VIEW_WIDTH;
	
	// find best-fit option
	newwidth = VIEW_WIDTH * scale;
	newheight = VIEW_HEIGHT * scale;
	if (newwidth > rw || newheight > rh) {
		scale = rh / VIEW_HEIGHT;
		newwidth = VIEW_WIDTH * scale;
		newheight = VIEW_HEIGHT * scale;
	}
	
	// resize application_surface, if needed
	if (application_surface_is_enabled()) {
		surface_resize(application_surface, newwidth, newheight);
	}

	// set window size to screen pixel size:
	window_set_size(newwidth, newheight);
	window_set_position(rw / 2 - newwidth / 2, rh / 2 - newheight / 2);
	if (IS_HTML)
		display_set_gui_size(newwidth, newheight);

	// set canvas size to page pixel size:
	browser_stretch_canvas(newwidth, newheight);
}

