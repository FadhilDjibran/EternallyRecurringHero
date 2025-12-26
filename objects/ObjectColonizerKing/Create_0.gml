knockback_time = 0;    

hp = 750;        
hp_max = 750;       
aggro_range = 800; 
stop_distance = 60;
move_speed = 1.2;  
dead = false;
xp_value = 0;    
flying_height_offset = 40; 

death_flash_timer = -1;
attack_hitbox_offset_x = -15; 
attack_hitbox_offset_y = 0;

can_attack = true;
attacking = false;
attack_timer = 0;
attack_damage = 60; 
attack_duration = 60; 
attack_cooldown = 60; 
projectile_speed = 4;
has_fired = false;

attack_charge_timer = 0; 
attack_charge_max = 30; 

SpriteIdle   = ColonizerKING;   
SpriteWalk   = ColonizerKING;
SpriteAttack = ColonizerKING;
SpriteDead   = ColonizerKING;
EnemyDeadSFX = OculusDeadSFX;    
EnemyAttackSFX = OculusAttackSFX; 

my_hitbox = noone;

grav = 0; 
hsp = 0;
vsp = 0;
grounded = false;

image_speed = 0; 

take_damage = enemy_take_damage;

base_scale = 1;
scale_factor = 1;
image_xscale = 1;
image_yscale = 1;
sprite_facing_correction = 1; 

float_offset = 0; 
float_speed = 0.05;
original_y = y;
attack_pattern = 0;

// intro
state_intro = true;          
intro_sub_state = 0;     
start_y = y;                 
spawn_y = y - 100;           
y = spawn_y;                


descent_duration = 90;     
descent_timer = 0;    
descent_pause_duration = 25; 
descent_pause_timer = descent_pause_duration;

swell_duration = 90;         
swell_timer = swell_duration; 

shrink_duration = 30;        
shrink_timer = shrink_duration;

intro_max_scale = base_scale * 1.2;      
has_roared_low_hp = false;
has_roared_dead = false;