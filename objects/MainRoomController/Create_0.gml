/// @description animation chain background

TOOLTIP_LAYER = undefined;

#macro LAYER_BG_SPRITES		"background_sprites"
// Inherit the parent event
event_inherited();

background_sprites = [
	instance_create_layer(0,0,LAYER_BG_SPRITES,BackgroundSprite),
	instance_create_layer(0,0,LAYER_BG_SPRITES,BackgroundSprite),
	instance_create_layer(0,0,LAYER_BG_SPRITES,BackgroundSprite),
	instance_create_layer(0,0,LAYER_BG_SPRITES,BackgroundSprite),
];

for (var i = 0; i < array_length(background_sprites); i++) {
	with(background_sprites[@ i]) {
		sprite_index = asset_get_index("sprMainBack" + string(i));
		image_alpha = 0;
	}
}

with(playButton) image_alpha = 0;
with(lblNoSounds) image_alpha = 0;

// now fire the ever-running anim chain
with (ROOMCONTROLLER.background_sprites[@ 0]) {
	log("FADE IN 0");
	animation_run(self, 0, 120, acLinearAlphaIn)
		.add_finished_trigger(function() {
			log("FADE IN 1");
			with (ROOMCONTROLLER.background_sprites[@ 1]) {
				animation_run(self, 0, 180, acMainBackImage_0_05)
					.add_finished_trigger(function() {
						log("FADE OUT 0+1");
						with (ROOMCONTROLLER.background_sprites[@ 0]) {
							animation_run(self, 0, 180, acLinearAlphaOut);
						}
						with (ROOMCONTROLLER.background_sprites[@ 1]) {
							animation_run(self, 0, 180, acLinearAlphaOut);
						}
						log("FADE IN DETAILS");
						storyTeller.typist_active = true;
						with (gamemakerLink)	animation_run(self, 0, 120, acLinearAlphaIn);
						with (creditsButton)	animation_run(self, 0,  90, acLinearAlphaIn);
						with (lblNoSounds)		animation_run(self, 0,  90, acLinearAlphaIn);
						with (playButton)		animation_run(self, 0,  90, acLinearAlphaIn);
						with (githubLink)		animation_run(self, 0, 120, acLinearAlphaIn);
						with (titleText)		animation_run(self, 0,  90, acLinearAlphaIn);
						with (jamText)			animation_run(self, 0, 120, acLinearAlphaIn);
						with (jamLink)			animation_run(self, 0, 120, acLinearAlphaIn);
						log("FADE IN 2+3");
						with (ROOMCONTROLLER.background_sprites[@ 2]) {
							animation_run(self, 0, 180, acLinearAlphaIn)
								.add_finished_trigger(function() {
									log("PINGPONG 2");
									with (ROOMCONTROLLER.background_sprites[@ 2])
										animation_run(self, 0, 600, acMainBackImage_1_0, -1);
								}
							);
						}
						with (ROOMCONTROLLER.background_sprites[@ 3]) {
							animation_run(self, 0, 180, acMainBackImage_0_05)
								.add_finished_trigger(function() {
									log("PINGPONG 3");
									with (ROOMCONTROLLER.background_sprites[@ 3])
										animation_run(self, 0, 600, acMainBackImage_0_1, -1);									
								}
							);
						}						
					}
				);
			}
		}
	);
}
