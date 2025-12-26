if (dead) { exit; }
if (alarm[0] > 0) alarm[0]--; else image_blend = c_white;

knockback_hsp = lerp(knockback_hsp, 0, 0.1); 

var target = noone;
if (instance_exists(ObjectPlayer) && !ObjectPlayer.dead)
{
    var pl = instance_nearest(x, y, ObjectPlayer);
    var dist = point_distance(x, y, pl.x, pl.y);
    if (dist < aggro_range) target = pl;
}

var hmove = 0;

if (attacking)
{
    hmove = 0; 
    
    if (target != noone)
    {
        var _face_dir = sign(target.x - x);
        if (_face_dir != 0) image_xscale = scale_factor * _face_dir * sprite_facing_correction;
    }

    if (image_index >= attack_frame_release && !has_fired)
    {
        var _dir_facing = sign(image_xscale * sprite_facing_correction); 
        if (_dir_facing == 0) _dir_facing = 1;

        if (attack_pattern < 2) 
        {
            if (target != noone) 
            {
				audio_play_sound(EnemyAttackSFX, 10, false, 0.5);
                var _spawn_x = x + (18 * _dir_facing);
                var _spawn_y = y - 35; 
                
                var _proj = instance_create_layer(_spawn_x, _spawn_y, "Instances", ObjectFireball);
                var _aim_dir = point_direction(_spawn_x, _spawn_y, target.x, target.y - 16);
                
                _proj.direction = _aim_dir;
                _proj.speed = projectile_speed;
                _proj.damage = attack_damage;
                _proj.image_angle = _aim_dir;
            }
            attack_pattern++; 
        }
        else 
        {
			audio_play_sound(EnemySpawnSFX, 2, false);
            var _spawn_x = x + (25 * _dir_facing); 
            var _spawn_y = y; 
            
            if (!solid_at(_spawn_x, _spawn_y - 8))
            {
                var _minion = instance_create_layer(_spawn_x, _spawn_y, "Instances", ObjectOculus);
                
                var _new_scale = 0.8; 
                _minion.scale_factor = _new_scale;
                _minion.image_xscale = _new_scale; 
                _minion.image_yscale = _new_scale; 
                _minion.image_xscale = _new_scale * _dir_facing * _minion.sprite_facing_correction;
                
                _minion.knockback_time = 30;
                _minion.hsp = 0;
            }
            attack_pattern = 0; 
        }
        
        has_fired = true; 
		
    }

    if (image_index >= image_number - 1)
    {
        attacking = false;
        sprite_index = SpriteIdle; 
        attack_timer = attack_cooldown; 
    }
}
else
{
    if (attack_timer > 0) attack_timer--;

    if (target != noone)
    {
        var dx = target.x - x;
        var dy = abs(target.y - y); 
        var vertical_leeway = 64; 

        if (abs(dx) <= stop_distance && dy <= vertical_leeway && attack_timer <= 0)
        {
            attacking = true;
            has_fired = false;
            image_index = 0;

            if (attack_pattern == 2)
            {
                var _check_dir = sign(dx); if (_check_dir == 0) _check_dir = 1;
                
                var _spawn_x_check = x + (40 * _check_dir);
                
                if (!ground_at(_spawn_x_check, bbox_bottom + 1, 1))
                {
                    attack_pattern = 0; 
                }
            }
            if (attack_pattern < 2) sprite_index = SpriteAttack; 
            else                    sprite_index = SpriteSpawn; 
        }
        else if (abs(dx) > stop_distance)
        {
            hmove = sign(dx);
            sprite_index = SpriteWalk; 
        }
        else
        {
             sprite_index = SpriteIdle; 
        }
        
        if (hmove != 0)
        {
            var _target_dir = sign(dx); 
            if (_target_dir == 0) _target_dir = 1;
            image_xscale = scale_factor * _target_dir * sprite_facing_correction;
        }
    }
    else
    {
        sprite_index = SpriteIdle; 
    }
    
    if (hmove != 0)
    {
        var _dist_check = 32; 
        var _friend_ahead = instance_place(x + (hmove * _dist_check), y, ObjectEnemy);
        if (_friend_ahead != noone) hmove = 0;
    }
}

vsp += grav; 
if (vsp > 12) vsp = 12;

if (grounded && hmove != 0)
{
    var L=bbox_left; var R=bbox_right; var B=bbox_bottom;
    var check_x = (hmove > 0) ? R + 2 : L - 2;
    var check_y = B + 4;
    if (!ground_at(check_x, check_y, 1)) hmove = 0;
}

var hsp_final = (hmove * move_speed) + knockback_hsp; 

var hstep = abs(round(hsp_final));
var sx = sign(hsp_final);
var L=bbox_left; var R=bbox_right; var T=bbox_top; var B=bbox_bottom;

repeat (hstep) {
    if (sx > 0) {
        if (!solid_at(R+2, T+6) && !solid_at(R+2, B-2)) x += 1;
        else { knockback_hsp = 0; break; }
    } else if (sx < 0) {
        if (!solid_at(L-2, T+6) && !solid_at(L-2, B-2)) x -= 1;
        else { knockback_hsp = 0; break; }
    }
    L=bbox_left; R=bbox_right; T=bbox_top; B=bbox_bottom;
}

var was_grounded = grounded;
grounded = false;
var vstep = abs(round(vsp));
var sy = sign(vsp);

repeat (vstep) {
    if (sy > 0) {
        var hitL = ground_at(L+4, B+1, 1);
        var hitR = ground_at(R-4, B+1, 1);
        if (!hitL && !hitR) y += 1;
        else { grounded = true; break; }
    } else if (sy < 0) {
        if (!solid_at(L+4, T-1) && !solid_at(R-4, T-1)) y -= 1;
        else { vsp = 0; break; }
    }
    L=bbox_left; R=bbox_right; T=bbox_top; B=bbox_bottom;
}

var hazard_id = instance_place(x, y, Hazards);
if (hazard_id != noone)
{
    var _damage = hazard_id.damage_amount;
    enemy_take_damage(_damage);
}