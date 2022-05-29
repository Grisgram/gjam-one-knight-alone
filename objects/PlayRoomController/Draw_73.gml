/// @description debug draw

// Inherit the parent event
event_inherited();

draw_set_font(acme28);
draw_text(2200,1180,"Animpool size: " + string(__ANIMATION_POOL.size()));
draw_text(2200,1230,"StateMachines: " + string(__STATE_MACHINES.size()));

if (GAME.level_number == 0) create_level();


