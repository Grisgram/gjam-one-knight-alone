/*
	holds a level - construct with a level size.
*/

function LevelData(level_number) constructor {
	level_running = false;
	
	// define level dimensions
	fields_x = min(8, 3 + (level_number div 2));
	fields_y = level_number < 3 ? 3 : 4;
	
	fields = array_create(ROOM_ARENA_MAX_FIELDS_X);
	
	// create the empty fields array
	for (var i = 0; i < array_length(fields); i++)
		fields[@ i] = array_create(ROOM_ARENA_MAX_FIELDS_Y, undefined);
	
	// Fill the fields array with a random level
	create_random_level(level_number, fields_x, fields_y, fields);
	
	static get_field_at = function(coord) {
		return get_field_xy(coord.x, coord.y);
	}
	
	static get_field_xy = function(xp, yp) {
		if (xp < 0 || xp >= fields_x || yp < 0 || yp >= fields_y)
			return undefined;
		return fields[@ xp][@ yp];
	}

	/// @function get_monster_count()
	static get_monster_count = function() {
		return instance_number(_baseMonster);
	}
	
	/// @function get_treasure_count()
	static get_treasure_count = function() {
		var rv = 0;
		with (_baseTreasure) {
			if (states.active_state != undefined && states.active_state.name != "open")
				rv++;
		}
		return rv;
	}

	/// @function get_monsters()
	static get_monsters = function() {
		var rv = array_create(get_monster_count(), undefined);
		var i = 0;
		with (_baseMonster) {
			rv[@ i] = self;
			i++;
		}
		return rv;
	}
	
}