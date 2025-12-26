draw_self();

if (global.current_weapon == WEAPON_TYPE.BOW && attacking)
{
    var _dir = sign(image_xscale);
    if (_dir == 0) _dir = 1; 
    var _bow_x = x + (8 * _dir); 
    
    var _bow_y = y - 22; 
    var _bow_sprite = Bow; 
    var _bow_index = image_index; 
    var _bow_scale = 1.2;
    var _bow_rot = -65 * _dir; 

    draw_sprite_ext(
        _bow_sprite,
        _bow_index,
        _bow_x,
        _bow_y,
        image_xscale * _bow_scale, 
        image_yscale * _bow_scale,
        _bow_rot,
        c_white,
        1
    );
}

if (global.current_weapon == WEAPON_TYPE.BOW && bow_cooldown_timer > 0)
{
    var _bar_w = 20;
    var _bar_h = 2;
    var _x = x - _bar_w/2;
    var _y = bbox_top - 10;
    
    var _pct = bow_cooldown_timer / bow_current_max_delay;
    
    draw_set_color(c_black);
    draw_rectangle(_x, _y, _x + _bar_w, _y + _bar_h, false);
    
    draw_set_color(c_yellow);
    draw_rectangle(_x, _y, _x + (_bar_w * _pct), _y + _bar_h, false);
    
    draw_set_color(c_white); // Reset
}