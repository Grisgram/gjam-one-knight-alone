/// @description player enters this field

if (COMBAT != undefined)
	COMBAT.end_combat();

if (contents != undefined)
	with(contents) {		
		event_user(game_event.player_enter_field);
	}

unfold_neighbours();

