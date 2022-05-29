/// @description set up states

// Inherit the parent event
event_inherited();

if (sprite_width > sprite_height) {
	image_xscale = ITEM_SPRITE_SIZE / sprite_get_width(sprite_index);
	image_yscale = image_xscale;
} else {
	image_yscale = ITEM_SPRITE_SIZE / sprite_get_height(sprite_index);
	image_xscale = image_yscale;
}

// which map field is this (0,0 = bottom left, where the knight starts)
map_coords = new Coord2();
spawn_xoffset = 0.4;
spawn_yoffset = 0;
field = undefined;

/// @func set_map_position(xp, yp)
set_map_position = function(xp, yp) {
	map_coords.set(xp, yp);
	x = (ROOM_ARENA_LEFT + 2 * xp + 1 + spawn_xoffset) * MAP_FIELD_SIZE;
	y = (ROOM_ARENA_BOTTOM - 2* yp + 1 + spawn_yoffset) * MAP_FIELD_SIZE - ITEM_BOTTOM_OFFSET;
	log(MY_NAME + sprintf(": Positioning complete: map_pos={0}; screen_pos={1}/{2};", map_coords.toString(), x, y));
}


states = new StateMachine(self)
.add_state("hidden",
	function() {
		image_alpha = 0;
	}
)
.add_state("appear",
	function(data) {
		var spawn_anim = data[$ "spawn_anim"] ?? 
			new Animation(self, 0, 60, acLinearAlphaIn)
				.add_finished_trigger(function() { 
					states.set_state("appeared"); 
				});
		data.spawn_anim = spawn_anim;
		spawn_anim.reset();
	},
	function() {
	}
)
.add_state("appeared")
.set_state("hidden");
