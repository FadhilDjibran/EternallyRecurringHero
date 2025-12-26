function enemy_ground_at(px, py)
{
    if (px < global.level_min_x || py < global.level_min_y || 
        px >= global.level_max_x + 30 || py >= global.level_max_y + 100)
        return true;

    if (!variable_global_exists("tm_collision"))
        return false;

    var tdata = tilemap_get_at_pixel(global.tm_collision, px, py);
    if (tdata == 0) return false;

    var idx = tile_get_index(tdata);
    return (idx != 0);
}

