/// @description level creation done

// Inherit the parent event
event_inherited();

// generate a key and give it a random monster
// the key_sprite is an instance variable
var key = new KeyData(key_sprite, self);
var monsters = GAME.level_data.get_monsters();
var rnd = irandom(array_length(monsters) - 1);
var winner = monsters[@ rnd];
var chest_name = MY_NAME;
with (winner) {
	log(sprintf("{0}: My key is with '{1}'", chest_name, MY_NAME));
	array_push(actor_data.keys, key);
}

