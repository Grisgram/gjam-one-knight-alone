/*
	All data about the player avatar
*/

function PlayerData(_owner) : ActorData(_owner) constructor {

	value_changed = true;

	points	= 0;

	// we start with -3 xp because at gamee start the first three
	// fields of the level are unfolded (which gives 3 xp)
	// and it would be much harder to code that exception
	// than to just set an offset here for game start
	xp			= 0;
	xp_to_next	= 10;

	hp			= 6;
	max_hp		= 6;
	
	shield = 3;
	weapon = 1;

	max_shield = 5;
	max_weapon = 5;

	priority	= 2;

	__setup_all_value_strings();

	static repair_shield = function(percent) {
		var shieldbefore = shield;
		shield = min(max_shield, shield + max_shield * percent/100);
		value_string_shield = get_value_string(shield, sprShieldValues);
		value_changed = true;
		__float_value(shield - shieldbefore, sprShield);
	}
	
	static repair_weapon = function(percent) {
		var weaponbefore = weapon;
		weapon = min(max_weapon, weapon + max_weapon * percent/100);
		value_string_weapon = get_value_string(weapon, sprSwordValues);
		value_changed = true;
		__float_value(weapon - weaponbefore, sprSword);
	}
	
	static heal_hp = function(percent) {
		var hpbefore = hp;
		hp = min(max_hp, hp + max_hp * percent/100);
		value_string_hp = get_value_string(hp, sprHeartValues);
		value_changed = true;
		var real_change = hp - hpbefore
		if (real_change != 0)
			__float_value(real_change, sprHeart);
		new Animation(GAME.player_object, 0, 30, acPlayerHeal).set_scale_is_relative(true);
		return real_change;
	}

	static gain_xp_buff = function(percent) {
		gain_xp(xp_to_next * percent/100);
	}

	static gain_score = function(plus) {
		if (!GAME.is_level_running()) return;
		log(sprintf("Gained score: {0}", plus));
		points += plus;
		value_changed = true;
	}

	static gain_xp = function(plusxp) {
		if (!GAME.is_level_running()) return;
		xp = floor(xp + plusxp);
		gain_score(ceil(SCORE_XP_MULTIPLIER * plusxp));
		while (xp >= xp_to_next) {
			xp -= xp_to_next;
			perform_level_up();
		}
		__float_value(floor(plusxp), sprXP);
		value_changed = true;
	}

	static perform_level_up = function() {
		xp_to_next = floor(xp_to_next * 1.2);
		level++;
		max_hp++;
		max_shield++;
		max_weapon++;
		base_damage++;
		shield = min(shield, max_shield / 2);
		weapon = min(weapon, max_weapon / 2);
		hp = max(hp, max_hp);
		with(GAME.player_object)
			states.set_state("level_up");
	}
}