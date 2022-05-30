/// @description implement using state

// Inherit the parent event
event_inherited();

states.add_state("using",
	function(data) {
		if (GAME.player_data.weapon == 0) {
			floating_text(GAME.player_object, LG("player_strings/anvil_no_sword"),,PLAYER_CHAT_OFFSET_Y);
			GAME.player_data.change_weapon(1);
			change_state_in(self, states, 60, "usable");
		} else if (GAME.player_data.weapon == GAME.player_data.max_weapon) {
			floating_text(GAME.player_object, LG("player_strings/anvil_max_sword"),,PLAYER_CHAT_OFFSET_Y);
		} else {
			var res = race_query("anvil_repair", LAYER_LOOT);
			var inst = res[@ 0].instance;
			with (inst) {
				var si;
				with (GAME.player_object) {
					si = sprite_index;
					image_xscale = abs(image_xscale);
					sprite_index = sprKnightAttack;
				}
				GAME.player_data.gain_score(SCORE_ANVIL_MULTIPLIER * self.data.race_data.attributes.value);
				data.sprite_before = si;
				states.data.container = other;
				states.set_state("drop");
			}
		}
	}
)
.add_state("used",
	function(data) {
		image_alpha = 0.5;
		var si = data.sprite_before;
		with (GAME.player_object) {
			sprite_index = si;
		}
	}
);
