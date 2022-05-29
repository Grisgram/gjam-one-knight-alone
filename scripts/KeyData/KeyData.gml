/*
    Defines a key and for which item it is.
	If the holding monster dies, the hero retrieves this key.
	When the hero clicks a chest (or the level exit), its key
	collection is checked, whether he holds the key for that object
*/
function KeyData(key_sprite, for_object) constructor {
	sprite = key_sprite;
	target_object = for_object;
}