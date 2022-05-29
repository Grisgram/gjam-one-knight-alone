/// @description 

// Inherit the parent event
event_inherited();

states
.add_state("appeared",
	function() {
		// barrels are never locked, they start closed
		states.set_state("closed");
	}
)
;
