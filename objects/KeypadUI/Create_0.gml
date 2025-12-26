// Setup Input
digits = [0, 0, 0, 0];
cursor_pos = 0;       
door_ref = noone;  
stick_prev_h = 0;
stick_prev_v = 0;

if (instance_exists(ObjectPlayer)) ObjectPlayer.can_attack = false; 
depth= -9999;