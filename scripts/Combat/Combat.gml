/*
    let the games begin!
*/
function Combat(fighter1, fighter2, ignore_priority = false) constructor {

	log("Combat created");
	
	first_fighter = undefined;
	second_fighter = undefined;

	other_fighter = undefined;

	combat_round = 0;
	damage = 0;

	if (ignore_priority || fighter1.actor_data.priority > fighter2.actor_data.priority) {
		first_fighter = fighter1;
		second_fighter = fighter2;
	} else {
		first_fighter = fighter2;
		second_fighter = fighter1;
	}

	static next_round = function() {
		combat_round++;
		log(sprintf("Starting combat round {0}", combat_round));
		if (combat_round == 1 && first_fighter.actor_data.is_alive()) {
			with(first_fighter)
				other.damage = -actor_data.get_damage_dealt();
			other_fighter = second_fighter;
			var fn;
			with (first_fighter) {
				fn = MY_NAME;
				states.set_state("attack");
			}
			log(sprintf("'{0}' attacks for {1} damage", fn, damage));
			
			return true;
		} else if (combat_round == 2 && second_fighter.actor_data.is_alive()) {
			with (second_fighter)
				other.damage = -actor_data.get_damage_dealt();
			other_fighter = first_fighter;
			var fn;
			with (second_fighter) {
				fn = MY_NAME;
				states.set_state("attack");
			}
			log(sprintf("'{0}' attacks for {1} damage", fn, damage));
			return true;
		} else {
			log("No more combat rounds");
			end_combat();
			return false;
		}
	}

	static end_combat = function() {
		log("Combat ends");
		with (first_fighter)
			if (actor_data.is_alive())
				states.set_state("idle");
		with (second_fighter)
			if (actor_data.is_alive())
				states.set_state("idle");
		COMBAT = undefined;
	}
	
	static apply_damage = function() {
		with(COMBAT) {
			var n1, n2;
			with (first_fighter) n1 = MY_NAME;
			with (second_fighter) n2 = MY_NAME;
			log(sprintf("Applying combat damage: from='{0}' to='{1}' damage={2}", n1, n2, damage));
		
			var dmg = damage;
			with (other_fighter) {
				actor_data.change_hp(dmg);
			}
			if (other_fighter.actor_data.is_alive()) 
				return next_round();
			else
				end_combat();
			return false;
		}
	}
	
}