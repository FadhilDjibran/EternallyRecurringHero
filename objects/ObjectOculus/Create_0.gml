hp = 80;
aggro_range = 160;
stop_distance = 60;
move_speed = 1.7;
dead = false;
xp_value = 50;

can_attack = true;
attacking = false;
attack_timer = 0;
attack_damage = 25;
attack_duration = 30; 
attack_cooldown = 30; 

attack_active_start = 15;
attack_active_end   = 9;

attack_hitbox_offset_x = 30; 
attack_hitbox_offset_y = -20;

SpriteIdle   = OculusIdle;
SpriteWalk   = OculusWalk;
SpriteAttack = OculusAttack;
SpriteDead   = OculusDead;
EnemyDeadSFX = OculusDeadSFX;
EnemyAttackSFX = OculusAttackSFX;

my_hitbox = noone;

grav = 0.35;
vsp = 0;
grounded   = false;

sprite_index = OculusIdle;
image_speed = 1;

take_damage = enemy_take_damage;
scale_factor = 0.8;
sprite_facing_correction = 1;
attack_scale_x = 1.6; 
attack_scale_y = 1; 
depth = 99;