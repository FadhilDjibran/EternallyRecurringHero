// Fungsi take damage player
function player_take_damage(amount)
{
    if (alarm[1] > 0) exit; 
	
	if (amount >= 9999)
    {
		audio_play_sound(FallingSFX, 10, false); 
        vsp = 0; 
    }
    else
    {
        audio_play_sound(ObjectHitSFX, 10, false); 
        vsp = -3; 
    }      
    grounded = false;  
    
    alarm[1] = 30;     

    var _blocked_fully = false; 
    
    if (global.player_shield > 0)
    {
        var _damage_absorbed = min(global.player_shield, amount);

        global.player_shield -= _damage_absorbed;

        amount -= _damage_absorbed;

        if (amount <= 0)
        {
            _blocked_fully = true;
        }
    }

    if (_blocked_fully)
    {
        image_blend = c_blue; 
    }
    else
    {
        image_blend = c_red;
        
        global.player_hp -= amount; 
        hp = global.player_hp;
    }
    
	if (global.player_hp <= 0 && !dead)
    {
        dead = true;
        sprite_index = PlayerDead; 
        image_index = 0;
        image_speed = 1;

        if (amount >= 9999) 
        {}
        else
        {
            audio_play_sound(OculusDeadSFX, 10, false); 
        }

        with (ObjectHitbox)
        {
            if (owner == other.id) instance_destroy();
        }
    }
}

function enemy_take_damage(amount)
{
    
    if (dead) exit; 
	
	hp -= amount; 
	
	if (amount >= 9999)
    {
        if (audio_exists(FallingSFX)) audio_play_sound(FallingSFX, 10, false);
        
        knockback_time = 0; 
    }
	else
	{
	audio_play_sound(ObjectHitSFX, 10, false); 
    
	
	image_blend = c_red; 
	alarm[0] = 10;
    
    if (variable_instance_exists(id, "knockback_time"))
    {
        knockback_time = 20;
        var _player = instance_nearest(x, y, ObjectPlayer);
        var _dir_away = 90; 
  
        if (_player != noone)
        {
            _dir_away = point_direction(_player.x, _player.y - 16, x, y);
        }
        var _knock_force = 4; 
        hsp = lengthdir_x(_knock_force, _dir_away);
        vsp = lengthdir_y(_knock_force, _dir_away);
    }
    else
    {  
        vsp = -3;                 
        grounded = false;         
    }
	}
    
    if (hp <= 0 && !dead)
    {
        dead = true;
       
        if (amount < 9999)
        {
            audio_play_sound(EnemyDeadSFX, 15, false);
            gain_xp(xp_value);
            
            sprite_index = SpriteDead;
            image_index = 0;
            image_speed = 1;
            
            vsp = 0; 
        }
        else
        {
		gain_xp(xp_value);
        }
    }
}