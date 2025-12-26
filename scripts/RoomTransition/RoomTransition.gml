function transition_go_to_room(target_room)
{
    if (!instance_exists(GameManager))
    {
        room_goto(target_room);
        exit;
    }

    if (GameManager.transition_state != TRANS_STATE.IDLE)
    {
        exit; 
    }

    GameManager.transition_state = TRANS_STATE.FADE_OUT;
    GameManager.transition_target_room = target_room;
}

function transition_teleport(target_x, target_y)
{
    if (instance_exists(GameManager))
    {
        if (GameManager.transition_state != TRANS_STATE.IDLE) exit;
        
        GameManager.transition_state = TRANS_STATE.FADE_OUT;
        
        GameManager.transition_target_x = target_x;
        GameManager.transition_target_y = target_y;
        
        GameManager.is_teleporting = true;
    }
}