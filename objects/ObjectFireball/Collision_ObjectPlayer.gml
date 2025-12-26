if (has_hit == false)
{
    other.take_damage(damage);
    has_hit = true;
    speed = 0; 
    sprite_index = FireballHit; 
    image_index = 0; 
    image_xscale = 0.045;
	image_yscale = 0.045;
}