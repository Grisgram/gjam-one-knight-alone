/// @description create states
event_inherited();

image_alpha = 0;

// NESW
walls = [ false, false, false, false ];

// which map field is this (0,0 = bottom left, where the knight starts)
map_coords = new FieldCoords();
is_part_of_level = true;

contents = undefined;

/// @func set_map_position(xp, yp)
set_map_position = function(xp, yp) {
	map_coords.set(xp, yp);
	x = (ROOM_ARENA_LEFT + 2 * xp + 1) * MAP_FIELD_SIZE;
	y = (ROOM_ARENA_BOTTOM - 2 * yp) * MAP_FIELD_SIZE;
	log(MY_NAME + sprintf(": Positioning complete: map_pos={0}; screen_pos={1}/{2};", map_coords.toString(), x, y));
}

is_neighbour_of_player = function(ignore_walls = true) {
	var px = GAME.player_object.map_coords.x;
	var py = GAME.player_object.map_coords.y;
	var myx = map_coords.x;
	var myy = map_coords.y;

	if (px == myx && py == myy)
		return false;

	return 
		(px == myx && py == myy - 1 && (ignore_walls || !walls[2])) ||
		(px == myx && py == myy + 1 && (ignore_walls || !walls[0])) ||
		(py == myy && px == myx - 1 && (ignore_walls || !walls[3])) ||
		(py == myy && px == myx + 1 && (ignore_walls || !walls[1]));

}

unfold_neighbours = function() {
	static __unfold_neighbour = function(xp, yp) {
		var fld = GAME.level_data.get_field_xy(xp, yp);
		if (fld != undefined)
			with (fld)
				if (states.active_state.name == "idle_fog")
					states.set_state("unfold");
	}

	__unfold_neighbour(map_coords.x - 1, map_coords.y    );
	__unfold_neighbour(map_coords.x + 1, map_coords.y    );
	__unfold_neighbour(map_coords.x    , map_coords.y - 1);
	__unfold_neighbour(map_coords.x    , map_coords.y + 1);

}

/// @func set_walls(wall_n = false, wall_e = false, wall_s = false, wall_w = false)
set_walls = function(wall_n = false, wall_e = false, wall_s = false, wall_w = false) {
	walls = [wall_n, wall_e, wall_s, wall_w];
	log(MY_NAME + sprintf(": Wall setup complete: walls={0}", walls));
	draw_field_tiles(self);
	if (map_coords.x + map_coords.y > 0)
		states.set_state("spawn");
}

states = new StateMachine(self)
.add_state("spawn",
	function(data) {
		var spawn_anim = data[$ "spawn_anim"] ?? 
			new Animation(self, 6 * min(x,y)/MAP_FIELD_SIZE, 60, acLinearAlphaIn)
				.add_finished_trigger(function() { 
					states.set_state("idle_fog"); 
				});
		data.spawn_anim = spawn_anim;
		spawn_anim.reset();
	},
	function() {
	}
)
.add_state("idle_fog",
	function(data) {
		image_alpha = 1;
		var idle_anim = data[$ "idle_anim"] ?? 
			new Animation(self, 0, 120, acFogAlpha, -1);
		data.idle_anim = idle_anim;
		idle_anim.reset();
	},
	function() {
	}
)
.add_state("unfold",
	function(data) {
		GAME.player_data.gain_xp(1);
		abort_anim(data, "spawn_anim");
		abort_anim(data, "idle_anim");
		var despawn_anim = data[$ "despawn_anim"] ?? 
			new Animation(self, 0, 30, acFogDisappear)
				.add_finished_trigger(function() { 
					image_alpha = 0;
					states.set_state("open");
					if (contents != undefined)
						with(contents) event_user(game_event.field_unfolded);
					//broadcast_user_event(game_event.field_unfolded);
				});
		data.despawn_anim = despawn_anim;
		despawn_anim.reset();		
	},
	function() {
	}
)
.add_state("open",
	function() {
		image_xscale = 1;
		image_yscale = 1;
	}
);


