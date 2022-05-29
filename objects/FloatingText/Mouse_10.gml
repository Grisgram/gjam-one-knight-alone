/// @description don't forward if anim

if (in_animation() || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;
event_inherited();

