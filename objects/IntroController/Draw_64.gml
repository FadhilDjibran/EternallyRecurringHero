// Event Draw GUI (obj_IntroController)

if (is_paused)
{
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    // 1. Background Gelap 80%
    draw_set_color(c_black);
    draw_set_alpha(0.8); 
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);

    // 2. Judul PAUSED
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Pastikan font ini ada, atau ganti dengan font default
    draw_set_font(fnt_title); 
    
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _gui_h * 0.2, "- PAUSED -");

    // 3. Setup Menu List
    draw_set_font(fnt_control);
    
    var _start_y = _gui_h * 0.45;
    var _spacing = 40;

    // 4. Loop Gambar Menu
    for (var i = 0; i < array_length(menu_options); i++)
    {
        var _color = c_gray;
        var _text = menu_options[i];
        
        if (i == menu_index) 
        {
            _color = c_yellow;
            _text = "> " + _text + " <";
        }
        
        draw_set_color(_color);
        draw_text(_gui_w / 2, _start_y + (i * _spacing), _text);
    }

    // 5. Reset Settings
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}