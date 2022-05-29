/*
    draws the tiles (incl mirroring/rotation) for one map field
	
		Corner  Tile	Wall
		LT		ROT+Y	N ROT+Y
		RT		Y		E nothing
		LB		X       S ROT
		RB		ROT+X   W X
		
		empty corner	TILE_INDEX_ROOM_CORNER
		wall			TILE_INDEX_WALL
*/

function draw_field_tiles(field) {
	var fx = ROOM_ARENA_LEFT   + 2 * field.map_coords.x;
	var fy = ROOM_ARENA_BOTTOM - 2 * field.map_coords.y;

	static clear_tile = function(layername, xp, yp) {
		var lay_id = layer_get_id(layername);
	    var map_id = layer_tilemap_get_id(lay_id);
		var data = tilemap_get(map_id, xp, yp);
		data = tile_set_index(data, 0);
		tilemap_set(map_id, data, xp, yp);
	}

	static set_tile_wall = function(layername, xp, yp, mirrorx, flipy, rotate) {
		var lay_id = layer_get_id(layername);
	    var map_id = layer_tilemap_get_id(lay_id);
		var data = tilemap_get(map_id, xp, yp);
		data = tile_set_index(data, TILE_INDEX_WALL);
		if (mirrorx) data = tile_set_mirror(data, true);
		if (flipy) data = tile_set_flip(data, true);
		if (rotate) data = tile_set_rotate(data, true);
		tilemap_set(map_id, data, xp, yp);
	}
	
	// clear all walls
	for (var yy = 0; yy < 2; yy++) {
		for (var xx = 0; xx < 2; xx++) {
			clear_tile(LAYER_TILES_WALLS_N, fx + xx, fy - yy);
			clear_tile(LAYER_TILES_WALLS_E, fx + xx, fy - yy);
			clear_tile(LAYER_TILES_WALLS_S, fx + xx, fy - yy);
			clear_tile(LAYER_TILES_WALLS_W, fx + xx, fy - yy);
		}
	}
	
	// walls array order is NESW
	if (field.walls[0]) {
		set_tile_wall(LAYER_TILES_WALLS_N, fx    , fy - 1, true, false, true);
		set_tile_wall(LAYER_TILES_WALLS_N, fx + 1, fy - 1, true, false, true);
	}
	if (field.walls[1]) {
		set_tile_wall(LAYER_TILES_WALLS_E, fx + 1, fy    , false, false, false);
		set_tile_wall(LAYER_TILES_WALLS_E, fx + 1, fy - 1, false, false, false);
	}
	if (field.walls[2]) {
		set_tile_wall(LAYER_TILES_WALLS_S, fx    , fy    , false, false, true);
		set_tile_wall(LAYER_TILES_WALLS_S, fx + 1, fy    , false, false, true);
	}
	if (field.walls[3]) {
		set_tile_wall(LAYER_TILES_WALLS_W, fx    , fy    , true, false, false);
		if (field.map_coords.x + field.map_coords.y > 0) // leave the door field open
			set_tile_wall(LAYER_TILES_WALLS_W, fx    , fy - 1, true, false, false);
	}
}


