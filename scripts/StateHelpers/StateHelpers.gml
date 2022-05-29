/*
    little helpers for the state machines
*/

function abort_anim(data, name) {
	var anim = data[$ name];
	if (anim != undefined) anim.abort();
}

function broadcast_user_event(event) {
	// inform everybody, that all instances are created
	with (_baseMapField)		event_user(event); // Fields first, they make monsters and chests
	with (_baseActor)			event_user(event); // Then the monsters, they must be ready when chests give their keys
	with (_baseFieldContent)	event_user(event); // finally chests and traps
}

/// @function change_state_in(owner, statemachine, delay, new_state)
function change_state_in(owner, statemachine, delay, new_state) {
	log("*** STATE USABLE IN 60 ****");
	var anim = animation_empty(owner, delay, 0)
		.add_finished_trigger(function(data) {
			log("**** SETTING STATE ****");
			data.sm.set_state(data.newstate);
		});
	anim.data.sm = statemachine;
	anim.data.newstate = new_state;
}
