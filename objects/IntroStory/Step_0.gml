var _pad_idx = 0; 

var _next = keyboard_check_pressed(vk_space) || 
            keyboard_check_pressed(vk_enter) || 
            mouse_check_button_pressed(mb_left) ||
            gamepad_button_check_pressed(_pad_idx, gp_face1) || 
            gamepad_button_check_pressed(_pad_idx, gp_start);   
hover_timer += hover_speed;

if (_next)
{
    if (fade_state == 0)
    {
        if (current_page < array_length(story_data) - 1)
        {
			audio_play_sound(ConfirmSFX, 10, false);
            target_page = current_page + 1;
            fade_state = 1; 
        }
        else
        {
            audio_stop_all();
            transition_go_to_room(Cutscene); 
            instance_destroy(); 
        }
    }
}

if (fade_state == 1)
{
    fade_alpha += fade_speed;
    
    if (fade_alpha >= 1)
    {
        fade_alpha = 1;
        current_page = target_page; 
        image_index = 0;            
        fade_state = 2; 
    }
}

else if (fade_state == 2)
{
    fade_alpha -= fade_speed;
    if (fade_alpha <= 0)
    {
        fade_alpha = 0;
        fade_state = 0; 
    }
}