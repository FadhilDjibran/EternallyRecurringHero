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
global.base_damage = 20; //20
global.base_bow_damage = 15;
// Diset juga di PauseMenu karena reset
global.player_hp_max = global.base_hp_max + global.perm_hp_bonus;
global.player_hp = global.player_hp_max;
global.player_damage = global.base_damage + global.perm_damage_bonus;
global.player_bow_damage = global.base_bow_damage + global.perm_bow_damage_bonus;

paused = false;
paused_instances = ds_list_create();

global.level_min_x = 0;
global.level_min_y = 0;
global.level_max_x = 0; 
global.level_max_y = 0;

current_music = noone;
gamepad_index = 0;

enum TRANS_STATE
{
    IDLE,     
    FADE_OUT, 
    FADE_IN   
}

transition_state = TRANS_STATE.FADE_IN; 
transition_alpha = 1;                   
transition_speed = 0.05;           
transition_target_room = noone;    
transition_target_x = -1;
transition_target_y = -1;
is_teleporting = false;

depth = -100;
level_up_timer = 0; 
level_up_delay_max = 25;

enum WEAPON_TYPE {
    SWORD,
    BOW
}

global.bow_unlocked = false; 

global.current_weapon = WEAPON_TYPE.SWORD;

slow_mo_timer = 0; 
default_game_speed = 60;
win_delay_timer = -1;
 
margin_left   = 120;
margin_right  = 200; 
margin_top    = 100;
margin_bottom = 50;

global.intro_has_played = false;
GameManager.reward_cycle_5_claimed = false;
GameManager.reward_cycle_10_claimed = false;
reward_timer = 0;     
reward_buffer = 0;      
reward_msg = "";
global.bow_msg_shown = false;
global.reward_sfx_played = false;

global.run_time = 0;          
global.timer_active = false;  
global.timer_finished = false;