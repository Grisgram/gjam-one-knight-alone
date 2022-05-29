/*
	These callbacks get invoked from the GameStarter object in the
	GameStart and GameEnd events respectively.
	If the game is currently in HTML mode, HTML_LOCALES is used to set up the locale list.
	
	They have been created to encapsulate one-time-startup/-shutdown actions in
	an isolated script file, so you do not need to modify the GameStarter object directly
	in each game.
	
	onGameStart runs AFTER the ci_colors have been initialized.
	It is recommended, to set at least the app_theme in the onGameStart function, so 
	scribble gets initialized with the correct set of ci_colors.
*/

#macro HTML_LOCALES			["en", "de"]
#macro MESSAGEBOX_LAYER		"popup_instances"

function onGameStart() {

	DEBUG_SHOW_OBJECT_FRAMES	= false;
	DEBUG_MODE_ACTIVE			= true;
	DEBUG_MODE_WINDOW_WIDTH		= 1280;
	DEBUG_MODE_WINDOW_HEIGHT	= 720;

	// set up named colors for the game
	set_app_theme(ci_theme.rising);

	if (IS_HTML)
		browser_click_handler = open_link_in_new_tab;

	// Load start data
	// Example line to show that you can load your startup files here
	//GLOB_COMMAND_TO_MINI_SEQ = file_read_struct_plain(FILE_COMMAND_TO_MINI_SEQ);
	race_load_file(RACE_FILE_NAME, false);

	//
	// Setup Scribble
	//
	//scribble_font_set_default("freak16");
	scribble_font_bake_outline_8dir("acme28","acme28out",c_black,true);
	scribble_font_bake_outline_8dir("acme24","acme24out",c_black,true);
	//scribble_font_bake_outline_8dir("freak24","freak24out",c_black,true);
	//scribble_font_bake_outline_8dir_2px("freak36","freak36out",c_black,true);

	// custom named scribble colors
	//SCRIBBLE_COLORS.ctt_reg	= #E5E5E5;
	SCRIBBLE_COLORS.c_danger = #E55632;
	SCRIBBLE_COLORS.c_lgreen = #19E523;

}

function onGameEnd() {
}

