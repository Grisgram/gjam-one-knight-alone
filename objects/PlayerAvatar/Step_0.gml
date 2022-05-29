/// @description set sprite

if (GAME.player_object != undefined && instance_exists(GAME.player_object) && GAME.player_object.is_alive())
	sprite_index = GAME.player_object.avatar_sprite;
