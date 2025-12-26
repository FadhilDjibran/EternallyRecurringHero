if (!instance_exists(ObjectPlayer))
{
    exit;
}

var _cam = view_camera[0]; 
var _cam_w = camera_get_view_width(_cam);   // 480
var _cam_h = camera_get_view_height(_cam);  // 270

var _target_x = ObjectPlayer.x;
var _target_y = ObjectPlayer.y;

var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);

var _new_x = _cam_x;
var _new_y = _cam_y;

var _margin_left   = margin_left; 
var _margin_right  = margin_right; 

var _margin_top    = margin_top; 
var _margin_bottom = margin_bottom;  

var _border_left   = _cam_x + _margin_left;
var _border_right  = _cam_x + _cam_w - _margin_right;
var _border_top    = _cam_y + _margin_top;
var _border_bottom = _cam_y + _cam_h - _margin_bottom;

if (_target_x < _border_left)
{
    _new_x = _target_x - _margin_left; 
}
else if (_target_x > _border_right)
{
    _new_x = _target_x - (_cam_w - _margin_right); 
}

if (_target_y < _border_top)
{
    _new_y = _target_y - _margin_top; 
}
else if (_target_y > _border_bottom)
{
    _new_y = _target_y - (_cam_h - _margin_bottom); 
}

var _min_x = global.level_min_x;
var _max_x = global.level_max_x - _cam_w; 
var _min_y = global.level_min_y;
var _max_y = global.level_max_y - _cam_h; 

_new_x = clamp(_new_x, _min_x, _max_x);
_new_y = clamp(_new_y, _min_y, _max_y);

camera_set_view_pos(_cam, _new_x, _new_y);