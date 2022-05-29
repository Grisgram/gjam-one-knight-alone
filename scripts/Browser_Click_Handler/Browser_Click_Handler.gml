/*
	How to use this file
	--------------------
	
	The Browser click extension needs a script to be called when the user clicks in the browser.
	This script allows us to open links in a new tab, without triggering the popup warning of the browser.
	
	Normally, you implement this with a loop like this.
	"LinkButton" is a template name of an object that you want to open an url in a new tab.

	with (LinkButton) {
		if (visible && position_meeting(mouse_x, mouse_y, id)) {
			url_open_ext(url, "_blank");
			return;
		}
	}

*/


/// @function					open_link_in_new_tab()
/// @description				Opens the link in the variable browser_click_handler in a new tab
/// @param {string} 			
/// @returns {string}			
function open_link_in_new_tab() {
	with (_baseLinkButton) {
		if (visible && position_meeting(mouse_x, mouse_y, id)) {
			url_open_ext(url, "_blank");
			return;
		}
	}	
}

