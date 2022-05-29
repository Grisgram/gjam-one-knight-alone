/*
    Gametime Data counts minutes (per move) and the remaining hours of the game
*/
function TimeData() constructor {

	hour   = 6;
	minute = 0;
	
	time_string = "6:00pm";
	
	static player_moved = function() {
		var plus = max(2, 6 - GAME.level_number);
		minute += plus;
		if (minute >= 60) {
			// TODO: Die due to time
			GAME.player_object.die_through_time();
			minute -= 60;
			hour++;
		}
		__update_time_string();
		GAME.player_data.value_changed = true;
	}
	
	static start_next_hour = function() {
		GAME.player_data.value_changed = true;
		minute = 0;
		hour++;
		__update_time_string();
		if (hour == 19) {
			ROOMCONTROLLER.game_over(true);
			return false;
		}
		return true;
	}
	
	static get_level_time_frame_string = function() {
		var hr = hour > 12 ? hour - 12 : hour;
		var ampm = hour > 11 ? "am" : "pm"
		return sprintf("{0}:00{1} - {2}:59{3}", hr, ampm, hr, ampm);
	}
	
	static __update_time_string = function() {
		time_string = sprintf("{0}:{1}{2}{3}m", hour > 12 ? hour - 12 : hour, minute < 10 ? "0" : "", minute, hour > 12 ? "a" : "p");
	}
	
}