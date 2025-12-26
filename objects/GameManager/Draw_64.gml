if (room != TitleScreen && room != IntroScreen && !instance_exists(OutroStory) && room != EndScreen && room != Cutscene && !paused && !instance_exists(GameOver))
{
var _hp = max(0, global.player_hp);
var _hp_max = global.player_hp_max;

var _xp = global.current_xp
var _xp_max = global.max_xp

var _bar_x = 16;                
var _bar_y = 16;                
var _bar_w = 300;               
var _bar_h = 40;                
var _outline_thickness = 4;
var _bar_spacing = 8;

var _col_bg = c_dkgray;         
var _col_hp = c_lime;  
var _col_xp = c_orange; 

var _hp_percent = _hp / _hp_max;
var _hp_w = _bar_w * _hp_percent; 

var _xp_percent = 0;
if (_xp_max > 0) {
    _xp_percent = _xp / _xp_max;
}
var _xp_w = _bar_w * _xp_percent;
var _exp_bar_y = _bar_y + _bar_h + _bar_spacing; 


draw_set_color(c_black);
draw_rectangle(_bar_x - _outline_thickness, _bar_y - _outline_thickness, _bar_x + _bar_w + _outline_thickness, _bar_y + _bar_h + _outline_thickness, false);

draw_set_color(_col_bg);
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);

if (_hp > 0)
{
    draw_set_color(_col_hp);
    draw_rectangle(_bar_x, _bar_y, _bar_x + _hp_w, _bar_y + _bar_h, false);
}

draw_set_font(fnt_control);   
draw_set_valign(fa_middle); 
draw_set_color(c_black);   
draw_set_halign(fa_center); 

var _text_hp = string(round(_hp)) + " / " + string(_hp_max);
draw_text(_bar_x + (_bar_w / 2), _bar_y + (_bar_h / 2), _text_hp);

draw_set_color(c_black);
draw_rectangle(_bar_x - _outline_thickness, _exp_bar_y - _outline_thickness, _bar_x + _bar_w + _outline_thickness, _exp_bar_y + _bar_h + _outline_thickness, false);

draw_set_color(_col_bg);
draw_rectangle(_bar_x, _exp_bar_y, _bar_x + _bar_w, _exp_bar_y + _bar_h, false);

if (_xp > 0)
{
    draw_set_color(_col_xp);
    draw_rectangle(_bar_x, _exp_bar_y, _bar_x + _xp_w, _exp_bar_y + _bar_h, false);
}

draw_set_color(c_black);   
draw_set_halign(fa_left); 
draw_text(_bar_x + 10, _exp_bar_y + (_bar_h / 2), "LVL " + string(global.level));



draw_set_halign(fa_left); 
draw_set_valign(fa_top);

    var _box_h = (_bar_h * 2) + _bar_spacing; 
    var _half_size = _box_h / 2; 
    var _wpn_icon_x = _bar_x + _bar_w + 10 + _half_size; 
    
    var _wpn_icon_y = _bar_y + _half_size;
    
    var _wpn_sprite = noone;
    var _wpn_scale = 4; 
    
    if (global.current_weapon == WEAPON_TYPE.SWORD)
    {
        _wpn_sprite = Sword; 
    }
    else if (global.current_weapon == WEAPON_TYPE.BOW)
    {
        _wpn_sprite = Bow; 
    }
    
    if (sprite_exists(_wpn_sprite))
    {
        draw_set_color(c_dkgray);
        draw_rectangle(_wpn_icon_x - _half_size, _wpn_icon_y - _half_size, _wpn_icon_x + _half_size, _wpn_icon_y + _half_size, false);
        
        draw_set_color(c_black);
        draw_rectangle(_wpn_icon_x - _half_size, _wpn_icon_y - _half_size, _wpn_icon_x + _half_size, _wpn_icon_y + _half_size, true);
        
        draw_sprite_ext(_wpn_sprite, 0, _wpn_icon_x, _wpn_icon_y, _wpn_scale, _wpn_scale, 0, c_white, 1);
        
        if (global.current_weapon == WEAPON_TYPE.BOW && instance_exists(ObjectPlayer))
        {
            if (ObjectPlayer.bow_cooldown_timer > 0)
            {
                var _pct = ObjectPlayer.bow_cooldown_timer / ObjectPlayer.bow_current_max_delay;
                
                draw_set_color(c_black);
                draw_set_alpha(0.6);
                
                var _h_cooldown = _box_h * _pct; 
                
                
                draw_rectangle(_wpn_icon_x - _half_size, _wpn_icon_y - _half_size, _wpn_icon_x + _half_size, (_wpn_icon_y - _half_size) + _h_cooldown, false);
                
                draw_set_alpha(1.0);
            }

            var _is_reloading = (ObjectPlayer.bow_current_max_delay == ObjectPlayer.bow_cooldown_reload && ObjectPlayer.bow_cooldown_timer > 0);
            
            var _ammo_max = ObjectPlayer.bow_shots_max; 
            var _ammo_left = _ammo_max - ObjectPlayer.bow_shots_fired; 
            
            var _ammo_y = _wpn_icon_y + _half_size + 6; 
            var _box_w = 12; 
            _box_h = 6;  
            var _gap = 4;   
            
            var _total_width = (_ammo_max * _box_w) + ((_ammo_max - 1) * _gap);
            var _start_x = _wpn_icon_x - (_total_width / 2);

            if (_is_reloading)
            {
                draw_set_halign(fa_center);
                draw_set_valign(fa_top);
                draw_set_color(c_red);
                
                draw_text_transformed(_wpn_icon_x, _ammo_y, "RELOAD", 0.7, 0.7, 0); 
            }
            else
            {
                for (var i = 0; i < _ammo_max; i++)
                {
                    var _bx = _start_x + (i * (_box_w + _gap));
                    var _by = _ammo_y;

                    if (i < _ammo_left) 
                    {
                        draw_set_color(c_yellow);
                    }
                    else 
                    {
                        draw_set_color(c_black);
                    }
                    
                    draw_rectangle(_bx, _by, _bx + _box_w, _by + _box_h, false);
                    
                    draw_set_color(c_dkgray);
                    draw_rectangle(_bx, _by, _bx + _box_w, _by + _box_h, true);
                }
            }
            
            // Reset Warna
            draw_set_color(c_white);
        }
    }

    if (global.player_shield > 0)
    {
        var _shield_val = round(global.player_shield);

        var _shield_x = _wpn_icon_x + 75; 
        var _shield_y = _bar_y + (_bar_h / 2);
        
        draw_set_color(c_blue);
        draw_circle(_shield_x, _shield_y, 24, false);
        draw_set_color(c_aqua); 
        draw_circle(_shield_x, _shield_y, 24, true);
        
        draw_set_font(fnt_control); 
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_shield_x, _shield_y, string(_shield_val));
    }
    
    // Reset alignment
    draw_set_halign(fa_left); 
    draw_set_valign(fa_top);


    // CONTROLS TEXT
    draw_set_font(fnt_control);

    var _margin = 16; 
    var _x = _margin;
    var _y = 120; 

    var _line_height = string_height("A") + 6;
    var _shadow_offset = 2; 
	
	// Cycle text
	draw_set_font(fnt_title); 
    
    var _gui_w = display_get_gui_width();
    var _cycle_x = _gui_w - 32; 
    var _cycle_y = 20;        
    var _cycle_text = "CYCLE " + string(global.run_cycle);

    var _txt_w = string_width(_cycle_text);
    var _txt_h = string_height(_cycle_text);

    var _bg_x = _cycle_x - (_txt_w / 2);
    var _bg_y = _cycle_y + (_txt_h / 2); 

    draw_sprite_ext(GuiSign, 0, _bg_x, _bg_y, 1.5, 1.5, 0, c_white, 1);

    draw_set_halign(fa_right);  
    draw_set_valign(fa_top);

    draw_set_color(c_black); 
    draw_text(_cycle_x, _cycle_y, _cycle_text);

    // Reset
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

// Pause and fade
draw_set_font(-1); 
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

if (reward_timer > 0)
{
    var _gw = display_get_gui_width();
    var _gh = display_get_gui_height();
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_title); 
    
    var _txt_x = _gw / 2;
    var _txt_y = _gh / 2 - 200;
    var _offset = 4; 

    draw_set_color(c_black);
    draw_text(_txt_x + _offset, _txt_y + _offset, reward_msg);
    
    draw_set_color(c_yellow);
    draw_text(_txt_x, _txt_y, reward_msg);
    
    // Reset
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Transition Overlay
if (transition_alpha > 0)
{
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    draw_set_color(c_black);
    draw_set_alpha(transition_alpha); 
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    
    // Reset alpha
    draw_set_alpha(1.0);
}