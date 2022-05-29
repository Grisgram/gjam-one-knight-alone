/// @description 

// Inherit the parent event
event_inherited();
spawn_xoffset = 0;
spawn_yoffset = 0;
image_xscale = 1;
image_yscale = 1;

states
.add_state("locked",
	function() {
		image_index = 0;
	},
	function() {
		var monsters = GAME.level_data.get_monster_count();
		var treasures = GAME.level_data.get_treasure_count();
		if (monsters == 0 || treasures == 0) states.set_state("usable");
	}
)
.add_state("usable",
	function() {
		if (!field.map_coords.is_same_as_player()) {
			with (GAME.player_object)
				floating_text(self, LG("player_strings/exit_unlocked"),,PLAYER_CHAT_OFFSET_Y);
		}
		image_index = 1;
	}
)
.add_state("using",
	function() {
		with (GAME.player_object) {
			sprite_index = asset_get_index(base_sprite_name + "Walk");
			new Animation(self,0,60,acPlayerLeaveRoom)
				.set_scale_is_relative(true)
				.add_finished_trigger(function() {
					var sc = SCORE_LEVEL_EXIT_FAST;
					if (GAME.time_data.minute >= 30) sc = SCORE_LEVEL_EXIT_MEDIUM;
					if (GAME.time_data.minute >= 45) sc = SCORE_LEVEL_EXIT_SLOW;
					GAME.player_data.gain_score(sc);
					
					ROOMCONTROLLER.level_complete();
				});		
		}
	}
)
.add_state("appeared",
	function() {
		// usables are always usable!
		var total =
			GAME.level_data.get_monster_count() +
			GAME.level_data.get_treasure_count();
		
		states.set_state(total > 0 ? "locked" : "usable");
	}
)

