var _msg = event_data[? "message"];

if (_msg == "intro_selesai")
{
	global.intro_has_played = true;
    transition_go_to_room(Forest);
}