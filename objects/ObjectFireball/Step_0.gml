if (has_hit == false)
{
    lifetime--;

    if (lifetime <= 0 || solid_at(x, y))
    {
        has_hit = true; 
        
        speed = 0; 
        sprite_index = FireballHit; 
        image_index = 0; 
        image_xscale = 0.045;
        image_yscale = 0.045;
     
    }
    else
    {
        image_angle = direction;
    }
}