if (distance_to_object(ObjectPlayer) < 5)
{
    if (!activated && (keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face4))) 
    {
        activated = true;
        image_index = 1; 
        
        instance_create_layer(door_spawn_x, door_spawn_y, "Instances", LevelDoor, {
            xcoor : target_x,        
            ycoor : target_y,        
            target_room : target_room 
        });
		if (destroy_cages == 1)
        {
            with (ObjectCage)
            {
				audio_play_sound(CageOpenSFX, 5, false);
                instance_destroy(); 
            }
        }
		else
		{
			audio_play_sound(KeypadClickSFX, 10, false);
			instance_create_layer(door_spawn_x, door_spawn_y, "Instances", ObjectDoorOpen);
		}
        
    }
}