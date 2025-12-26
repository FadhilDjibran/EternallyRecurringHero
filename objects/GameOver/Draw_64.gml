// GameOver overlay
draw_set_color(c_black); 
draw_set_alpha(0.6);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1); 

draw_set_font(fnt_control); 
draw_set_color(c_red); 

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_text(_gui_w / 2, _gui_h / 2, "YOU DIED");

draw_set_font(fnt_control); 
draw_set_color(c_white);
draw_text(_gui_w / 2, (_gui_h / 2) + 40, "Press R to Initiate Recurrence");

// Reset Draw Settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(-1);