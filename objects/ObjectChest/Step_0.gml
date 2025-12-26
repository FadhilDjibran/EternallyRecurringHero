if (distance_to_object(ObjectPlayer) < 5)
{
    if (!opened && (keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face4))) 
    {
        opened = true;
        audio_play_sound(ChestOpenSFX, 10, false);
        
        if (give_max_exp)
        {
            var _target_xp = global.max_xp; 
            var _current_xp = global.current_xp;

            var _xp_needed = _target_xp - _current_xp;
            
            if (_xp_needed < 0) _xp_needed = 0;

            gain_xp(_xp_needed);
        }
        else
        {
            gain_xp(xp_amount);
        }

        instance_destroy();
    }   
}