/// @description 

// Inherit the parent event
event_inherited();

states
.add_state("appeared",
	function() {
		// chests are always locked
		states.set_state("locked");
	}
)
;
