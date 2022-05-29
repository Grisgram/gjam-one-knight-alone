/// @description randomize if not debug

if (!debug_mode)
	randomize();

// Initialize LG on HTML frontend
if (IS_HTML) {
	LG_AVAIL_LOCALES = HTML_LOCALES;
	LG_init();
}

log(sprintf("Game seed is {0}", random_get_seed()));
log(sprintf("Detecting scribble library: {0}found!", IS_SCRIBBLE_LOADED ? "" : "NOT "));

log("Checking for Debug mode: " + (DEBUG_MODE_ACTIVE ? "ACTIVE" : "DISABLED"));
check_debug_mode();

log("Invoking onGameStart()");
onGameStart();

if (DEBUG_MODE_ACTIVE)
	window_set_size(DEBUG_MODE_WINDOW_WIDTH, DEBUG_MODE_WINDOW_HEIGHT);

