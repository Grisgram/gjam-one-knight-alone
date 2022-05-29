/// @description 

// Inherit the parent event
event_inherited();

actor_data = GAME.player_data;
avatar_sprite = sprKnightArmedIdle;
base_sprite_name = "sprKnightArmed";
is_armed = true;

spawn_xoffset = -0.25;

states.data.move_target = new FieldCoords();
states.data.map_move_target = new FieldCoords();

prev_map_coords = new FieldCoords();

set_armed = function() {
	var armed = actor_data.weapon > 0;
	if (armed) {
		base_sprite_name = "sprKnightArmed";
		avatar_sprite = sprKnightArmedIdle;
		if (!is_armed) { // change sprite
			var sn = sprite_get_name(sprite_index);
			sn = string_replace(sn, "sprKnight", base_sprite_name);
			sprite_index = asset_get_index(sn);
		}
	} else {
		base_sprite_name = "sprKnight";
		avatar_sprite = sprKnightIdle;
		if (is_armed) { // change sprite
			var sn = sprite_get_name(sprite_index);
			sn = string_replace(sn, "sprKnightArmed", base_sprite_name);
			sprite_index = asset_get_index(sn);
		}
	}
	is_armed = armed;
}

move = function(movex, movey, run) {
	states.data.map_move_target.set(movex, movey);
	states.data.move_target.set(
		(ROOM_ARENA_LEFT + 2 * movex + 1 + spawn_xoffset) * MAP_FIELD_SIZE,
		(ROOM_ARENA_BOTTOM - 2 * movey) * MAP_FIELD_SIZE);
	states.set_state(run ? "run" : "walk");
}

die_through_time = function() {
	states.set_state("die_time");
}

receive_keys = function(monster_keys) {
	if (array_length(monster_keys) == 0) return;
	
	floating_text(self, LG("player_strings/key_found*"),,-sprite_height/2,120,0.5);
	for (var i = 0; i < array_length(monster_keys); i++) {
		array_push(actor_data.keys, monster_keys[@ i]);
		actor_data.value_changed = true;
	}
}

unlock_chest = function(chestname) {
	var to_remove = -1;
	for (var i = 0; i < array_length(actor_data.keys); i++) {
		var k = actor_data.keys[@ i];
		var toname;
		with (k.target_object) 
			toname = MY_NAME;
		if (chestname == toname) {
			floating_text(self, LG("player_strings/chest_unlocked*"),,-sprite_height/2,120,0.5);
			with (k.target_object) 
				states.set_state("opening");
			break;
		}
	}
	if (to_remove != -1) {
		array_delete(actor_data.keys, to_remove, 1);
		actor_data.value_changed = true;
		return true;
	}
	return false;
}

states
.add_state("die",
	function(data) {
		data.animation_end = false;
		sprite_index = asset_get_index(base_sprite_name + "Die");
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		if (data.animation_end) {
			instance_destroy();
			ROOMCONTROLLER.game_over(false);
		}
	}
)
.add_state("die_trap",
	function(data) {
		data.animation_end = false;
		sprite_index = asset_get_index(base_sprite_name + "DieTrap");
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		if (data.animation_end) {
			instance_destroy();
			ROOMCONTROLLER.game_over(false);
		}
	}
)
.add_state("die_time",
	function(data) {
		// this will create undead flying animations that eat the player until it is dead
		data.animation_end = false;
		sprite_index = asset_get_index(base_sprite_name + "Die");
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		if (data.animation_end) {
			instance_destroy();
			ROOMCONTROLLER.game_over(false);
		}
	}
)
.add_state("idle",
	function() {
		sprite_index = asset_get_index(base_sprite_name + "Idle");
		image_index = 0;
		image_speed = 1;
		hspeed = 0;
		set_map_position(map_coords.x, map_coords.y);
		
		if (map_coords.x != prev_map_coords.x || map_coords.y != prev_map_coords.y) {
			prev_map_coords.set(map_coords.x, map_coords.y);
			var fld = GAME.level_data.get_field_at(map_coords);
			with(fld)
				event_user(game_event.player_enter_field);
			if (GAME.player_data.is_alive())
				GAME.time_data.player_moved();
		}
	}
)
.add_state("walk",
	function(data) {
		sprite_index = asset_get_index(base_sprite_name + "Walk");
		image_index = 0;
		image_speed = 1;
		
		image_xscale = (data.map_move_target.x >= map_coords.x) ? abs(image_xscale) : -abs(image_xscale);
		
		var anim = data[$ "move_walk_anim"] ?? 
			new Animation(self, 0, 40, acLinearMoveXY)
				.add_finished_trigger(function() { 
					// walk finished, we don't attack, we idle
					set_map_position(states.data.map_move_target.x,states.data.map_move_target.y);
					states.set_state("idle");
				});
		data.move_walk_anim = anim;
		anim.reset().set_move_target(data.move_target.x, data.move_target.y);

	}
)
.add_state("run",
	function() {
		sprite_index = asset_get_index(base_sprite_name + "Run");
		image_index = 0;
		image_speed = 1;

		image_xscale = (data.map_move_target.x >= map_coords.x) ? abs(image_xscale) : -abs(image_xscale);

		var anim = data[$ "move_run_anim"] ?? 
			new Animation(self, 0, 25, acLinearMoveXY)
				.add_finished_trigger(function() { 
					// walk finished, we attack!
					set_map_position(data.map_move_target.x,data.map_move_target.y);
					states.set_state("attack"); 
				});
		data.move_run_anim = anim;
		anim.reset().set_move_target(data.move_target.x, data.move_target.y);
	}
)
.add_state("hit",
	function(data) {
		data.animation_end = false;
		sprite_index = asset_get_index(base_sprite_name + "Hit");
		image_index = 0;
		image_speed = 1;
	},
	function(data) {
		if (data.animation_end) {
			COMBAT.apply_damage();
		}
	}
)
.add_state("attack",
	function(data) {
		if (COMBAT.other_fighter.actor_data.is_attack_deadly(actor_data.get_damage_dealt()))
			return "attack_deadly";
		
		// we have only 1 attack anim and its positioned for unarmed
		// so we cheat a little with the coordinates here
		data.frame = 0;
		data.xstart = x;
		data.ystart = y;
		if (base_sprite_name == "sprKnightArmed")
			x -= 28; // tweak for odd-sized sprite
		data.animation_end = false;
		sprite_index = sprKnightAttack;
		image_index = 0;
		image_xscale = abs(image_xscale);
	},
	function(data) {
		data.frame++;
		if (data.frame == 2)
			COMBAT.other_fighter.states.set_state("hit");
		if (data.animation_end) {
			actor_data.change_weapon(-1);
			data.frame = 0;
			data.animation_end = false;
			x = data.xstart;
			y = data.ystart;
			return "idle";
		}
	}
)
.add_state("attack_deadly",
	function(data) {
		data.frame = 0;
		data.was_at_full_hp = COMBAT.other_fighter.actor_data.is_at_full_hp();
		data.xstart = x;
		data.animation_end = false;
		sprite_index = sprKnightAttackDeadly;
		image_index = 0;
		hspeed = -1.25;
		image_xscale = abs(image_xscale);
	},
	function(data) {
		data.frame++;
		if (data.frame == 11)
			COMBAT.other_fighter.states.set_state("hit");
		if (data.animation_end) {
			actor_data.change_weapon(-2);
			data.frame = 0;
			data.animation_end = false;
			x = data.xstart;
			hspeed = 0;
			var odata = COMBAT.other_fighter.actor_data;
			var multi = data.was_at_full_hp ? SCORE_KILL_FIRST_STRIKE : 1;
			actor_data.gain_xp(odata.level + odata.max_hp);
			actor_data.gain_score(multi * odata.level * (odata.max_hp + odata.max_shield));
			return "idle";
		}
	}
)
.add_state("level_up",
	function(data) {
		data.xstart = x;
		data.animation_end = false;
		sprite_index = sprKnightAttackDeadly;
		image_index = 0;
		hspeed = -1.25;
		image_xscale = abs(image_xscale);
		new Animation(self, 0, 30, acPlayerHeal).set_scale_is_relative(true);
		floating_text(self, LG("player_strings/level_up"),,-96,,,c_white);
	},
	function(data) {
		if (data.animation_end) {
			data.animation_end = false;
			x = data.xstart;
			hspeed = 0;
			return "idle";
		}
	}
)
.add_state("spawn",
	function(data) {
		// this is an excessive "enter-the-level" animation
		data.animation_end = false;
		sprite_index = asset_get_index(base_sprite_name + "Walk");
		image_index = 0;
		image_speed = 1;
		image_alpha = 0;
		image_xscale = 0.12;
		image_yscale = 0.12;
		x = 308;
		y = 1137;
		
		var anim = data[$ "spawn_anim"] ?? 
			new Animation(self, 0, 150, acPlayerSpawn)
				.add_finished_trigger(function() { 
					states.set_state("spawn_open_door"); 
				})
				.set_move_target(0, 964);
		data.spawn_anim = anim;
		anim.reset();
		
	}
)
.add_state("spawn_open_door",
	function(data) {
		// TODO Door animation
	},
	function() {
		// TODO remove this if door animation done
		return "spawn_enter_room";
	}
)
.add_state("spawn_enter_room",
	function(data) {
		sprite_index = asset_get_index(base_sprite_name + "Run");
		image_index = 0;
		image_speed = 1;
		
		var anim = data[$ "enter_anim"] ?? 
			new Animation(self, 0, 45, acPlayerEnterRoom)
				.add_finished_trigger(function() { 
					set_map_position(0, 0);
					states.set_state("idle");
					with (GAME.level_data.get_field_xy(0, 0))
						event_user(game_event.player_enter_field);
						// now... and only now level is running!
					GAME.level_data.level_running = true;
				});
		data.enter_anim = anim;
		anim.reset()
			.set_move_target((ROOM_ARENA_LEFT + 1 + spawn_xoffset) * MAP_FIELD_SIZE, (ROOM_ARENA_BOTTOM) * MAP_FIELD_SIZE);
		
	}
)
;
