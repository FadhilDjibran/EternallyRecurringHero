hp = 150;
aggro_range_x = 300; 
aggro_range_y = 300;
stop_distance = 120;
move_speed = 1.3;
dead = false;
xp_value = 200;
flying_height_offset = 5;

can_attack = true;
attacking = false;
attack_timer = 0;
attack_damage = 40;
attack_duration = 30; 
attack_cooldown = 60;
projectile_speed = 3.5;
has_fired = false;
has_played_sound = false;
attack_frame_release = 10;
attack_frame_sound   = 8;
knockback_time = 0;

//// Variabel Hitbox (Unused)
//attack_active_start = 15;
//attack_active_end   = 9;
//attack_hitbox_offset_x = -23; 
//attack_hitbox_offset_y = -27;

SpriteIdle   = AcolyteIdle;
SpriteWalk   = AcolyteFly;
SpriteAttack = AcolyteAttack;
SpriteDead   = AcolyteDead;
EnemyDeadSFX = OculusDeadSFX;
EnemyAttackSFX = FireballSFX;   

my_hitbox = noone;

grav = 0.35;
hsp = 0;
vsp = 0;
grounded   = false;

image_speed = 1;

take_damage = enemy_take_damage;
scale_factor = 0.8;
image_xscale = 0.8;
image_yscale = 0.8;
sprite_facing_correction = 1;
attack_scale_x = 1; 
attack_scale_y = 1; 