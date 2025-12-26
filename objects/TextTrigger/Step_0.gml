if (place_meeting(x, y, ObjectPlayer))
{
    text_alpha = lerp(text_alpha, 1, 0.1);
}
else
{
    text_alpha = lerp(text_alpha, 0, 0.1);
}