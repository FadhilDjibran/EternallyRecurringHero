var _pad_idx = 0; 
var _next = keyboard_check_pressed(vk_space) || 
            keyboard_check_pressed(vk_enter) || 
            mouse_check_button_pressed(mb_left) ||
            gamepad_button_check_pressed(_pad_idx, gp_face1) || 
            gamepad_button_check_pressed(_pad_idx, gp_start);   

if (_next)
{
    if (fade_state == 0)
    {
        var _can_proceed = true;
		
		if (current_page == 3 && white_fade_alpha < 1) {
            _can_proceed = false; 
        }

        if (_can_proceed)
        {
            if (current_page < array_length(story_data) - 1)
            {
                audio_play_sound(ConfirmSFX, 10, false);
                target_page = current_page + 1;
                fade_state = 1;
            }
            else
            {
                transition_go_to_room(EndScreen)
                instance_destroy(); 
            }
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
        
        if (current_page == 3) is_time_traveling = true;

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

if (is_time_traveling && current_page == 3)
{
    hero_alpha -= 0.005; 
    if (hero_alpha < 0) hero_alpha = 0;

    white_fade_alpha += 0.005;
    if (white_fade_alpha > 1) white_fade_alpha = 1;
}