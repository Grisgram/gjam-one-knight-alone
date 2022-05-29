/// @description 

// Inherit the parent event
event_inherited();

states
.add_state("usable")
.add_state("using")
.add_state("appeared",
	function() {
		// usables are always usable!
		states.set_state("usable");
	}
)
.add_state("used",
	function() {
		image_alpha = 0.5;
	}
);
