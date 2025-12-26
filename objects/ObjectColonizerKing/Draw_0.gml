if (alarm[2] > 0)
{
    var _fcol = c_ltgray;
    
    gpu_set_fog(true, _fcol, 0, 0);
    
    draw_self();
    
    gpu_set_fog(false, c_white, 0, 0);
}
else
{
    draw_self();
}