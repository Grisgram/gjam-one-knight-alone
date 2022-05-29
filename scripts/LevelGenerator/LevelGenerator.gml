/*
    Create a random level with a specified size.
	The levelnumber is a multiplier for the amount of monsters, traps and
	the general danger of the level that will be created now.
*/

#macro RACE_EXIT_FIELD_ASSET_NAME	"ExitField"

function create_random_level(level_number, sizex, sizey, fields) {

	var tbl = race_table_reset(RACE_FIELDS_TABLE_NAME);
	// x * y -1 because field(0,0) is always empty (hero starts there)
	race_table_set_loot_count(tbl, sizex * sizey - 1);
	var result = race_query(RACE_FIELDS_TABLE_NAME, LAYER_FIELDS);

	// Hero start field
	var startfield = instance_create_layer(0, 0, LAYER_FIELDS, EmptyField);
	with (startfield) {
		attributes = {};
		set_map_position(0, 0);
		states.set_state("unfold");
	}
	fields[@ 0][@ 0] = startfield;

	for (var yy = 0; yy < sizey; yy++) {
		for (var xx = 0; xx < sizex; xx++) {
			if (xx + yy == 0) continue;
			var rnd = irandom(array_length(result) - 1);
			var fld = result[@ rnd];
			var tile = fld.instance;
			array_delete(result, rnd, 1);
			with (tile) {
				attributes = fld.attributes ?? {};
				set_map_position(xx,yy);
			}
			fields[@ xx][@ yy] = tile;
		}
	}

	// Fill the level with empty fields (with full walls, they can't be entered
	for (var yy = 0; yy < ROOM_ARENA_MAX_FIELDS_Y; yy++) {
		for (var xx = 0; xx < ROOM_ARENA_MAX_FIELDS_X; xx++) {
			if (xx < sizex && yy < sizey) continue;
			log(sprintf("Creating fake field at {0}/{1}", xx, yy));
			var fakefield = instance_create_layer(0, 0, LAYER_FIELDS, EmptyField);
			with (fakefield) {
				attributes = {};
				set_map_position(xx, yy);
				set_walls(true, true, true, true);
				is_part_of_level = false;
			}
			fields[@ xx][@ yy] = fakefield;
		}
	}

	// TODO: make sure, a path to the exit gets no walls...
	for (var yy = 0; yy < sizey; yy++) {
		for (var xx = 0; xx < sizex; xx++) {
			var tile = fields[@ xx][@ yy];
			tile.set_walls(yy == sizey - 1, xx == sizex - 1, yy == 0, xx == 0);
		}
	}
}

