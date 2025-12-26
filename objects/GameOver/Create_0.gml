if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit; 
}

depth = -9999;
image_speed = 0; 

if (instance_exists(GameManager) && audio_is_playing(GameManager.current_music))
{
    audio_stop_sound(GameManager.current_music);
    GameManager.current_music = noone; 
}

audio_play_sound(GameOverBGM, 10, true, 0.3);
gamepad_index = 0;