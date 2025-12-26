var _up_key = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(gamepad_index, gp_padu);
var _down_key = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(gamepad_index, gp_padd);
var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(gamepad_index, gp_face1);

var _axis_v = gamepad_axis_value(gamepad_index, gp_axislv);
var _stick_down = (_axis_v > 0.5);
var _stick_up   = (_axis_v < -0.5);

if (_stick_down || _stick_up) {
    if (stick_held) { _stick_down = false; _stick_up = false; }
    else { stick_held = true; }
} else {
    stick_held = false;
}

var _up   = _up_key || _stick_up;
var _down = _down_key || _stick_down;


if (in_options)
{
    var _prev_opt = opt_index;
    if (_up)   opt_index--;
    if (_down) opt_index++;
    
    var _len_opt = array_length(opt_options);
    if (opt_index < 0) opt_index = _len_opt - 1;
    if (opt_index >= _len_opt) opt_index = 0;

    if (opt_index != _prev_opt) audio_play_sound(SwitchSFX, 10, false);

    if (_select)
    { 
        audio_play_sound(ConfirmSFX, 8, false);
        switch (opt_index)
        {
            case 0: // AUDIO TOGGLE
                var _vol = audio_get_master_gain(0);
                if (_vol > 0) audio_master_gain(0);
                else audio_master_gain(1);          
                break;
                
            case 1: // BACK
                in_options = false;
                break;
        }
    }
}
else if (in_controls)
{
    if (_select)
    {
        audio_play_sound(ConfirmSFX, 8, false);
        in_controls = false; 
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
    
    if (menu_index != _prev_index) audio_play_sound(SwitchSFX, 10, false);

    if (_select)
    {   
        audio_play_sound(ConfirmSFX, 8, false);
        switch (menu_index)
        {
            case 0: // RESUME
                audio_play_sound(UnpauseSFX, 8, false);
                audio_resume_sound(GameManager.current_music);
                GameManager.paused = false;
                instance_activate_all();
                instance_destroy();
                break;
                
            case 1: // OPTIONS
                in_options = true;
                opt_index = 0;
                break;

            case 2: // CONTROLS
                in_controls = true;
                ctrl_index = 0;
                break;
                
            case 3: // EXIT TITLE 
                audio_stop_all();
                global.run_time = 0;
				global.timer_active = false;
				global.timer_finished = false;
                global.cycle = 1;
                global.bow_unlocked = false; 
				global.bow_msg_shown = false;
				global.reward_sfx_played = false;
                global.current_weapon = WEAPON_TYPE.SWORD;
                global.level = 1;            
                global.perm_damage_bonus = 0; 
                global.perm_bow_damage_bonus = 0; 
                global.perm_hp_bonus = 0; 
                global.run_cycle = 1;
                global.current_xp = 0;        
                global.max_xp = 100;          
                global.player_shield = 0; 
                global.maxexp_multiplier = 1.3;
                global.pending_level_ups = 0;
                global.base_hp_max = 100; 
                global.base_damage = 20;
                global.base_bow_damage = 15;
                global.player_hp_max = global.base_hp_max + global.perm_hp_bonus;
                global.player_hp = global.player_hp_max;
                global.player_damage = global.base_damage + global.perm_damage_bonus;
                global.player_bow_damage = global.base_bow_damage + global.perm_bow_damage_bonus;
                
                if (instance_exists(GameManager))
                {
                    GameManager.reward_cycle_5_claimed = false;
                    GameManager.reward_cycle_10_claimed = false;
                    GameManager.reward_delay_timer = 0;
                    GameManager.reward_levels_buffer = 0;
                    GameManager.notification_text = "";     
                }
                
                GameManager.paused = false;
                instance_activate_all(); 
                transition_go_to_room(TitleScreen);
                instance_destroy();
                break;
        }
    }
}