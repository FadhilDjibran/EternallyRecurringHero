hp = 100;
aggro_range = 100;
stop_distance = 40;
move_speed = 2;
dead = false;
xp_value = 75;

can_attack = true;
attacking = false;
attack_timer = 0;
attack_damage = 30;
attack_duration = 30; 
attack_cooldown = 30; 

attack_active_start = 15;
attack_active_end   = 9;

attack_hitbox_offset_x = -23; 
attack_hitbox_offset_y = -27;

SpriteIdle   = SkeletonIdle;
SpriteWalk   = SkeletonWalk;
SpriteAttack = SkeletonAttack;
SpriteDead   = SkeletonDead;
EnemyDeadSFX = SkeletonDeadSFX;
EnemyAttackSFX = OculusAttackSFX;

my_hitbox = noone;

grav = 0.35;
vsp = 0;
grounded   = false;

image_speed = 1;

take_damage = enemy_take_damage;
scale_factor = 0.85;
image_yscale = 0.85;
sprite_facing_correction = -1;
attack_scale_x = 1; 
attack_scale_y = 0.8; 