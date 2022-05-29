/*
	All data about the player avatar
*/

function MonsterData(_owner) : ActorData(_owner) constructor {

	monster_name = "";
	with(_owner)
		other.monster_name = object_get_name(object_index);

	level = 1 + floor(GAME.level_number / 2);

	switch (monster_name) {
		case "Skeleton":
			hp = 2 + GAME.level_number;
			weapon = floor(GAME.level_number / 2);
			shield = max(0, GAME.level_number - 2);
			base_damage = 1 + floor(GAME.level_number / 3);
			priority	= 1;
			break;
		case "Vampire":
			hp = 3 + GAME.level_number;
			weapon = 0;
			shield = floor(GAME.level_number / 2);
			base_damage = 2 + ceil(GAME.level_number / 3);
			priority	= 3;
			break;
		case "Zombie":
			hp = 3 + floor(GAME.level_number / 2);
			weapon = min(10, GAME.level_number);
			shield = floor(GAME.level_number / 2);
			base_damage = 2;
			priority	= 1;
			break;
		case "Bat":
			hp = 1 + floor(GAME.level_number / 2);
			weapon = floor(GAME.level_number / 3);
			shield = floor(GAME.level_number / 3);
			base_damage = 1;
			priority	= 3;
			break;
	}

	max_shield = shield;
	max_weapon = weapon;
	max_hp = hp;

	log(sprintf("Initialized {0}: level={1}; hp={2}; shield={3}; weapon={4}; damage={5};", monster_name, level, hp, shield, weapon, base_damage));

	__setup_all_value_strings();

	get_tooltip_text = function() {
		return sprintf(LG("play_strings/monster_tooltip"),
			monster_name, level, get_damage_dealt(), value_string_hp, value_string_shield, value_string_weapon);
	}

}