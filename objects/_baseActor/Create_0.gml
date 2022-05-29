/// @description create state machine

// Inherit the parent event
event_inherited();

states = new StateMachine(self);
map_coords = new FieldCoords();
actor_data = undefined;

spawn_xoffset = 0;

image_yscale = ACTOR_SPRITE_HEIGHT / sprite_get_height(sprite_index);
image_xscale = image_yscale;

/// @func set_map_position(xp, yp)
set_map_position = function(xp, yp) {
	map_coords.set(xp, yp);
	x = (ROOM_ARENA_LEFT + 2 * xp + 1 + spawn_xoffset) * MAP_FIELD_SIZE;
	y = (ROOM_ARENA_BOTTOM - 2 * yp) * MAP_FIELD_SIZE;
	log(MY_NAME + sprintf(": Positioning complete: map_pos={0}; screen_pos={1}/{2};", map_coords.toString(), x, y));
}

is_alive = function() {
	if (actor_data != undefined)
		return actor_data.is_alive();
	return false;
}

die = function(through_trap) {
	states.set_state( (!through_trap || !states.state_exists("die_trap")) ? "die" : "die_trap");
}
