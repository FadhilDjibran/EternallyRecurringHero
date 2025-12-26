if (locked && distance_to_object(ObjectPlayer) < 5)
{
    if (keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face4)) 
  {
        if (!instance_exists(KeypadUI))
        {
            var _ui = instance_create_layer(0, 0, "Instances", KeypadUI);
            _ui.door_ref = id; 
        }
	}	
}