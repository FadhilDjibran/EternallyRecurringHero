if (dead) 
{
	global.timer_active = false;
	global.timer_finished = true;
    image_angle = 0;
	if (has_roared_dead == false){
	var _snd = audio_play_sound(KingGrowlSFX, 15, false);
	audio_sound_pitch(_snd, 0.8);
    has_roared_dead = true;
	}
	
    if (death_flash_timer == -1) 
    {
        death_flash_timer = 60; 
		instance_destroy(ObjectFireball);
        instance_destroy(ObjectHitboxEnemy);  
        game_set_speed(15, gamespeed_fps);
        GameManager.slow_mo_timer = 30;
        ObjectPlayer.input_locked = true;
        audio_stop_sound(GameManager.current_music);
        GameManager.current_music = noone; 
        
        audio_stop_sound(EnemyAttackSFX); 
        audio_play_sound(EnemyDeadSFX, 15, false);
    }

    if (death_flash_timer > 0)
    {
        death_flash_timer--;
        
        if (death_flash_timer % 15 == 0) 
        {
            alarm[2] = 3; 
        }
        x += random_range(-2, 2);
        y += random_range(-2, 2);
        
        var _pulse = 1 + (sin(current_time * 0.00005) * 0.1);
        image_xscale = base_scale * _pulse;
        image_yscale = base_scale * _pulse;
        
        exit; 
    }
    
    if (image_alpha == 1)
    {
        audio_play_sound(ExplodeSFX, 15, false);
        var _boom = instance_create_layer(x, y, "Instances", ObjectExplosion);
        _boom.image_xscale = 2;
        _boom.image_yscale = 2;
        ObjectPlayer.input_locked = false;
    }

    image_alpha -= 0.01; 
    
    image_xscale = lerp(image_xscale, base_scale, 0.1);
    image_yscale = lerp(image_yscale, base_scale, 0.1);
    
    if (image_alpha <= 0) 
    {
        GameManager.win_delay_timer = 60;
        instance_destroy();
    }
    
    exit;
}

if (alarm[0] > 0) 
{
    alarm[0]--; 
} 
else 
{
    if (attacking && attack_charge_timer < attack_charge_max)
    {
        image_blend = c_orange; 
    }
    else
    {
        image_blend = c_white; 
    }
}

float_offset += float_speed;
var _hover_amount = sin(float_offset) * 0.8; 
y += _hover_amount; 

if (state_intro)
{
    if (instance_exists(ObjectPlayer))
    {
        ObjectPlayer.input_locked = true;
        ObjectPlayer.hsp = 0;
        ObjectPlayer.move = 0;
    }

    switch (intro_sub_state)
    {
        case 0:
            if (descent_timer < descent_duration)
            {
                descent_timer++;
                var _prog = descent_timer / descent_duration;
                
                y = lerp(spawn_y, start_y, _prog);
            }
            else
            {
                y = start_y; 
                
                descent_pause_timer--;
                
                if (descent_pause_timer <= 0)
                {
                    intro_sub_state = 1; 
					audio_play_sound(KingGrowlSFX, 10, false);
                }
            }
        break;

        case 1:
            swell_timer--;

            x = xstart + random_range(-3, 3);
            y = start_y + random_range(-3, 3);

            image_xscale = lerp(image_xscale, intro_max_scale, 0.05);
            image_yscale = lerp(image_yscale, intro_max_scale, 0.05);
            
            image_blend = c_orange; 

            if (swell_timer <= 0)
            {
                intro_sub_state = 2; 
            }
        break;

        case 2:
            shrink_timer--;

            x = xstart;
            y = start_y;
            image_blend = c_white; 

            image_xscale = lerp(image_xscale, base_scale, 0.2);
            image_yscale = lerp(image_yscale, base_scale, 0.2);

            if (shrink_timer <= 0)
            {
                image_xscale = base_scale;
                image_yscale = base_scale;
                
                intro_sub_state = 3; 
            }
        break;

        case 3:
            state_intro = false; 

            if (instance_exists(ObjectPlayer))
            {
                ObjectPlayer.input_locked = false;
            }
        break;
    }

    exit;
}

var target = noone;
if (instance_exists(ObjectPlayer) && !ObjectPlayer.dead)
{
    var pl = instance_nearest(x, y, ObjectPlayer);
    if (point_distance(x, 0, pl.x, 0) < aggro_range) target = pl;
}

if (knockback_time > 0 && !attacking)
{
    knockback_time--;
    hsp = lerp(hsp, 0, 0.05);
    vsp = lerp(vsp, 0, 0.05);
}
else
{
    hsp = 0;
    vsp = 0;

    if (attacking)
    {
        knockback_time = 0;
        attack_charge_timer++;

        if (attack_charge_timer < attack_charge_max)
        {
            x += random_range(-2, 2);
           

            if (attack_pattern == 1)
            {
                var _facing = sign(image_xscale);
                if (_facing == 0) _facing = 1;
                
                var _windup_angle = -45 * _facing; 
                
                image_angle = lerp(image_angle, _windup_angle, 0.1);
            }
            else
            {
                image_angle = lerp(image_angle, 0, 0.2);
            }
        }
        else
        {
            if (attack_pattern == 1)
            {
                var _facing = sign(image_xscale);
                if (_facing == 0) _facing = 1;

                var _slash_angle = 20 * _facing;
                
                image_angle = lerp(image_angle, _slash_angle, 0.4); 
            
                var _dash_speed = 3; 
                var _move_amount = _dash_speed * _facing;
                
                if (!solid_at(x + _move_amount, y))
                {
                    x += _move_amount;
                }

                if (!has_fired)
                {
                    var _melee = instance_create_layer(x, y, "Instances", ObjectHitboxEnemy);
                    _melee.owner = id;
                    _melee.damage = attack_damage * 1.5; 
                    _melee.lifetime = (attack_duration - attack_charge_max); 
                    
                    _melee.hitbox_w = 2; 
                    _melee.hitbox_h = 3;
                    
                    audio_play_sound(KingSlashSFX, 20, false);
                    
                    has_fired = true; 
                }
            }
            else if (attack_pattern == 0)
            {
                if (!has_fired)
                {
                    if (target != noone) 
                    {
                        var _dir_center = point_direction(x, y, target.x, target.y);
                        for (var i = -1; i <= 1; i++) {
                            var _proj = instance_create_layer(x, y, "Instances", ObjectFireball);
                            var _spread = 40; 
                            var _final_dir = _dir_center + (i * _spread);
                            _proj.direction = _final_dir;
                            _proj.speed = projectile_speed;
                            _proj.damage = attack_damage;
                            _proj.image_angle = _final_dir;
                            _proj.image_blend = c_aqua;
                            _proj.image_xscale = 0.07;
                            _proj.image_yscale = 0.07;
                        }
                        audio_play_sound(FireballSFX, 10, false);
                    }
                    has_fired = true; 
                }
            }
        }
        
        if (attack_charge_timer >= attack_duration)
        {
            attacking = false;
            attack_timer = attack_cooldown; 
            attack_charge_timer = 0;
            image_angle = 0; 
        }
    }   
    else
    {
        image_angle = lerp(image_angle, 0, 0.1);

        if (attack_timer > 0) attack_timer--;

        if (target != noone)
        {
            var _dist_to_player = point_distance(x, y, target.x, target.y - flying_height_offset);
            
            if (attack_timer <= 0)
            {
                attacking = true;
                has_fired = false;
                attack_charge_timer = 0; 
				
				var _face_dir = sign(target.x - x);
				if (_face_dir != 0) image_xscale = scale_factor * _face_dir * sprite_facing_correction;
				
                if (_dist_to_player < 120) attack_pattern = 1; 
                else                       attack_pattern = 0;
            }
            else if (_dist_to_player > stop_distance)
            {
                var _target_y_pos = target.y - flying_height_offset;
                var _dir = point_direction(x, y, target.x, _target_y_pos);
                
                hsp = lengthdir_x(move_speed, _dir);
                vsp = lengthdir_y(move_speed, _dir);
                
                var _face_dir = sign(target.x - x);
                if (_face_dir != 0) image_xscale = scale_factor * _face_dir * sprite_facing_correction;
            }
        }
    }
    
    if (!solid_at(x + hsp, y)) x += hsp;
    if (!solid_at(x, y + vsp)) y += vsp;
}

var _low_hp_threshold = hp_max * 0.30;

if (hp <= _low_hp_threshold && has_roared_low_hp == false)
{
    audio_play_sound(KingGrowlSFX, 10, false);
    has_roared_low_hp = true;
}