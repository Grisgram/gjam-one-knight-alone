/// @description level creation done

if (variable_struct_exists(attributes, "type")) {
	// field has a content type. spawn it.
	contents = instance_create_layer(x, y, LAYER_ACTORS, asset_get_index(attributes.type));
	with(contents) {
		attributes = other.attributes;
		set_map_position(other.map_coords.x, other.map_coords.y);
		field = other;
	}
}

