/// @description spawn anim

// Inherit the parent event
event_inherited();

states
.add_state("hidden",
	function() {
		sprite_index = sprSkeletonSpawn;
		image_index = 0;
		image_alpha = 0;
	}
)
.add_state("spawn",
	function(data) {
		data.animation_end = false;
		image_alpha = 1;
		sprite_index = sprSkeletonSpawn;
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
		sprite_index = sprSkeletonDie;
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
		sprite_index = sprSkeletonIdle;
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
	},
)
.add_state("idle",
	function(data) {
		data.frame = 0;
		sprite_index = sprSkeletonIdle;
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		data.frame++;
		if (data.frame mod 120 == 0) {
			data.frame = 0;
			//return "walk";
		}
	}
)
.add_state("walk",
	function(data) {
		data.frame = 0;
		sprite_index = sprSkeletonWalk;
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		data.frame++;
		if (data.frame mod 240 == 0) {
			data.frame = 0;
			return "attack";
		}
	}
)
.add_state("attack",
	function(data) {
		data.frame = 0;
		data.animation_end = false;
		sprite_index = sprSkeletonAttack;
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		data.frame++;
		if (data.frame == 3)
			COMBAT.other_fighter.states.set_state("hit");
		if (data.animation_end) {
			frame = 0;
			data.animation_end = false;
			return "idle";
		}
	}
)
.set_state("hidden");
