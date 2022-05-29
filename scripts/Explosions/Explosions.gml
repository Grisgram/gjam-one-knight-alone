#macro POOL_EXPLOSIONS				"explosions_pool"

/// @function					explosion_start_scaled_by(sprite, _xscale, _yscale, speed_multiplier = 1, finished_callback = undefined)
/// @description				start a pooled explosion animation scaled by a factor
/// @param {asset} sprite
/// @param {string} on_layer
/// @param {real}	_xscale
/// @param {real}	_yscale
/// @param {real=0}	rotation
/// @param {real=1}	speed_multiplier
/// @param {func=undefined}	finished_callback
function explosion_start_scaled_by(sprite, on_layer, xscale, yscale, rotation = 0, speed_multiplier = 1, finished_callback = undefined) {
	var rv = pool_get_instance(POOL_EXPLOSIONS, ExplosionRunner, on_layer);
	with (rv) {
		__finished_callback = finished_callback;
		layer = layer_get_id(on_layer);
		sprite_index = sprite;
		image_speed = speed_multiplier;
		image_xscale = xscale;
		image_yscale = yscale;
		image_angle = rotation;
		image_index = 0;
	}
	return rv;
}

/// @function					explosion_start_scaled_to(sprite, scaled_width, scaled_height, speed_multiplier = 1, finished_callback = undefined)
/// @description				start a pooled explosion animation scaled to a desired end-size
/// @param {asset} sprite
/// @param {string} on_layer
/// @param {real}	scaled_width
/// @param {real}	scaled_height
/// @param {real=0}	rotation
/// @param {real=1}	speed_multiplier
/// @param {func=undefined}	finished_callback
function explosion_start_scaled_to(sprite, on_layer, scaled_width, scaled_height, rotation = 0, speed_multiplier = 1, finished_callback = undefined) {
	return explosion_start_scaled_by(sprite, on_layer, scaled_width/sprite_get_width(sprite), scaled_height/sprite_get_height(sprite), rotation, speed_multiplier, finished_callback);
}

/// @function					explosion_start(sprite, speed_multiplier = 1, finished_callback = undefined)
/// @description				start a pooled explosion animation
/// @param {asset} sprite
/// @param {string} on_layer
/// @param {real=0}	rotation
/// @param {real=1}	speed_multiplier
/// @param {func=undefined}	finished_callback
function explosion_start(sprite, on_layer, rotation = 0, speed_multiplier = 1, finished_callback = undefined) {
	return explosion_start_scaled_by(sprite, on_layer, 1, 1, rotation, speed_multiplier, finished_callback);
}
