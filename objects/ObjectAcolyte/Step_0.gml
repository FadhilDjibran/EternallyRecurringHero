if (dead) { exit; }
if (alarm[0] > 0) alarm[0]--; else image_blend = c_white;

var target = noone;
if (instance_exists(ObjectPlayer) && !ObjectPlayer.dead)
{
    var pl = instance_nearest(x, y, ObjectPlayer);
    var _dist_x = abs(x - pl.x);
    var _dist_y = abs(y - pl.y);

    if (_dist_x < aggro_range_x && _dist_y < aggro_range_y) 
    {
        target = pl;
    }
}

if (knockback_time > 0)
{
    knockback_time--;
    hsp = lerp(hsp, 0, 0.1); 
    vsp = lerp(vsp, 0, 0.1);
}

if (attacking)
{
    if (knockback_time <= 0)
    {
        hsp = 0;
        vsp = 0;
    }

    if (target != noone)
    {
        var _face_dir = sign(target.x - x);
        if (_face_dir != 0) image_xscale = scale_factor * _face_dir * sprite_facing_correction;
    }

	if (image_index >= attack_frame_sound && !has_played_sound)
    {
		audio_play_sound(EnemyAttackSFX, 10, false, 0.5);
		has_played_sound = true;
    }

    if (image_index >= attack_frame_release && !has_fired)
    {
        if (target != noone) 
        {
            var _staff_y_offset = 55; // Sesuaikan
            var _shoot_origin_y = y - _staff_y_offset;
            var _dir = point_direction(x, _shoot_origin_y, target.x, target.y - 16);
            
            var _spawn_dist = 20;
            var _spawn_x = x + lengthdir_x(_spawn_dist, _dir);
            var _spawn_y = _shoot_origin_y + lengthdir_y(_spawn_dist, _dir);
            
            var _proj = instance_create_layer(_spawn_x, _spawn_y, "Instances", ObjectFireball);
            _proj.direction = _dir;
            _proj.speed = projectile_speed;
            _proj.damage = attack_damage;
            _proj.image_angle = _dir;
        }
        has_fired = true; 
    }

    if (image_index >= image_number - 1)
    {
        attacking = false;
        sprite_index = AcolyteIdle; 
        attack_timer = attack_cooldown; 
    }
}
else
{
    if (attack_timer > 0) attack_timer--;

    if (knockback_time <= 0)
    {
        hsp = 0;
        vsp = 0;

        if (target != noone)
        {
            var _dist_to_player = point_distance(x, y, target.x, target.y - flying_height_offset);
            
            // Trigger Attack
            if (_dist_to_player <= stop_distance && attack_timer <= 0)
            {
                attacking = true;
                has_fired = false;
				has_played_sound = false;
                sprite_index = AcolyteAttack;
                image_index = 0;
            }
            // Trigger Chase
            else if (_dist_to_player > stop_distance)
            {
                var _target_y_pos = target.y - flying_height_offset;
                var _dir = point_direction(x, y, target.x, _target_y_pos);
                
                hsp = lengthdir_x(move_speed, _dir);
                vsp = lengthdir_y(move_speed, _dir);
                
                var _face_dir = sign(target.x - x);
                if (_face_dir != 0) image_xscale = scale_factor * _face_dir * sprite_facing_correction;
                
                sprite_index = AcolyteFly; 
            }
            else
            {
                 sprite_index = AcolyteIdle; 
            }
        }
        else
        {
            sprite_index = AcolyteIdle; 
        }
    }
}

var _h_side;
if (hsp > 0) _h_side = bbox_right; else _h_side = bbox_left;
if (solid_at(_h_side + hsp, bbox_top) || solid_at(_h_side + hsp, bbox_bottom))
{
    hsp = 0; 
}
else
{
    x += hsp;
}

var _v_side;
if (vsp > 0) _v_side = bbox_bottom; else _v_side = bbox_top;

if (solid_at(bbox_left, _v_side + vsp) || solid_at(bbox_right, _v_side + vsp))
{
    vsp = 0; 
}
else
{
    y += vsp; 
}