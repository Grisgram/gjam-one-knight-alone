/// @description 

// Inherit the parent event
event_inherited();

#macro PLAY_PARTICLES	global.play_particles
PLAY_PARTICLES = new ParticleManager(LAYER_EFFECTS);

TOOLTIP_LAYER = "UI_Floating";

remainings_changed = false;
ticker_anim = undefined;

/// @function create_level(level_number)
create_level = function() {
	// reset everything
	animation_clear_pool();
	remainings_changed = false;
	ticker_anim = undefined;
	
	// delete all level objects, so we can start over
	with(_baseActor)		instance_destroy();
	with(_baseFieldContent) instance_destroy();
	with(_baseMapField)		instance_destroy();
	with(FloatingText)		instance_destroy();
	
	// First create the player - based on armed or not
	// it stays hidden until level generation finishes
	GAME.player_object = instance_create_layer(0, 0, LAYER_PLAYER, Knight);
	GAME.player_data.owner = GAME.player_object;
	
	with (GAME.player_object)
		set_armed();
	
	GAME.increase_level();
	GAME.level_data = new LevelData(GAME.level_number);
	broadcast_user_event(game_event.level_creation_done);
	remainings_changed = true;
	create_level_start_popup();
}

level_complete = function() {
	GAME.level_data.level_running = false;
	if (GAME.time_data.start_next_hour()) 
		create_level();
}

game_over = function(won) {
	create_game_over_popup(won);
}
