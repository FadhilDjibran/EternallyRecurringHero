if (text_alpha > 0.01)
{

    draw_set_font(fnt_control); 
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom); 
    draw_set_color(c_white);
    draw_set_alpha(text_alpha); 
    
    var _cam_w = display_get_gui_width();
    var _cam_h = display_get_gui_height();
    
    var _x_pos = _cam_w / 2;
    var _y_pos = _cam_h - 50;
    
    draw_text_color(_x_pos + 2, _y_pos + 2, my_text, c_black, c_black, c_black, c_black, text_alpha); // Shadow
    draw_text(_x_pos, _y_pos, my_text); 
    
    draw_set_alpha(1);
    draw_set_color(c_white);
}