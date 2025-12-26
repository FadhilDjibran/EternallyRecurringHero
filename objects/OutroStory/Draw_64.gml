var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

draw_set_color(c_black);
draw_set_alpha(0.8); 
draw_rectangle(0, 0, _gw, _gh, false);
draw_set_alpha(1); 

if (current_page == 4 && white_fade_alpha > 0)
{
    draw_set_color(c_white);
    draw_set_alpha(white_fade_alpha); 
    draw_rectangle(0, 0, _gw, _gh, false);
}

var _page_data = story_data[current_page];
var _layers = _page_data.layers; 

for (var i = 0; i < array_length(_layers); i++)
{
    var _element = _layers[i];
    
    if (sprite_exists(_element.sprite))
    {
        var _draw_alpha = 1;            
        var _sub_img = image_index; 

        if (current_page == 3 && _element.sprite == HeroIdle)
        {
            _draw_alpha = hero_alpha; 
        }

        draw_sprite_ext(
            _element.sprite, 
            _sub_img,        
            _element.x, 
            _element.y, 
            _element.scale, 
            abs(_element.scale), 
            0, 
            c_white, 
            _draw_alpha
        );
    }
}

if (white_fade_alpha > 0 && current_page != 4)
{
    draw_set_color(c_white);
    draw_set_alpha(white_fade_alpha);
    draw_rectangle(0, 0, _gw, _gh, false);
}

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(fnt_title); 
draw_set_alpha(1); 
var _text_y = _gh * 0.70; 
var _margin = 100;
var _line_spacing = 50; 

draw_set_color(c_black);
draw_text_ext(_gw/2 + 2, _text_y + 2, _page_data.text, _line_spacing, _gw - (_margin * 2)); 
draw_set_color(c_white); 
if (white_fade_alpha > 0.8) draw_set_color(c_black); 

draw_text_ext(_gw/2, _text_y, _page_data.text, _line_spacing, _gw - (_margin * 2));

var _blink = (current_time / 500) % 2; 

if (_blink > 1 && fade_state == 0 && 
   (current_page != 3 || white_fade_alpha >= 1))
{
    var _arrow_scale = 2.5; 
    var _arrow_color = c_white;

    if (white_fade_alpha > 0.8 || current_page == 4) _arrow_color = c_black; 

    draw_sprite_ext(ArrowNext, 0, _gw - 120, _gh - 80, _arrow_scale, _arrow_scale, 0, _arrow_color, 1);
}

if (fade_alpha > 0)
{
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1.0);
}

// Reset settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);