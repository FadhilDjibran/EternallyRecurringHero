move_spd = 3;
grav = 0.35;
jump_spd = -6.5;
vsp = 0;
grounded = false;
depth = -50;
gamepad_index = 0;
gamepad_set_axis_deadzone(gamepad_index, 0.3);
dead = false;
game_over_triggered = false;

coyote_max = 6;      
buffer_max = 7;     
coyote_t = 0;
buffer_t = 0;

landed_cooldown_max = 3;
landed_cooldown = 3;
prev_grounded = false;

attack_duration = 0;  
attack_timer = 0;
attack_cooldown = 20;     
can_attack    = true;
attacking     = false;

attack_active_start = 8;
attack_active_end   = 4; 

attack_hitbox_offset_x = 30; 
attack_hitbox_offset_y = -15; 

my_hitbox = noone;

hp_max = global.player_hp_max;
hp = global.player_hp;

take_damage = player_take_damage;
can_play_footstep = true;
has_fired_arrow = false;

bow_shots_fired = 0;      
bow_shots_max = 4;         

bow_cooldown_timer = 0;
bow_cooldown_normal = 45;  
bow_cooldown_reload = 120;  
bow_current_max_delay = 45;
bow_autoreload_delay = 150; 
bow_idle_timer = 0;

input_locked = false;