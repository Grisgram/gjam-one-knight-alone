/*
    turns a numeric value into a sprite string with n repeats of the specified symbol
*/
function get_value_string(value, sprite) {
	if (value <= 0)
		return "";
	
	var sname = sprite_get_name(sprite);
	
	switch(value) {
		case 1: return sprintf("[fa_middle][fa_center][{0},0][{0},2]", sname);
		case 2: return sprintf("[fa_middle][fa_center][{0},0][{0},1][{0},2]", sname);
		default: 
			return sprintf("[fa_middle][fa_center][{0},0]{1}[{0},2]", sname, string_repeat(sprintf("[{0},1]",sname),value-1));
	}
	
}