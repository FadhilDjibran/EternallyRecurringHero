var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.5); 
draw_rectangle(0, 0, _gui_w, _gui_h, false);
draw_set_alpha(1.0); 

if (!in_controls)
{
    draw_sprite_ext(GameLogo, 0, _gui_w / 2, _gui_h * 0.35, 0.25, 0.25, 0, c_white, 1); 
}

draw_set_font(fnt_title); 
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _start_y = _gui_h * 0.7;
var _spacing = 50;        

if (in_options)
{
    var _opt_y = _start_y + 50; 
    
    draw_set_color(c_white);
    draw_text(_gui_w / 2, _opt_y - 60, "- OPTIONS -");

    for (var i = 0; i < array_length(opt_options); i++)
    {
        var _color = c_white;
        var _text = opt_options[i];
        
        if (i == 0) 
        {
            var _vol = audio_get_master_gain(0);
            if (_vol > 0) _text += "ON"; else _text += "OFF";
        }
 
        if (i == opt_index)
        {
            _color = c_yellow;
            _text = "> " + _text + " <";
        }
        
        draw_set_color(_color);
        draw_text(_gui_w / 2, _opt_y + (i * _spacing), _text);
    }
}
else if (in_controls)
{
    var _top_y      = _gui_h * 0.075; 
    var _left_col   = _gui_w * 0.25; 
    var _right_col  = _gui_w * 0.75; 
    
    var _gap        = 90; 
    var _shadow     = 3;
    
    var _draw_item = function(_xx, _yy, _title, _input, _shd) {
        
        draw_set_color(c_white); 
        draw_set_font(fnt_title); 
        
        draw_text_transformed(_xx, _yy - 25, _title, 0.5, 0.5, 0); 
        
        draw_set_color(c_black);
        draw_text(_xx + _shd, _yy + 10 + _shd, _input); 
        
        draw_set_color(c_yellow);
        draw_text(_xx, _yy + 10, _input); 
    };

    draw_set_color(c_white);
    draw_text(_gui_w / 2, _top_y + 20, "- CONTROLS -");

    var _header_y = _top_y + 60; 
    draw_set_color(c_white);
    draw_text_transformed(_left_col, _header_y, "KEYBOARD", 0.7, 0.7, 0);
    draw_text_transformed(_right_col, _header_y, "CONTROLLER", 0.7, 0.7, 0);
    
    draw_set_color(c_white);
    draw_line_width(_gui_w/2, _header_y + 30, _gui_w/2, _gui_h * 0.78, 2);

    var _list_y = _header_y + 70; 
    
    _draw_item(_left_col, _list_y, "MOVE", "WASD / Arrows", _shadow);
    _draw_item(_right_col, _list_y, "MOVE", "D-Pad / L-Stick", _shadow);
    _list_y += _gap;
    
    _draw_item(_left_col, _list_y, "JUMP", "Space", _shadow);
    _draw_item(_right_col, _list_y, "JUMP", "Face Bottom (A)", _shadow); 
    _list_y += _gap;
    
    _draw_item(_left_col, _list_y, "ATTACK", "J", _shadow);
    _draw_item(_right_col, _list_y, "ATTACK", "Face Left (X)", _shadow); 
    _list_y += _gap;
    
    _draw_item(_left_col, _list_y, "INTERACT", "K", _shadow);
    _draw_item(_right_col, _list_y, "INTERACT", "Face Top (Y)", _shadow);
    _list_y += _gap;

    _draw_item(_left_col, _list_y, "SWAP WEAPON", "L", _shadow);
    _draw_item(_right_col, _list_y, "SWAP WEAPON", "Face Right (B)", _shadow);
    _list_y += _gap;

    _draw_item(_left_col, _list_y, "PAUSE", "Esc", _shadow);
    _draw_item(_right_col, _list_y, "PAUSE", "Start / Options", _shadow);
    
    
    var _back_y = _gui_h * 0.9; 
    
    for (var i = 0; i < array_length(ctrl_options); i++)
    {
        var _color = c_white;
        var _text = ctrl_options[i];
        
        if (i == ctrl_index)
        {
            _color = c_yellow;
            _text = "> " + _text + " <";
        }
        
        draw_set_color(_color);
        draw_text(_gui_w / 2, _back_y, _text);
    }
}
else 
{
    for (var i = 0; i < array_length(menu_options); i++)
    {
        var _color = c_white;
        var _text = menu_options[i];
        
        if (i == menu_index)
        {
            _color = c_yellow;
            _text = "> " + _text + " <"; 
        }
        
        draw_set_color(_color);
        draw_text(_gui_w / 2, _start_y + (i * _spacing), _text);
    }
}

// Reset Settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);