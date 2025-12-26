damage_bonus = 10;
bow_damage_bonus = 7.5;
hp_bonus = 100;
shield_value = 80;

gamepad_index = 0; 
selected_option = 0;
input_delay = 10; 
depth = -200;
menu_alpha = 0;      
fade_speed = 0.05; 
closing = false;

var _surf_w = surface_get_width(application_surface);
var _surf_h = surface_get_height(application_surface);
pause_sprite = sprite_create_from_surface(application_surface, 0, 0, _surf_w, _surf_h, false, false, 0, 0);

instance_deactivate_all(true); 
instance_activate_object(GameManager);
instance_activate_object(self);
stick_held = false;