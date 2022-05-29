/// @description level creation done

// Inherit the parent event
event_inherited();

// we appear now (climb up the stairs, open the door, etc)
log(MY_NAME + " enters the level!");
states.set_state("spawn");



