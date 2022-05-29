/// @description 

// Inherit the parent event
event_inherited();

orig_sprite_name = sprite_get_name(sprite_index);

drop_loot = function() {
	if (attributes.contents != "") {
		var res = race_query(attributes.contents, LAYER_LOOT);
		if (array_length(res) == 0) {
			floating_text(GAME.player_object, LG("player_strings/loot_empty"),,PLAYER_CHAT_OFFSET_Y);
		} else {
			for (var i = 0; i < array_length(res); i++) {
				var inst = res[@ i].instance;
				with (inst) {
					states.data.container = other;
					states.set_state("drop");
				}
			}
		}
	}
}

reset_knight_anim = function(sprite_before) {
	var si = sprite_before;
	with (GAME.player_object)
		sprite_index = si;
}

states
.add_state("closed")
.add_state("locked",,,
	function() {
		// this is the leave function
		GAME.player_data.gain_score(SCORE_CHEST_UNLOCK);
	}
)
.add_state("opening",
	function(data) {
		var si;
		GAME.player_data.gain_score(SCORE_CHEST_OPEN);
		GAME.player_data.gain_xp(xp_for_opening);
		with (GAME.player_object) {
			si = sprite_index;
			image_xscale = abs(image_xscale);
			sprite_index = sprKnightAttackDeadly;
		}
		data.sprite_before = si;
		data.wait_for_chest = true;
		data.opening_frame = 0;
	},
	function(data) {
		data.opening_frame++;
		
		if (data.opening_frame >= 28) 
			reset_knight_anim(data.sprite_before);
			
		if (data.wait_for_chest) {
			// frame 12 of the deadly-attack anim holds the sword far right
			if (data.opening_frame == 12) {
				sprite_index = asset_get_index(orig_sprite_name + "Anim");
				data.wait_for_chest = false;
			}
		} else {
			if (data.animation_end) {
				reset_knight_anim(data.sprite_before);
				ROOMCONTROLLER.remainings_changed = true;
				drop_loot();
				return "open";
			}
		}
	}
)
.add_state("open",
	function() {
		sprite_index = asset_get_index(orig_sprite_name + "Open");
	}
)
;

