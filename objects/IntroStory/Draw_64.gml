var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
draw_set_color(c_black);
draw_set_alpha(0.8); 
draw_rectangle(0, 0, _gw, _gh, false);
draw_set_alpha(1.0); 

var _page_data = story_data[current_page];
var _layers = _page_data.layers; 

// Loop layer
for (var i = 0; i < array_length(_layers); i++)
{
    var _element = _layers[i];
    
    if (sprite_exists(_element.sprite))
    {
		var _alpha = 1;            
        var _anim_y_offset = 0;
        var _sub_img = image_index; 

        if (_element.sprite == HeroDead)
        {
            var _total_frames = sprite_get_number(_element.sprite);
            
            _sub_img = min(image_index, _total_frames - 1);

            var _delay_frames = 10; 
            var _fade_speed = 0.5; 
			
            if (image_index > (_total_frames + _delay_frames))
            {
                var _time_passed = image_index - (_total_frames + _delay_frames);
                
                _alpha = 1 - (_time_passed * _fade_speed);
                
                if (_alpha < 0) _alpha = 0;
            }
        }

        if (_element.sprite == ColonizerKING) 
        {
            _anim_y_offset = sin(hover_timer) * hover_range;
        }

        draw_sprite_ext(
            _element.sprite, 
            _sub_img,        
            _element.x, 
            _element.y + _anim_y_offset, 
            _element.scale, 
            abs(_element.scale), 
            0, 
            c_white, 
            _alpha
        );
    }
}

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(fnt_title); 

var _text_y = _gh * 0.65; 
var _margin = 100;

var _line_spacing = 50; 

draw_text_ext(_gw/2, _text_y, _page_data.text, _line_spacing, _gw - (_margin * 2));

var _blink = (current_time / 500) % 2; 

if (_blink > 1 && fade_state == 0)
{
    var _arrow_scale = 2.5; 

    draw_sprite_ext(
        ArrowNext,     
        0,              
        _gw - 120,     
        _gh - 80,       
        _arrow_scale,   
        _arrow_scale,  
        0,             
        c_white,       
        1               
    );
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

if (fade_alpha > 0)
{
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1.0);
}