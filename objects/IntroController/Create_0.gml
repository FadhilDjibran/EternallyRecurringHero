if (global.intro_has_played == true)
{
    transition_go_to_room(Forest); 
    instance_destroy(); 
    exit; 
}

cutscene_seq = layer_sequence_create("Instances", room_width/2, room_height/2, FirstCycle);
is_paused = false;
menu_index = 0;
menu_options = ["RESUME", "SKIP CUTSCENE"];
gamepad_index = 0;
stick_held = false;