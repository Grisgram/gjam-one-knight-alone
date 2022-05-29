/// @description 

// Inherit the parent event
event_inherited();

// update all display values
if (GAME.player_data.value_changed) {
	GAME.player_data.value_changed = false;
	
	var timecol = c_white;
	var ticker_index = -1;
	if (GAME.time_data.minute >= 45) {
		timecol = c_red;
		ticker_index = 1;
	} else if (GAME.time_data.minute >= 30) {
		timecol = c_yellow;
		ticker_index = 0;		
	}
	
	clockTicker.visible = (ticker_index != -1);
	clockTicker.image_index = ticker_index;

	if (clockTicker.visible && ticker_anim == undefined) { 
		var gtx, gty;
		with(lblGameTime) {
			gtx = SELF_VIEW_CENTER_X;
			gty = SELF_VIEW_CENTER_Y;
		}
		with(clockTicker) {
			x = gtx;
			y = gty;
		}
		ticker_anim = new Animation(clockTicker, 0, 45, acClockTicker, -1);
	}

	lblGameTime.text_color = timecol;
	lblGameTime.text_color_mouse_over = timecol;
	lblGameTime.text = GAME.time_data.time_string;

	lblScore.text = string(GAME.player_data.points);
	lblLevel.text = GAME.level_string;
	lblXP.text = sprintf("{0}/{1}", max(0, floor(GAME.player_data.xp)), floor(GAME.player_data.xp_to_next));
	lblPlayerLevel.text = string(GAME.player_data.level);

}

if (remainings_changed) {
	remainings_changed = false;
	
	lblTreasureRemaining.text = string(GAME.level_data.get_treasure_count());
	lblMonstersRemaining.text = string(GAME.level_data.get_monster_count());
}
