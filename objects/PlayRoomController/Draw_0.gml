/// @description draw keys
for (var i = 0; i < array_length(GAME.player_data.keys); i++) {
	var keydata = GAME.player_data.keys[@ i];
	draw_sprite(keydata.sprite, 0, KEY_RENDER_POS_X, KEY_RENDER_POS_Y + i * 32);
}
