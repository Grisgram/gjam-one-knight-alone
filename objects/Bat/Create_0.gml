/// @description spawn anim

// Inherit the parent event
event_inherited();

states
.add_state("hidden",
	function() {
		sprite_index = sprVampireBat;
		image_index = 0;
		image_alpha = 0;
	}
)
.add_state("spawn",
	function(data) {
		data.animation_end = false;
		image_alpha = 1;
		sprite_index = sprVampireBat;
		image_index = 0;
		image_speed = 1;
		image_alpha = 0;
		
		abort_anim(data, "idle_anim");
		var spawn_anim = data[$ "spawn_anim"] ?? 
			new Animation(self, 0, 90, acLinearAlphaIn)
				.add_finished_trigger(function() { 
					states.set_state("idle"); 
				});
		data.spawn_anim = spawn_anim;
		spawn_anim.reset();
	},
	function(data) {
	}
)
.add_state("die",
	function(data) {
		tooltip_hide(Tooltip);
		data.animation_end = false;
		sprite_index = sprVampireBat;
		image_index = 0;
		image_speed = 1;
		
		abort_anim(data, "idle_anim");
		var despawn_anim = data[$ "despawn_anim"] ?? 
			new Animation(self, 0, 90, acLinearAlphaOut)
				.add_finished_trigger(function() { 
					explosion_start_scaled_to(sprSmokeMediumGrey69x73, LAYER_EFFECTS, sprite_width, sprite_height);
					ROOMCONTROLLER.remainings_changed = true;
					instance_destroy(); 
				});
		data.despawn_anim = despawn_anim;
		despawn_anim.reset();
		var k = actor_data.keys;
		with (GAME.player_object) receive_keys(k);
	}
)
.add_state("hit",
	function(data) {
		sprite_index = sprVampireBat;
		image_index = 0;
		image_speed = 1;
		abort_anim(data, "idle_anim");
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
	function(data) {
		data.frame = 0;
		data.locked = 180;
		sprite_index = sprVampireBat;
		image_index = 0;
		image_speed = 1;
		
		var idle_anim = data[$ "idle_anim"] ?? 
			new Animation(self, 0, 120, acBatFlight, -1)
				.set_move_distance(1, 1);
		data.idle_anim = idle_anim;
		idle_anim.reset();
	},
	function(data) {
		data.locked--;
		if (data.locked <= 0)
			data.frame++;
		if (data.locked <= 0 && race_random_percent_hit(data.frame / 100)) {
			image_xscale = -image_xscale;
			data.frame = 0;
			data.locked = 120;
		}
	}
)
.add_state("walk",
	function() {
		sprite_index = sprVampireBat;
		image_index = 0;
		image_speed = 1;
	}
)
.add_state("attack",
	function(data) {
		data.frame = 0;
		data.animation_end = false;
		sprite_index = sprVampireBat;
		image_index = 0;
		abort_anim(data, "idle_anim");
	},
	function(data) {
		data.frame++;
		logd("ATTACK-FRAME", data.frame);
		if (data.frame == 3)
			COMBAT.other_fighter.states.set_state("hit");
//		if (data.animation_end) {
			//data.frame = 0;
			data.animation_end = false;
//		}
	}
)
.set_state("hidden");
