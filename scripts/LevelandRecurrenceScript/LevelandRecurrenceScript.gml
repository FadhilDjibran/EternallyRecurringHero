function start_new_run()
{
    global.run_cycle++;
	if (instance_exists(GameManager))
    {
        GameManager.reward_timer = 0;
        GameManager.reward_buffer = 0;
        GameManager.reward_msg = "";
        
        // Cycle Rewards
        if (global.run_cycle >= 5 && global.level >= 3 && !GameManager.reward_cycle_5_claimed)
        {
            GameManager.reward_cycle_5_claimed = true;
            GameManager.reward_timer = 120; 
            GameManager.reward_buffer = 2;
            GameManager.reward_msg = "Anda menjadi lebih kuat setelah melewati beberapa cycle...";
        }
        else if (global.run_cycle >= 10 && global.level >= 8 && !GameManager.reward_cycle_10_claimed)
        {
            GameManager.reward_cycle_10_claimed = true;
            GameManager.reward_timer = 120;
            GameManager.reward_buffer = 2;
            GameManager.reward_msg = "Anda menjadi lebih kuat setelah melewati beberapa cycle...";
        }
    }
    global.current_xp = 0;        
    global.player_shield = 0; 
    global.player_hp_max = global.base_hp_max + global.perm_hp_bonus;
    global.player_hp = global.player_hp_max; 
    global.player_damage = global.base_damage + global.perm_damage_bonus;
  
	audio_play_sound(RecurrenceSFX, 10, false);
    transition_go_to_room(Forest); 
}

function gain_xp(amount)
{
    global.current_xp += amount;
    
    while (global.current_xp >= global.max_xp)
    {
        global.current_xp -= global.max_xp;
        global.level++;
        
        global.max_xp = min(round(global.max_xp * global.maxexp_multiplier), 1200);

        global.pending_level_ups++; 
        
        if (audio_exists(LevelUpSFX)) audio_play_sound(LevelUpSFX, 8, false);

    }
}

function FormatTime(_val_seconds)
{
    var _min = floor(_val_seconds / 60);
    var _sec = floor(_val_seconds % 60);
    var _ms  = floor((_val_seconds - floor(_val_seconds)) * 100);

    var _str_min = string_replace_all(string_format(_min, 2, 0), " ", "0");
    var _str_sec = string_replace_all(string_format(_sec, 2, 0), " ", "0");
    var _str_ms  = string_replace_all(string_format(_ms, 2, 0), " ", "0");

    return _str_min + ":" + _str_sec + "." + _str_ms;
}