if (distance_to_object(ObjectPlayer) < 5)
{
    if (keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face4)) 
	{
		if (target_room = noone)
        {
			if (xcoor != -1 && ycoor != -1){
				transition_teleport(xcoor, ycoor);}
		}
		else
		{
			transition_go_to_room(target_room);
		}
	}
}