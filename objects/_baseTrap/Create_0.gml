/// @description 

// Inherit the parent event
event_inherited();

states
.add_state("using",
	function(data) {
		var anim = data[$ "trap_anim"] ?? new Animation(self, 0, 150, acTrapFiring)
			.set_scale_is_relative(true)
			.add_frame_trigger(50, function() {
				image_index = 1;
			})
			.add_finished_trigger(function() {
				states.set_state("used");
				var lvldmg = ceil(GAME.level_number / (5 / abs(base_damage)));
				var dmg = base_damage - lvldmg;
				log(sprintf("Trap causes {0} damage: base={1}; ceil={2};", dmg, base_damage, lvldmg));
				GAME.player_data.change_hp(dmg, true);
			});
		data.trap_anim = anim;
		anim.reset();
		
		var si;
		with(GAME.player_object) {
			si = sprite_index;
			sprite_index = asset_get_index(base_sprite_name + "Hit");
		}
		data.sprite_before = si;
	}
)
.add_state("used",
	function(data) {
		image_index = 1;
		if (GAME.player_data.is_alive()) {
			var si = data.sprite_before;
			with(GAME.player_object) {
				sprite_index = si;
			}
		}
	}
)
.add_state("appeared",
	function() {
		return "using";
	}
);
