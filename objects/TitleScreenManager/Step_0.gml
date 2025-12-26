if (input_delay > 0) {
    input_delay--;
    exit;
}

var _axis_v = gamepad_axis_value(gamepad_index, gp_axislv);
var _stick_down = (_axis_v > 0.5); 
var _stick_up   = (_axis_v < -0.5); 

if (_stick_down || _stick_up) {
    if (stick_held == true) { _stick_down = false; _stick_up = false; }
    else { stick_held = true; }
} else {
    stick_held = false;
}

var _up    = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(gamepad_index, gp_padu) || _stick_up;
var _down  = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(gamepad_index, gp_padd) || _stick_down;
var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(gamepad_index, gp_face1) || gamepad_button_check_pressed(gamepad_index, gp_start);
var _back   = keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(gamepad_index, gp_face2); // Tombol Back khusus

if (in_options)
{
    var _prev_opt = opt_index; 
    if (_up)   opt_index--;
    if (_down) opt_index++;
    
    var _len_opt = array_length(opt_options);
    if (opt_index < 0) opt_index = _len_opt - 1;
    if (opt_index >= _len_opt) opt_index = 0;
    
    if (opt_index != _prev_opt) audio_play_sound(SwitchSFX, 8, false); 
    
    if (_select || _back) 
    {
        audio_play_sound(ConfirmSFX, 8, false);
        
        // Logika Options
        if (_select && opt_index == 0) 
        {
             var _vol = audio_get_master_gain(0);
             if (_vol > 0) audio_master_gain(0); else audio_master_gain(1); 
        }
        else 
        {
            in_options = false; 
            input_delay = 10;
        }
    }
}
else if (in_controls)
{
    var _prev_ctrl = ctrl_index;
    
    if (_up)   ctrl_index--;
    if (_down) ctrl_index++;
    
    var _len_ctrl = array_length(ctrl_options);
    if (ctrl_index < 0) ctrl_index = _len_ctrl - 1;
    if (ctrl_index >= _len_ctrl) ctrl_index = 0;
    
    if (ctrl_index != _prev_ctrl) audio_play_sound(SwitchSFX, 8, false);

    if (_select || _back)
    {
        audio_play_sound(ConfirmSFX, 8, false);
        in_controls = false;
        input_delay = 10;
    }
}
else 
{
    var _prev_index = menu_index;
    if (_up)   menu_index--;
    if (_down) menu_index++;
    
    var _len = array_length(menu_options);
    if (menu_index < 0) menu_index = _len - 1;
    if (menu_index >= _len) menu_index = 0;
    
    if (menu_index != _prev_index) audio_play_sound(SwitchSFX, 8, false); 
  
    if (_select)
    {
        audio_play_sound(ConfirmSFX, 8, false);
        switch (menu_index)
        {
            case 0: // START GAME
                if (global.intro_has_played == true) transition_go_to_room(Forest); 
                else transition_go_to_room(IntroScreen);
                break;
                
            case 1: // OPTIONS
                in_options = true; 
                opt_index = 0;    
                input_delay = 10; 
                break;
                
            case 2: // CONTROLS 
                in_controls = true;
                input_delay = 10;
                break;
                
            case 3: // EXIT
                game_end(); 
                break;
        }
    }
}