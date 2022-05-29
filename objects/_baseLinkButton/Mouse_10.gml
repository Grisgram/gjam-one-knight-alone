/// @description mouse cursor


// Inherit the parent event
event_inherited();

if (!visible || image_alpha < 0.5) exit;

window_set_cursor(cr_handpoint);

linkPreview.text = "   " +  url + "   ";
linkPreview.visible = true;

