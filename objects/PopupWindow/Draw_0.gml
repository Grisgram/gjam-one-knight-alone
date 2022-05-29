/// @description 

draw_self();
if (scribbletext != undefined) {
	if (spawned && button != undefined) button.visible = true;
	scribbletext.blend(c_white, image_alpha).draw(CAM_CENTER_X, CAM_CENTER_Y - 50);
}

