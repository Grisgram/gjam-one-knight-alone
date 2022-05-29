/// @description 

// Inherit the parent event
event_inherited();

states.add_state("dropped",
	function() {
		var val = data.race_data.attributes.value;
		
		GAME.player_data.gain_xp_buff(val);

		new Animation(self,0,60,acLinearAlphaOut)
			.add_finished_trigger(function() { 
				states.set_state("done");
			});		
	}
);
