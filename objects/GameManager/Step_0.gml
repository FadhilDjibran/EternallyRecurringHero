//if (keyboard_check_pressed(ord("P")))
//{
//    var _xp_needed = global.max_xp - global.current_xp;
//    gain_xp(_xp_needed);
//}

if (global.timer_active)
{
    global.run_time += delta_time / 1000000;
}

if (room == Forest && global.run_time == 0)
{
    global.timer_active = true;
    global.timer_finished = false;
}

switch (transition_state)
{
    case TRANS_STATE.FADE_OUT:
        transition_alpha = min(1, transition_alpha + transition_speed);
        
        if (transition_alpha == 1)
        {
            if (is_teleporting)
            {
                if (instance_exists(ObjectPlayer))
                {
                    ObjectPlayer.x = transition_target_x;
                    ObjectPlayer.y = transition_target_y;
                    
                    var _cam = view_camera[0];
                    var _cam_w = camera_get_view_width(_cam);
                    var _cam_h = camera_get_view_height(_cam);
                    
                    var _new_cam_x = transition_target_x - (_cam_w / 2);
                    var _new_cam_y = transition_target_y - (_cam_h);
                    camera_set_view_pos(_cam, _new_cam_x, _new_cam_y);
                }
                
                is_teleporting = false;
            }
            else
            {
                if (transition_target_room != noone)
					{
						 room_goto(transition_target_room);
					}
            }
            
            transition_target_room = noone;
            transition_state = TRANS_STATE.FADE_IN;
        }
    break;
    
    case TRANS_STATE.FADE_IN:
        transition_alpha = max(0, transition_alpha - transition_speed);
        
        if (transition_alpha == 0)
        {
            transition_state = TRANS_STATE.IDLE;
        }
    break;
}

// Pause logic
var _boss_scene = false;
if (instance_exists(ObjectColonizerKing)) 
{
    if (ObjectColonizerKing.state_intro == true || ObjectColonizerKing.hp <= 0) 
    {
        _boss_scene = true;
    }
}

if (room != TitleScreen && room != IntroScreen && room != EndScreen && room != Cutscene && !instance_exists(GameOver) 
&& !instance_exists(KeypadUI) && !_boss_scene && !instance_exists(OutroStory) && (global.player_hp > 0)){
if (keyboard_check_pressed(vk_escape)) || gamepad_button_check_pressed(gamepad_index, gp_start)
{
    paused = !paused; 
	audio_resume_sound(GameManager.current_music);
    
    // Jika game di pause
    if (paused)
        {
			audio_play_sound(PauseSFX, 10, false);
            ds_list_clear(paused_instances);
            instance_deactivate_all(true);
            instance_activate_object(GameManager);
            instance_create_layer(0, 0, "Instances", PauseMenu); 
        }
    else
    {
		audio_play_sound(UnpauseSFX, 10, false);
		instance_activate_all();
        instance_destroy(PauseMenu);
    }
}
}


if (global.pending_level_ups > 0)
{
    if (!instance_exists(LevelUpMenu))
    {
        level_up_timer++;

        if (level_up_timer >= level_up_delay_max)
        {
            instance_create_layer(0, 0, "Instances", LevelUpMenu);
            
            global.pending_level_ups--;
            
            level_up_timer = 0;
        }
    }
    else
    {
        level_up_timer = 0;
    }
}

if (slow_mo_timer > 0)
{
    slow_mo_timer--;
	io_clear();
    
    if (slow_mo_timer <= 0)
    {
        game_set_speed(default_game_speed, gamespeed_fps);
    }
}

if (win_delay_timer > 0)
{
    win_delay_timer--;
    
    if (win_delay_timer <= 0)
    {
        win_delay_timer = -1; 
        
        game_set_speed(60, gamespeed_fps);
        slow_mo_timer = 0;
 
		instance_create_layer(x, y, "Instances", OutroStory);
    }
}

if (global.bow_unlocked == true && global.bow_msg_shown == false)
{
    global.bow_msg_shown = true;
    
    reward_msg = "Anda mendapatkan Bow!\nGanti senjata dengan tombol L.";
    reward_timer = 120;
    reward_buffer = 0;  
}

if (reward_timer > 0)
{
	if (global.reward_sfx_played == false)
    {
        audio_play_sound(LevelUpSFX, 10, false);
        global.reward_sfx_played = true; 
    }
	
    reward_timer--;

    if (instance_exists(ObjectPlayer))
    {
        ObjectPlayer.input_locked = true;
    }

    if (reward_timer <= 0)
    {
	        repeat(reward_buffer)
	        {
	            global.level++;
	            global.max_xp = round(global.max_xp * global.maxexp_multiplier); 
	            global.pending_level_ups++; 
	        }
        reward_buffer = 0;
        if (instance_exists(ObjectPlayer)) ObjectPlayer.input_locked = false;
		global.reward_sfx_played = false;
    }
}