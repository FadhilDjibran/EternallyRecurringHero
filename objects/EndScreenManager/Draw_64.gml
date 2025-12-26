var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.5); 
draw_rectangle(0, 0, _gui_w, _gui_h, false);
draw_set_alpha(1.0); 


draw_sprite_ext(GameLogo, 0, _gui_w / 2, _gui_h * 0.35, 0.25, 0.25, 0, c_white, 1); 

draw_set_font(fnt_title); 
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _text_x = _gui_w / 2;
var _text_y = _gui_h * 0.7;
var _shadow = 2; 

draw_set_color(c_black);
draw_text(_text_x + _shadow, _text_y + _shadow, "Terimakasih Sudah Bermain!");

draw_set_color(c_white); 
draw_text(_text_x, _text_y, "Terimakasih Sudah Bermain!");

_text_y = _gui_h * 0.8;
var _final_time = FormatTime(global.run_time);

draw_set_color(c_black);
draw_text(_text_x + _shadow, _text_y + _shadow, "FINAL RUN TIME: " + _final_time);

draw_set_color(c_white); 
draw_text(_text_x, _text_y, "FINAL RUN TIME: " + _final_time);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1); 
draw_set_color(c_white); 