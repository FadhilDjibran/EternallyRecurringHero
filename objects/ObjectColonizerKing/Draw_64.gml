if (image_alpha > 0)
{
    var _gui_w = display_get_gui_width(); 
    var _bar_w = 400;                     
    var _bar_h = 25;                      
    
    var _bar_x = (_gui_w / 2) - (_bar_w / 2);
    
    var _bar_y = 50; 

    var _hp_percent = hp / hp_max;
    _hp_percent = clamp(_hp_percent, 0, 1); 
    var _hp_w = _bar_w * _hp_percent;

    draw_set_color(c_dkgray);
    draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);
    
    if (_hp_percent < 0.3 && (current_time % 200 < 100)) draw_set_color(c_maroon);
    else draw_set_color(c_red);
    
    draw_rectangle(_bar_x, _bar_y, _bar_x + _hp_w, _bar_y + _bar_h, false);

    draw_set_color(c_black); 
    draw_rectangle(_bar_x - 2, _bar_y - 2, _bar_x + _bar_w + 2, _bar_y + _bar_h + 2, true);
    draw_set_color(c_white); 
    draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);
    draw_set_font(fnt_control);
    
    draw_set_halign(fa_center); 
    draw_set_valign(fa_bottom); 
    draw_set_color(c_white);
    
    draw_text(_bar_x + (_bar_w / 2), _bar_y - 5, "INVADER KING");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}