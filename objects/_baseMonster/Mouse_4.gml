/// @description attacked by player

if (!field.map_coords.is_same_as_player() || COMBAT != undefined || HIDDEN_BEHIND_POPUP || GUI_POPUP_VISIBLE) exit;

COMBAT = new Combat(GAME.player_object, self, true);
COMBAT.next_round();

