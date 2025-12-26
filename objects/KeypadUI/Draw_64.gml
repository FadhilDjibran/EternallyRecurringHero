var _cw = display_get_gui_width();
var _ch = display_get_gui_height();

var _scale = 1.3; 

draw_set_color(c_black);
draw_set_alpha(0.9);
draw_rectangle(0, 0, _cw, _ch, false);
draw_set_alpha(1);
draw_set_font(fnt_control);

draw_set_halign(fa_center);
draw_set_valign(fa_middle); 
draw_set_color(c_white);

draw_text_transformed(_cw/2, _ch*0.25, "ENTER PASSCODE", _scale, _scale, 0);

draw_text_transformed(_cw/2, _ch*0.75, "ENTER: Confirm   ESC: Skip", _scale * 0.8, _scale * 0.8, 0);

var _spacing = 60 * _scale; 

var _start_x = (_cw / 2) - ((3 * _spacing) / 2);

var _y = _ch/2;

_scale = 1.5; 

for (var i = 0; i < 4; i++)
{
    var _draw_x = _start_x + (i * _spacing);
    
    if (i == cursor_pos) draw_set_color(c_yellow);
    else                 draw_set_color(c_gray);
    
    draw_text_transformed(_draw_x, _y, string(digits[i]), _scale, _scale, 0);
    
    var _line_w = 15 * _scale; 
    var _line_y = _y + (20 * _scale); 
    var _line_h = 4 * _scale; 
    
    draw_rectangle(
        _draw_x - _line_w, 
        _line_y, 
        _draw_x + _line_w, 
        _line_y + _line_h, 
        false
    );
}

// Reset
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);