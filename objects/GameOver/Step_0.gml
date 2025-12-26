if (keyboard_check_pressed(ord("R")) || gamepad_button_check_pressed(gamepad_index, gp_select))
{
    audio_stop_all(); 
    start_new_run();
	instance_destroy();
}