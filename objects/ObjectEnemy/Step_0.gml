if (dead)
{
    exit;
}

// Menemukan objek player
var target = noone;

if (instance_exists(ObjectPlayer) && !ObjectPlayer.dead)
{
    var pl = instance_nearest(x, y, ObjectPlayer);
    var dist = point_distance(x, y, pl.x, pl.y);

    if (dist < aggro_range)
        target = pl;
}
else
{
    target = noone;
}


// Algoritma Pergerakan ke player
var hmove = 0;

if (target != noone && !dead) 
{
    var dx = target.x - x;
	var dy = abs(target.y - y); 
    var vertical_leeway = 16;

    if (abs(dx) <= stop_distance && dy <= vertical_leeway && !attacking && can_attack)
    {
        attacking = true;
        can_attack = false;
        attack_timer = attack_duration;
        
        sprite_index = SpriteAttack; 
        image_index = 0;
        
        hmove = 0; 
		audio_play_sound(EnemyAttackSFX, 5, false);
    }

    else if (abs(dx) > stop_distance && !attacking)
    {
        hmove = sign(dx);
    }
	
	if (hmove != 0)
    {
        var _dist_check = 3; 
        var _check_x = x + (hmove * _dist_check);
        var _friend_ahead = instance_place(_check_x, y, ObjectEnemy);
        if (_friend_ahead != noone)
        {
              var _is_necro = (object_index == ObjectNecromancer) || (_friend_ahead.object_index == ObjectNecromancer);

               if (_is_necro == false)
                {
                    hmove = 0;
                }
        }
    }

    // Atur arah 
    if (!attacking)
    {
        var _target_dir = sign(dx); 
        if (_target_dir == 0) _target_dir = 1;
        image_xscale = -1*(scale_factor * _target_dir * sprite_facing_correction);
    }
}


// Physics dan gravity
vsp += grav;
if (vsp > 12) vsp = 12;

var L=bbox_left;
var R=bbox_right;
var T=bbox_top;
var B=bbox_bottom;

if (grounded && hmove != 0)
{
    var check_x = (hmove > 0) ? R + 2 : L - 2;
    var check_y = B + 4;

    var safe = ground_at(check_x, check_y, 1);

    if (!safe)
    {
        hmove = 0;
    }
}

var _other_enemy = instance_place(x, y, ObjectEnemy);

if (_other_enemy != noone)
{
    var _is_necro_involved = (object_index == ObjectNecromancer) || (_other_enemy.object_index == ObjectNecromancer);

    if (_is_necro_involved == false)
    {
        
        var _push_dir = sign(x - _other_enemy.x);
        
        if (_push_dir == 0)
        {
            if (id > _other_enemy.id) _push_dir = 1;
            else                      _push_dir = -1;
        }
        
        var _push_spd = 2;
        
        var _target_x = x + (_push_dir * 4); 
        
        var _check_y_body = y - (sprite_height / 2); 
        var _wall_safe = !solid_at(_target_x, _check_y_body);
        
        var _floor_safe = true; 
        if (grounded)
        {
            _floor_safe = ground_at(_target_x, bbox_bottom + 1, 1);
        }
        
        if (_wall_safe && _floor_safe)
        {
            x += _push_dir * _push_spd;
        }
        
    }
}

// HORIZONTAL COLLISION
var hsp = hmove * move_speed;
var steps_h = abs(round(hsp));
var sx = sign(hsp);

repeat (steps_h)
{
    if (sx > 0) {
        if (!solid_at(R+2, T+6) && !solid_at(R+2, B-2))
            x += 1;
        else break;
    }
    else if (sx < 0) {
        if (!solid_at(L-2, T+6) && !solid_at(L-2, B-2))
            x -= 1;
        else break;
    }

    L=bbox_left; R=bbox_right; T=bbox_top; B=bbox_bottom;
}


// VERTICAL COLLISION
var was_grounded = grounded;
grounded = false;

var steps_v = abs(round(vsp));
var sy = sign(vsp);

repeat (steps_v)
{
    if (sy > 0)
    {
        var hitL = enemy_ground_at(L+4, B+1);
        var hitR = enemy_ground_at(R-4, B+1);

        if (!hitL && !hitR)
            y += 1;
        else {
            grounded = true;
            break;
        }
    }
    else if (sy < 0)
    {
        if (!solid_at(L+4, T-1) && !solid_at(R-4, T-1))
            y -= 1;
        else {
            vsp = 0;
            break;
        }
    }

    L=bbox_left; R=bbox_right; T=bbox_top; B=bbox_bottom;
}


// ANIMATION

if (attacking || dead){
}
else
{
	var _is_actually_moving = (abs(x - xprevious) > 0.1);
    if (grounded && abs(hmove) > 0 && _is_actually_moving)
    {
        sprite_index = SpriteWalk;
    }
    else
    {
        sprite_index = SpriteIdle;
    }
}

//  ATTACK TIMER & HITBOX
if (attacking)
{
    attack_timer--;
    
    if (attack_timer <= attack_active_start && attack_timer > attack_active_end)
    {
        if (!instance_exists(my_hitbox))
        {
            my_hitbox = instance_create_layer(x, y, "Instances", ObjectHitboxEnemy);
            my_hitbox.owner = id;
			my_hitbox.hitbox_w = attack_scale_x; 
            my_hitbox.hitbox_h = attack_scale_y;
            
            my_hitbox.damage = attack_damage;
        }
    }
    
    if (attack_timer <= 0)
    {
        attacking = false;
        my_hitbox = noone;
        alarm[1] = attack_cooldown; 
    }
}

var hazard_id = instance_place(x, y, Hazards);

if (hazard_id != noone)
{
    var _damage = hazard_id.damage_amount;
    enemy_take_damage(_damage);
}