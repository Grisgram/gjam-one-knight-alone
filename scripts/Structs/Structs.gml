/*
	Utility methods to work with strings.
	
	(c)2022 Mike Barthold, indievidualgames, aka @grisgram at github
	Please respect the MIT License for this library: https://opensource.org/licenses/MIT
*/

/// @function				vs_get_by_path(struct, path)
/// @description			Gets an entry from a variable_struct with the path syntax that
///							is used in LG() too.
///							In a hierachical struct, it gets cruel to cascade 5 variable_struct_get
///							calls to retrieve a single value.
///							This function allow you something like:
///							vs_get_by_path(mystruct, "enemies/dungeon23/bosses/1/name")
///							and you will receive, whatever is stored at this position in the struct.
/// @param {struct}	struct	The struct to search through
/// @param {string} path	The hierarchical path in the struct
///
/// @grisgram 2022-02-18
function vs_get_by_path(struct, path) {
	var key;
	var map = struct;
	var args = string_split(path, "/");
	var len = array_length(args);

	for (var i = 0; i < len - 1; i++) {
		key = args[i];
		map = variable_struct_get(map, key);
		if (map == undefined)
			break;
	}
	if (map != undefined) {
		key = args[len - 1];
		return variable_struct_get(map, key);
	}
	return undefined;
}

/// @function					vs_set_by_path(struct, path, value)
/// @description				Sets an entry from a variable_struct with the path syntax to a new value.
///								In a hierachical struct, it gets cruel to cascade 5 variable_struct_get
///								calls to set a single value.
///								This function allow you something like:
///								vs_set_by_path(mystruct, "enemies/dungeon23/bosses/1/name", "Ragnaros").
///								You can set whatever you want for the value, even create new structs
///								on the fly if you leave the last parameter at its default of true.
/// @param {struct}	struct		The struct to search through
/// @param {string} path		The hierarchical path in the struct
/// @param {any}    value		The value to assign
/// @param {bool=true}   create_path	Default=true. If true, missing elements in the path will be created as structs.
///
/// @grisgram 2022-02-18
function vs_set_by_path(struct, path, value, create_path = true) {
	var key;
	var map = struct;
	var args = string_split(path, "/");
	var len = array_length(args);

	for (var i = 0; i < len - 1; i++) {
		key = args[i];
		var current = map;
		map = variable_struct_get(map, key);
		if (map == undefined) {
			if (create_path) {
				map = {};
				variable_struct_set(current,key,map);
			} else
				break;
		}
	}
	if (map != undefined) {
		key = args[len - 1];
		variable_struct_set(map, key, value);
	}
	return undefined;
}

/// @function					struct_get_unique_key(struct, basename, prefix = "")
/// @description				get a free name for a key in a struct with an optional prefix
/// @param {struct} struct
/// @param {string} basename
/// @param {string=""} prefix
/// @returns {string} the new name	
function struct_get_unique_key(struct, basename, prefix = "") {
	var i = 0;
	var newname;
	do {
		newname = prefix + basename + string(i);
		i++;
	} until (!variable_struct_exists(struct, newname));
	return newname;
}