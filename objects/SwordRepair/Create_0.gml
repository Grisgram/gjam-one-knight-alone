/// @description 

// Inherit the parent event
event_inherited();

states.add_state("dropped",
	function() {
		var val = data.race_data.attributes.value;
		var msg = data.race_data.attributes.message;

		floating_text(GAME.player_object,LG(msg),,PLAYER_CHAT_OFFSET_Y, 90);
		GAME.player_data.change_weapon(val);

		new Animation(self,0,60,acLinearAlphaOut)
			.add_finished_trigger(function() { 
				states.set_state("done");
			});		
	}
);
