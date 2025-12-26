var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (sprite_exists(pause_sprite))
{
    gpu_set_blendenable(false);
    
    draw_sprite_stretched(pause_sprite, 0, 0, 0, _gui_w, _gui_h);
    
    gpu_set_blendenable(true);
}

draw_set_color(c_black);

draw_set_alpha(0.8 * menu_alpha); 

draw_rectangle(0, 0, _gui_w, _gui_h, false);

draw_set_alpha(menu_alpha);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_title); 
draw_set_color(c_yellow);
draw_text(_gui_w / 2, _gui_h * 0.15, "LEVEL UP!"); 

var _card_y = _gui_h * 0.55; 
var _card_w = 240; 
var _card_h = 320;  
var _spacing = 280; 
var _center_x = _gui_w / 2;

for (var i = 0; i < 3; i++)
{
    var _card_x = _center_x + ((i - 1) * _spacing);
    
    var _col = c_gray;
    var _outline_col = c_white;
    var _title = "";
    var _desc = "";
    var _icon_sprite = -1; 
    
    if (i == 0) { 
        _col = c_maroon; 
        _title = "STRENGTH"; 
        _desc = "DMG Increase"; 
        _icon_sprite = AttackBuff; 
    }
    else if (i == 1) { 
        _col = c_green; 
        _title = "VITALITY"; 
        _desc = "Max HP Increase"; 
        _icon_sprite = HPBuff; 
    }
    else if (i == 2) { 
        _col = c_navy; 
        _title = "SHIELD"; 
        _desc = "Gain Shield"; 
        _icon_sprite = ShieldBuff; 
    }
    
    if (selected_option == i)
    {
        _outline_col = c_yellow; 
        draw_set_color(_outline_col);
        draw_rectangle(_card_x - (_card_w/2) - 6, _card_y - (_card_h/2) - 6, 
                       _card_x + (_card_w/2) + 6, _card_y + (_card_h/2) + 6, false);
    }
    
    draw_set_color(_col);
    draw_rectangle(_card_x - _card_w/2, _card_y - _card_h/2, _card_x + _card_w/2, _card_y + _card_h/2, false);
    
    if (sprite_exists(_icon_sprite))
    {
        var _icon_scale = 5; 
        
        draw_sprite_ext(_icon_sprite, 0, _card_x, _card_y - 20, _icon_scale, _icon_scale, 0, c_white, menu_alpha);
    }
    
    draw_set_color(c_white);
    draw_set_font(fnt_control); 
    
    draw_text(_card_x, _card_y - 120, _title);
    
    draw_text(_card_x, _card_y + 110, _desc);
}

draw_set_alpha(1.0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);