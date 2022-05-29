/*
    global game specific macros and constants
*/

// custom events
enum game_event {
	level_creation_done = 0,
	player_enter_field = 1,
	field_unfolded = 2,
	loot_dropped = 3,
}

// Race tables
#macro RACE_FILE_NAME				"map_generator"

#macro RACE_FIELDS_TABLE_NAME		"map_fields"
#macro RACE_ANVIL_TABLE_NAME		"anvil_repair"

// Sprite constants
#macro ACTOR_SPRITE_HEIGHT		144
#macro ITEM_SPRITE_SIZE			100
#macro ITEM_BOTTOM_OFFSET		 24

#macro KEY_RENDER_POS_X			208
#macro KEY_RENDER_POS_Y			336

#macro PLAYER_CHAT_OFFSET_Y		-64
#macro PLAYER_CHAT_OFFSET_X		64

// Layer names
#macro LAYER_EFFECTS			"particles"
#macro LAYER_LOOT				"particles"
#macro LAYER_FIELDS				"fields"
#macro LAYER_ACTORS				"actors"
#macro LAYER_PLAYER				"player"
#macro LAYER_FLOATING			"UI_Floating"
#macro LAYER_POPUP				"popup_instances"

#macro LAYER_TILES_EFFECTS		"tiles_effects"
#macro LAYER_TILES_WALLS_W		"tiles_walls_w"
#macro LAYER_TILES_WALLS_S		"tiles_walls_s"
#macro LAYER_TILES_WALLS_E		"tiles_walls_e"
#macro LAYER_TILES_WALLS_N		"tiles_walls_n"
#macro LAYER_TILES_FIELDS		"tiles_fields"

// Room & Tiles
#macro MAP_FIELD_SIZE			128

// Tileset indices
#macro TILE_INDEX_FLOOR			1
#macro TILE_INDEX_WALL			3
#macro TILE_INDEX_ROOM_CORNER	4
#macro TILE_INDEX_DOOR_OPEN		6
#macro TILE_INDEX_STAIRWAY		8
#macro TILE_INDEX_DOOR_CLOSED	9

// Tile coordinates in play room
#macro ROOM_DOOR_TILE_POS_X		2
#macro ROOM_DOOR_TILE_POS_Y		8

#macro ROOM_ARENA_MAX_FIELDS_X	8
#macro ROOM_ARENA_MAX_FIELDS_Y	4

#macro ROOM_ARENA_TOP			1
#macro ROOM_ARENA_LEFT			3
#macro ROOM_ARENA_RIGHT			18
#macro ROOM_ARENA_BOTTOM		8
#macro ROOM_ARENA_WIDTH			(ROOM_ARENA_RIGHT - ROOM_ARENA_LEFT + 1)
#macro ROOM_ARENA_HEIGHT		(ROOM_ARENA_BOTTOM - ROOM_ARENA_TOP + 1)

// Score modifiers
#macro SCORE_XP_MULTIPLIER		5
#macro SCORE_CHEST_UNLOCK		100
#macro SCORE_CHEST_OPEN			25
#macro SCORE_ANVIL_MULTIPLIER	3
#macro SCORE_LEVEL_EXIT_FAST	250
#macro SCORE_LEVEL_EXIT_MEDIUM	150
#macro SCORE_LEVEL_EXIT_SLOW	75
#macro SCORE_KILL_FIRST_STRIKE	3


// command queueing
#macro LAST_CLICKED_CONTENT		global.last_clicked_content
LAST_CLICKED_CONTENT = undefined;

#macro COMBAT					global.combat
COMBAT = undefined;
