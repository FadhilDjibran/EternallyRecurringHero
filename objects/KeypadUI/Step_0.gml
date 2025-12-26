var _gp = 0; 

var _deadzone = 0.5; 
var _h_axis = gamepad_axis_value(_gp, gp_axislh);
var _v_axis = gamepad_axis_value(_gp, gp_axislv); 

var _stick_left_pressed  = (_h_axis < -_deadzone) && (stick_prev_h >= -_deadzone);
var _stick_right_pressed = (_h_axis > _deadzone)  && (stick_prev_h <= _deadzone);
var _stick_up_pressed    = (_v_axis < -_deadzone) && (stick_prev_v >= -_deadzone);
var _stick_down_pressed  = (_v_axis > _deadzone)  && (stick_prev_v <= _deadzone);

stick_prev_h = _h_axis;
stick_prev_v = _v_axis;

var _left  = keyboard_check_pressed(vk_left)  || keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(_gp, gp_padl) || _stick_left_pressed;

var _right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(_gp, gp_padr) || _stick_right_pressed;

var _up    = keyboard_check_pressed(vk_up)    || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(_gp, gp_padu) || _stick_up_pressed;

var _down  = keyboard_check_pressed(vk_down)  || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(_gp, gp_padd) || _stick_down_pressed;

var _enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(_gp, gp_face1);

var _skip  = keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(_gp, gp_start) || gamepad_button_check_pressed(_gp, gp_face2);

var _prev_cursor = cursor_pos;

if (_left)  cursor_pos--;
if (_right) cursor_pos++;
cursor_pos = clamp(cursor_pos, 0, 3);

if (cursor_pos != _prev_cursor)
{
    audio_play_sound(KeypadClickSFX, 10, false);
}
else
{
    var _prev_digit = digits[cursor_pos];

    if (_up)   digits[cursor_pos]++;
    if (_down) digits[cursor_pos]--;
    
    if (digits[cursor_pos] > 9) digits[cursor_pos] = 0;
    if (digits[cursor_pos] < 0) digits[cursor_pos] = 9;

    if (digits[cursor_pos] != _prev_digit)
    {
        audio_play_sound(KeypadClickSFX, 10, false);
    }
}


if (_enter)
{
    var _correct = true;
    for (var i = 0; i < 4; i++) {
        if (digits[i] != door_ref.correct_code[i]) _correct = false;
    }
   

    if (_correct)
    {
		audio_play_sound(KeypadSuccessSFX, 10, false);
        var _spawn_x = door_ref.x;
        var _spawn_y = door_ref.y;

        instance_destroy(door_ref);
        
        instance_create_layer(_spawn_x, _spawn_y, "Instances", LevelDoor, {
		    xcoor : 1091,
		    ycoor : 288
		});
        
		transition_teleport(1105, 288);
		instance_destroy();
    }
    else
    {
        audio_play_sound(KeypadWrongSFX, 10, false);
    }
    
    instance_destroy();
}

if (_skip)
{
    instance_destroy();
}