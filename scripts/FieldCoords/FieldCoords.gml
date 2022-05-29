/*
    short_description_here
*/
function FieldCoords(xp = 0, yp = 0) : Coord2(xp, yp)  constructor{
	
	static is_same_as_player = function() {
		if (GAME.player_object != undefined && instance_exists(GAME.player_object))
			return equals_xy(GAME.player_object.map_coords);
		return false;
	}

}