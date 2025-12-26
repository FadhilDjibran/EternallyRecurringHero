if (GameManager.transition_state != TRANS_STATE.IDLE)
{
    exit; 
}

if (target_room != noone)
{
    transition_go_to_room(target_room);
}
else
{
    transition_go_to_room(TitleScreen); 
}