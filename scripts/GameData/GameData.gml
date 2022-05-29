/*
	This struct holds all information about the running game
*/

function GameData() constructor {

	player_object = undefined;
	player_data = new PlayerData(undefined);
	
	time_data = new TimeData();
	
	level_string = "Level 0";
	level_number = 0; // this will be increased to 1 when rmCreateLevel starts
	level_data = undefined;
	
	static increase_level = function() {
		level_number++;
		level_string = sprintf(LG("play_strings/level_number"), level_number);
		player_data.value_changed = true;
	}
	
	static is_level_running = function() {
		return GAME.level_data != undefined && GAME.level_data.level_running;
	}

}