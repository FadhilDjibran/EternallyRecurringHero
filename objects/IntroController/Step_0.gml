var _up_key = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(gamepad_index, gp_padu);
var _down_key = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(gamepad_index, gp_padd);
var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(gamepad_index, gp_face1);
var _pause_key = keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(gamepad_index, gp_start);

// Logika Stick (Sama persis dengan referensi Anda)
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


// --- 2. LOGIKA TOGGLE PAUSE (ESC / START) ---
if (_pause_key)
{
    if (!is_paused)
    {
        // MULAI PAUSE
        if (audio_exists(PauseSFX)) audio_play_sound(PauseSFX, 10, false); // Suara buka menu
        is_paused = true;
        menu_index = 0;
        layer_sequence_pause(cutscene_seq);
    }
    else
    {
        // BATAL PAUSE (RESUME)
        if (audio_exists(UnpauseSFX)) audio_play_sound(UnpauseSFX, 10, false);
        is_paused = false;
        layer_sequence_play(cutscene_seq);
    }
}


// --- 3. LOGIKA NAVIGASI MENU (Hanya Saat Pause) ---
if (is_paused)
{
    var _prev_index = menu_index;
    
    if (_up)   menu_index--;
    if (_down) menu_index++;
    
    // Loop Menu
    var _len = array_length(menu_options);
    if (menu_index < 0) menu_index = _len - 1;
    if (menu_index >= _len) menu_index = 0;
    
    // SFX Pindah (Sama persis)
    if (menu_index != _prev_index) 
    {
        if (audio_exists(SwitchSFX)) audio_play_sound(SwitchSFX, 10, false);
    }

    // EKSEKUSI PILIHAN
    if (_select)
    {   
        switch (menu_index)
        {
            case 0: // --- RESUME ---
                if (audio_exists(UnpauseSFX)) audio_play_sound(UnpauseSFX, 8, false);
                is_paused = false;
                layer_sequence_play(cutscene_seq);
                break;
                
            case 1: 
                if (audio_exists(ConfirmSFX)) audio_play_sound(ConfirmSFX, 8, false);
				global.intro_has_played = true;
                layer_sequence_destroy(cutscene_seq);
                transition_go_to_room(Forest);
                break;
        }
    }
}
