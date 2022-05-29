/// @description spawn anim

// Inherit the parent event
event_inherited();

states
.add_state("hidden",
	function() {
		sprite_index = sprZombieSpawn;
		image_index = 0;
		image_alpha = 0;
	}
)
.add_state("spawn",
	function(data) {
		data.animation_end = false;
		image_alpha = 1;
		sprite_index = sprZombieSpawn;
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		if (data.animation_end) return "idle";
	}
)
.add_state("die",
	function(data) {
		tooltip_hide(Tooltip);
		data.animation_end = false;
		sprite_index = sprZombieDie;
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		if (data.animation_end) {
			var k = actor_data.keys;
			with (GAME.player_object) receive_keys(k);
			ROOMCONTROLLER.remainings_changed = true;
			instance_destroy();
		}
	}
)
.add_state("hit",
	function(data) {
		sprite_index = sprZombieIdle;
		image_index = 0;
		image_speed = 1;
		var anim = data[$ "hit_anim"] ??
			new Animation(self, 0, 30, acMonsterHit)
				.set_move_distance(1, 0)
				.add_finished_trigger(function() {
					COMBAT.apply_damage();
				});
		data.hit_anim = anim;
		anim.reset();
	}
)
.add_state("idle",
	function() {
		sprite_index = sprZombieIdle;
		image_index = 0;
		image_speed = 1;
	},
	function() {
		static frame = 0;
		
		frame++;
		if (frame mod 120 == 0) {
			frame = 0;
			//return "walk";
		}
	}
)
.add_state("walk",
	function() {
		sprite_index = sprZombieWalk;
		image_index = 0;
		image_speed = 1;
	},
	function() {
		static frame = 0;
		
		frame++;
		if (frame mod 240 == 0) {
			frame = 0;
			return "attack";
		}
	}
)
.add_state("attack",
	function(data) {
		data.animation_end = false;
		sprite_index = sprZombieAttack;
		image_index = 0;
	},
	function(data) {
		static frame = 0;
		frame++;
		if (frame == 3)
			COMBAT.other_fighter.states.set_state("hit");
		if (data.animation_end) {
			frame = 0;
			data.animation_end = false;
			return "idle";
		}
	}
)
.set_state("hidden");
