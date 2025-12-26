hp = 300;
aggro_range = 250;
stop_distance = 180;
move_speed = 1.51;
dead = false;
xp_value = 600;

can_attack = true;
attacking = false;
attack_timer = 0;
attack_damage = 55;
attack_duration = 50; 
attack_cooldown = 70; 
projectile_speed = 4;
has_fired = false;
attack_frame_release = 8;

// 0 = Fireball, 1 = Summon Oculus
attack_pattern = 0;

//// Variabel Hitbox (Unused)
//attack_active_start = 15;
//attack_active_end   = 9;
//attack_hitbox_offset_x = 30; 
//attack_hitbox_offset_y = -20;
//my_hitbox = noone;

SpriteIdle   = NecromancerIdle;
SpriteWalk   = NecromancerWalk;
SpriteAttack = NecromancerAttack;
SpriteDead   = NecromancerDead;
SpriteSpawn =  NecromancerSpawn;
EnemyDeadSFX = OculusDeadSFX;
EnemyAttackSFX = FireballSFX;
EnemySpawnSFX = NecromancerSpawnSFX;

grav = 0.35;
vsp = 0;
grounded   = false;
knockback_hsp = 0;

sprite_index = NecromancerIdle;
image_speed = 1;

take_damage = enemy_take_damage;
scale_factor = 1;
sprite_facing_correction = 1;
attack_scale_x = 1.6; 
attack_scale_y = 1; 
sprite_facing_correction = 1
depth = 99;