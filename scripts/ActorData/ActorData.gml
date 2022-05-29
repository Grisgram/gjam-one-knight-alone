/*
	All data about the player avatar
*/

function ActorData(_owner) constructor {
	
	owner		= _owner;
	keys		= [];
				
	level		= 1;	
	
	hp			= 0;
	max_hp		= 0;
				
	weapon		= 0;
	max_weapon	= 0;
	shield		= 0;
	max_shield	= 0;
	
	base_damage	= 1;
	priority	= 2;
	
	value_string_hp		= "";
	value_string_shield = "";
	value_string_weapon = "";
	
	static __setup_all_value_strings = function() {
		value_string_hp		= get_value_string(hp, sprHeartValues);
		value_string_weapon = get_value_string(weapon, sprSwordValues);
		value_string_shield = get_value_string(shield, sprShieldValues);
	}
	
	/// @function __float_value(value, icon)
	static __float_value = function(value, icon) {
		if (value == 0) return;
		
		var ico = icon == undefined ? "" : sprintf("[{0}]", (is_string(icon) ? icon : sprite_get_name(icon)));
		var msgtext = sprintf("[scale,1.3]{0} {1}{2}[/]", ico, value > 0 ? "[c_lgreen]+" : "[c_red]", floor(value));
		floating_text(owner, msgtext, 
			random_range(PLAYER_CHAT_OFFSET_X    , PLAYER_CHAT_OFFSET_X * 2), 
			random_range(PLAYER_CHAT_OFFSET_Y / 2, PLAYER_CHAT_OFFSET_Y * 2), 
			random_range(90, 150), 0);
	}

	static is_alive = function() {
		return hp > 0;
	}

	static is_at_full_hp = function() {
		return hp == max_hp;
	}

	static get_damage_dealt = function() {
		return base_damage * level + weapon;
	}

	static is_attack_deadly = function(dmg) {
		return dmg >= hp + shield;
	}

	/// @function change_hp(change, from_trap)
	static change_hp = function(change, from_trap = false) {
		if (change < 0 && shield > 0)
			change -= change_shield(change);
		var hpbefore = hp;
		hp = clamp(hp + change, 0, max_hp);
		value_string_hp = get_value_string(hp, sprHeartValues);
		value_changed = true;
		var real_change = hp - hpbefore;
		if (real_change != 0)
			__float_value(real_change, sprHeart);
		if (hp == 0)
			with(owner) die(from_trap);
		return real_change;
	}

	static change_weapon = function(change) {
		var weaponbefore = weapon;
		weapon = clamp(weapon + change, 0, max_weapon);
		value_string_weapon = get_value_string(weapon, sprSwordValues);
		value_changed = true;
		var real_change = weapon - weaponbefore;
		if (real_change != 0)
			__float_value(real_change, sprSword);
		with (GAME.player_object)
			set_armed();
		return real_change;
	}
	
	static change_shield = function(change) {
		var shieldbefore = shield;
		shield = clamp(shield + change, 0, max_shield);
		value_string_shield = get_value_string(shield, sprShieldValues);
		value_changed = true;
		var real_change = shield - shieldbefore;
		if (real_change != 0)
			__float_value(real_change, sprShield);
			
		return real_change;
	}
	
}