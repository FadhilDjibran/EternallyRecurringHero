if (room != IntroScreen && room != EndScreen) 
{
    if (audio_is_playing(current_music))
    {
        audio_stop_sound(current_music);
    }
}

global.level_min_x = 0;
global.level_min_y = 0;
global.level_max_x = 1200; 
global.level_max_y = room_height;
margin_left   = 120;
margin_right  = 200; 
margin_top    = 100;
margin_bottom = 50;

switch (room)
{
	case TitleScreen:
       current_music = audio_play_sound(TitleScreenBGM, 10, true, 0.2);
    break;
	
    case Forest:
       current_music = audio_play_sound(ForestBGM, 10, true, 0.2);
	   if (global.bow_unlocked == true)
	    {
	        if (instance_exists(ObjectPlayer))
	        {
	            var _px = ObjectPlayer.x;
	            var _py = ObjectPlayer.y;

	            var _trigger = instance_create_layer(_px, _py, "Instances", TextTrigger);

	            with (_trigger)
	            {
					image_xscale = 2;
					image_yscale = 2;
	                my_text = "Ingat, anda sudah unlock bow! Ganti senjata dengan tombol L.";
	            }
	        }
	    }
	    break;
	
	case Cave:
       current_music = audio_play_sound(CaveBGM, 10, true, 0.2);
		global.level_min_x = 0;
		global.level_min_y = 0;
		global.level_max_x = room_width; 
		global.level_max_y = room_height;
    break;
	
	case Cliff:
       current_music = audio_play_sound(CliffBGM, 10, true, 0.3);
	   global.level_min_x = 0;
	   global.level_min_y = 0;
	   global.level_max_x = room_width - 10;
	   global.level_max_y = 680;
	   global.bow_unlocked = true;
    break;
	
	case Temple:
       current_music = audio_play_sound(TempleBGM, 10, true, 0.3);
	   margin_bottom = 85;
	   global.level_min_x = 0;
		global.level_min_y = 0;
		global.level_max_x = room_width; 
		global.level_max_y = room_height;
		global.bow_unlocked = true;
    break;
	
	case FinalBoss:
       current_music = audio_play_sound(FinalBossBGM, 10, true, 0.3);
	   global.level_min_x = 0;
		global.level_min_y = 0;
		global.level_max_x = 650; 
		global.level_max_y = room_height;
		global.bow_unlocked = true;
    break;
    
    default:
        current_music = noone;
    break;
}


