if (instance_exists(KeypadUI)) exit;

if (dead)
{
    vsp += grav; 
    if (vsp > 12) vsp = 12;
    var _sy = sign(vsp);
    var _vstep = abs(round(vsp));

    repeat(_vstep) 
    {
        if (_sy > 0) 
        {
            if (ground_at(bbox_left, bbox_bottom + 1, 1) || ground_at(bbox_right, bbox_bottom + 1, 1)) 
            {
                vsp = 0; 
                break; 
            } 
            else 
            { 
                y += 1; 
            }
        } 
        else 
        { 
            y += _sy; 
        } 
    }

    if (image_index >= image_number - 1)
    {
        image_speed = 0; 
        image_index = image_number - 1; 

        if (game_over_triggered == false) 
        {
                instance_create_layer(0, 0, "Instances", GameOver);
                game_over_triggered = true; 
        }
    }

    exit; 
}

if (bow_cooldown_timer > 0)
{
    bow_cooldown_timer--;
}

// Movement
var _key_move = (keyboard_check(vk_right) || keyboard_check(ord("D")))
              - (keyboard_check(vk_left)  || keyboard_check(ord("A")));

var _pad_move = gamepad_button_check(gamepad_index, gp_padr)
              - gamepad_button_check(gamepad_index, gp_padl);
              
var move = _key_move + _pad_move;

if (move == 0)
{

    var _axis_move = gamepad_axis_value(gamepad_index, gp_axislh);
    move = sign(_axis_move);
}
else
{
    move = clamp(move, -1, 1);
}

if (keyboard_check_pressed(vk_space)
 || keyboard_check_pressed(vk_up)
 || keyboard_check_pressed(ord("W"))
 || gamepad_button_check_pressed(gamepad_index, gp_face1)) 
{
    buffer_t = buffer_max;
}

if (input_locked)
{
    move = 0;
    buffer_t = 0;
}

if (buffer_t > 0) buffer_t--;

var _is_slow_mo = false;
if (GameManager.slow_mo_timer > 0)  _is_slow_mo = true;

if ((keyboard_check_pressed(ord("J")) 
 || gamepad_button_check_pressed(gamepad_index, gp_face3)) && !_is_slow_mo && !input_locked)
{
	
    if (!attacking && can_attack)
    {
		if (global.current_weapon == WEAPON_TYPE.BOW)
        {
            if (bow_cooldown_timer > 0) exit; 
        }
        attacking     = true;
        image_index   = 0;
        can_attack    = false;
		if (global.current_weapon == WEAPON_TYPE.SWORD)
		{
            sprite_index    = PlayerAttack; 
			attack_duration = 12; 
            attack_timer = attack_duration; 
            audio_play_sound(PlayerAttackSFX, 20, false);
        }
        else 
		 {
        sprite_index    = PlayerAttackBow; 
        attack_duration = 10; 
        attack_timer    = attack_duration; 
		audio_play_sound(BowShootSFX, 20, false, 0.5);

        bow_shots_fired++;
		
		bow_idle_timer = bow_autoreload_delay;
        
        if (bow_shots_fired >= bow_shots_max)
        {
            bow_cooldown_timer = bow_cooldown_reload; 
			bow_current_max_delay = bow_cooldown_reload;
            bow_shots_fired = 0; 

        }
        else
        {
            bow_cooldown_timer = bow_cooldown_normal; 
			bow_current_max_delay = bow_cooldown_normal;
        }
    }
    }
}

if (global.current_weapon == WEAPON_TYPE.BOW && bow_shots_fired > 0)
{
    if (bow_idle_timer > 0)
    {
        bow_idle_timer--;
    }
    else
    {
        bow_shots_fired = 0;
    }
}

if ((keyboard_check_pressed(ord("L")) || gamepad_button_check_pressed(0, gp_face2)) && global.bow_unlocked == true && !attacking && !input_locked)
{
	audio_play_sound(WeaponChangeSFX, 20, false);
    if (global.current_weapon == WEAPON_TYPE.SWORD)
    {
        global.current_weapon = WEAPON_TYPE.BOW;
    }
    else
    {
        global.current_weapon = WEAPON_TYPE.SWORD;
    }
}

// ATTACK TIMER
if (attacking)
{
    attack_timer--; 
    
    if (global.current_weapon == WEAPON_TYPE.SWORD)
    {
        if (attack_timer <= attack_active_start && attack_timer > attack_active_end)
        {
			if (!instance_exists(my_hitbox))
			{
				my_hitbox = instance_create_layer(x, y, "Instances", ObjectHitbox);
				my_hitbox.owner = id;
				my_hitbox.damage = global.player_damage; 
			}
        }
    }
    else 
    {
        if (!has_fired_arrow) 
        {
            var _arrow_spawn_y = y - 20; 
            var _arrow = instance_create_layer(x, _arrow_spawn_y, "Instances", ObjectArrow); 
            
            var _dir = sign(image_xscale);
            if (_dir == 0) _dir = 1;
            _arrow.hspeed = 7 * _dir; 
            _arrow.image_xscale = _dir; 
            if (_dir == 1) _arrow.direction = 0;
            else           _arrow.direction = 180;
            
            _arrow.damage = global.player_bow_damage;
            

            has_fired_arrow = true;
        }
    }
    if (attack_timer <= 0)
    {
        attacking = false;
        alarm[0]  = attack_cooldown;
        my_hitbox = noone;
        has_fired_arrow = false; 
    }
}


// PHYSICS
vsp += grav;
if (vsp > 12) vsp = 12;

var L = bbox_left;
var R = bbox_right;
var T = bbox_top;
var B = bbox_bottom;


// HORIZONTAL Collision
var hsp = move * move_spd;
var hstep = abs(round(hsp));
var sx = sign(hsp);

repeat (hstep)
{
    if (sx > 0)
    {
        if (!solid_at(R+1, T+2) && !solid_at(R+1, B-2))
            x += 1;
        else
            break;
    }
    else if (sx < 0)
    {
        if (!solid_at(L-1, T+2) && !solid_at(L-1, B-2))
            x -= 1;
        else
            break;
    }

    L = bbox_left; R = bbox_right; T = bbox_top; B = bbox_bottom;
}


// Vertical Collision
var was_grounded = grounded;
grounded = false;

var vstep = abs(round(vsp));
var sy = sign(vsp);

repeat (vstep)
{
    if (attacking && was_grounded && sy > 0)
    {
        if (ground_at(L+2, B, 1) || ground_at(R-2, B, 1))
        {
            grounded = true;
            vsp = 0;
            break;
        }
    }

    if (sy > 0)
    {
        var hitL = ground_at(L+2, B+1, vsp);
        var hitR = ground_at(R-2, B+1, vsp);

        if (!hitL && !hitR)
            y += 1;
        else {
            grounded = true;
            vsp = 0;
            break;
        }
    }
    else if (sy < 0)
    {
        if (!solid_at(L+2, T-1) && !solid_at(R-2, T-1))
            y -= 1;
        else {
            vsp = 0;
            break;
        }
    }

    L = bbox_left; R = bbox_right; T = bbox_top; B = bbox_bottom;
}

// Hazards logic
var hazard_id = instance_place(x, y, Hazards);

if (hazard_id != noone)
{
    var _damage = hazard_id.damage_amount;
    player_take_damage(_damage);
	if (dead) exit;
}

if (landed_cooldown > 0)
    landed_cooldown--;

// Jump
if (grounded) coyote_t = coyote_max;
else if (coyote_t > 0) coyote_t--;

if (coyote_t > 0 && buffer_t > 0)
{
    vsp = jump_spd;
    grounded = false;
    coyote_t = 0;
    buffer_t = 0;
	prev_grounded = false;
	audio_play_sound(PlayerJumpSFX, 10, false);
}

if (!attacking)
{
    if (move != 0)
        image_xscale = (move > 0 ? 1 : -1);
}

image_speed = 1;

// landing cooldown
if (grounded && !prev_grounded)
{
    landed_cooldown = landed_cooldown_max;
}

// ground animation 
if (grounded || landed_cooldown > 0)
{
    if (!attacking)
    {
        if (move != 0)
        { 
            sprite_index = PlayerRun;
            
            if (can_play_footstep)
            {
                audio_play_sound(PlayerStepGrassSFX, 3, false, 0.4);
                can_play_footstep = false;
                alarm[2] = 30; 
            }
        } 
        else
        {
            sprite_index = PlayerIdle;
        }
    }
}
// air animation
else if (!attacking)
{
    if (vsp < -2)
        sprite_index = PlayerJump;
    else if (vsp <= 2)
        sprite_index = PlayerInbetween;
    else
        sprite_index = PlayerFall;
}

prev_grounded = grounded;