/// @description 

// Inherit the parent event
event_inherited();

states = new StateMachine(self)
.add_state("drop",
	function(data) {
		var cx, cy;
		with(data.container) {
			cx = x;
			cy = y;
		}
		x = cx;
		y = cy;
		
		var anim = data[$ "drop_anim"] ??
			new Animation(self, 0, irandom_range(100,200),acLootDrop)
				.set_move_distance(0, 1)
				.add_started_trigger(function() {
					hspeed = random_range(-2.0, -0.5);
				})
				.add_finished_trigger(function() {
					hspeed = 0;
					states.set_state("dropped");
				});
		data.drop_anim = anim;
		anim.reset();
	}
)
.add_state("dropped")
.add_state("done",
	function(data) {
		instance_destroy(); 
		with(data.container)
			states.set_state("used");
	}
);



