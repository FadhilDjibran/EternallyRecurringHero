lifetime--;
if (lifetime <= 0) instance_destroy();

if (solid_at(x, y)) instance_destroy();

if (hspeed > 0) 
{
	image_angle = -45;
}
else 
{
    image_angle = 45;
}

