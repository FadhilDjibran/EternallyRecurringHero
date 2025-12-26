gamepad_index = 0;
stick_held = false; 

in_options = false; 
in_controls = false;

menu_options = ["RESUME", "OPTIONS", "CONTROLS", "EXIT TO TITLE"];
menu_index = 0; 

audio_pause_sound(GameManager.current_music);

opt_options = ["SOUND: ", "BACK"];
opt_index = 0;

ctrl_options = ["BACK"];
ctrl_index = 0;