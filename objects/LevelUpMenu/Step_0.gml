if (input_delay > 0) {
    input_delay--;
    exit;
}

// Fade
if (closing == true)
{
    // Fade out
    menu_alpha -= fade_speed; 
    if (menu_alpha <= 0)
    {
        instance_destroy(); 
    }
    exit; 
}
else
{
    // Fade in
    if (menu_alpha < 1)
    {
        menu_alpha += fade_speed;
        if (menu_alpha > 1) menu_alpha = 1;
    }
}

if (menu_alpha < 1) exit;
if (input_delay > 0) { input_delay--; exit; }

var _axis_h = gamepad_axis_value(gamepad_index, gp_axislh);
var _stick_right = (_axis_h > 0.5); 
var _stick_left  = (_axis_h < -0.5); 

if (_stick_right || _stick_left)
{
    if (stick_held)
    {
        _stick_right = false;
        _stick_left = false;
    }
    else
    {
        stick_held = true;
    }
}
else
{
    stick_held = false;
}

var _left = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(gamepad_index, gp_padl) || _stick_left;
var _right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(gamepad_index, gp_padr) || _stick_right;
var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("J")) || gamepad_button_check_pressed(gamepad_index, gp_face1);

var _prev_option = selected_option;

if (_left) selected_option--;
if (_right) selected_option++;

// Menu
if (selected_option < 0) selected_option = 2;
if (selected_option > 2) selected_option = 0;

if (selected_option != _prev_option){
	audio_play_sound(SwitchSFX, 8, false);
	}

if (_select)
{
    switch (selected_option)
    {
        case 0: // Damage Up
            global.perm_damage_bonus += damage_bonus;
			global.perm_bow_damage_bonus += bow_damage_bonus;
            global.player_damage = global.base_damage + global.perm_damage_bonus;
			global.player_bow_damage = global.base_bow_damage + global.perm_bow_damage_bonus;
            break;
            
        case 1: // Max HP Up
            global.perm_hp_bonus += hp_bonus; 
            
            // Update Max HP
            var _old_max = global.player_hp_max;
            global.player_hp_max = 100 + global.perm_hp_bonus;
            var _diff = global.player_hp_max - _old_max;
            global.player_hp += _diff; 
            break;
            
        case 2: // SHIELD
            global.player_shield += shield_value;
            break;
    }
    
	audio_play_sound(ConfirmSFX, 8, false);
    closing = true;
}