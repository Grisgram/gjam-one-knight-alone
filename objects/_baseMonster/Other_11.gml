/// @description start combat (priority!)

// Inherit the parent event
event_inherited();

if (COMBAT != undefined) exit;

COMBAT = new Combat(GAME.player_object, self);
COMBAT.next_round();

