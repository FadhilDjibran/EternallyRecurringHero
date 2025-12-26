// Player Collision
#macro TILE_EMPTY          0
#macro TILE_SOLID          1
#macro TILE_ONEWAY_LEFT    2
#macro TILE_ONEWAY_MID     3
#macro TILE_ONEWAY_RIGHT   4
#macro TILE_SLOPE_RIGHT    5   
#macro TILE_SLOPE_LEFT     6  
#macro TILE_LEDGE_RIGHT    7   
#macro TILE_LEDGE_LEFT     8   

#macro TILE_W tilemap_get_tile_width(global.tm_collision)
#macro TILE_H tilemap_get_tile_height(global.tm_collision)

enum TileType {
    EMPTY        = 0,
    SOLID        = 1,
    ONEWAY_LEFT  = 2,
    ONEWAY_MID   = 3,
    ONEWAY_RIGHT = 4,
    SLOPE_RIGHT  = 5,
    SLOPE_LEFT   = 6,
    LEDGE_RIGHT  = 7,
    LEDGE_LEFT   = 8
}

function TileTypeFromIndex(idx)
{
    switch (idx)
    {
        case 1: return TileType.SOLID;
        case 2: return TileType.ONEWAY_LEFT;
        case 3: return TileType.ONEWAY_MID;
        case 4: return TileType.ONEWAY_RIGHT;
        case 5: return TileType.SLOPE_RIGHT;
        case 6: return TileType.SLOPE_LEFT;
        case 7: return TileType.LEDGE_RIGHT;
        case 8: return TileType.LEDGE_LEFT;
        default: return TileType.EMPTY;
    }
}

function tile_type_at(px, py)
{
    if (!variable_global_exists("tm_collision"))
        return TileType.EMPTY;

    if (px < global.level_min_x || py < global.level_min_y || 
        px >= global.level_max_x + 30 || py >= global.level_max_y + 100)
    {
        return TileType.SOLID;
    }

    var tm    = global.tm_collision;
    var tdata = tilemap_get_at_pixel(tm, px, py);

    if (tdata == 0) return TileType.EMPTY;

    return TileTypeFromIndex(tile_get_index(tdata));
}

function solid_partial_at(t, lx, ly, tw, th)
{
    var half_w = tw * 0.5;
    var half_h = th * 0.5;

    switch (t)
    {
        // 5 = solid kiri, kosong kanan atas
        case TileType.SLOPE_RIGHT:
            return (lx < half_w) || (ly > half_h);

        // 6 = solid kanan, kosong kiri atas
        case TileType.SLOPE_LEFT:
            return (lx > half_w) || (ly > half_h);

        // 7 = solid kiri, kosong kanan bawah
        case TileType.LEDGE_RIGHT:
            return (lx < half_w) || (ly < half_h);

        // 8 = solid kanan, kosong kiri bawah
        case TileType.LEDGE_LEFT:
            return (lx > half_w) || (ly < half_h);
    }

    return false;
}

function solid_at(px, py)
{
    var t = tile_type_at(px, py);

    if (t == TileType.EMPTY) return false;
    if (t == TileType.SOLID) return true;

    // one-way doesn't block horizontal or ceiling
    if (t == TileType.ONEWAY_LEFT ||
        t == TileType.ONEWAY_MID  ||
        t == TileType.ONEWAY_RIGHT)
        return false;

    // partial block
    if (t >= TileType.SLOPE_RIGHT && t <= TileType.LEDGE_LEFT)
    {
        var tw = TILE_W, th = TILE_H;
        var tx = (px div tw) * tw;
        var ty = (py div th) * th;
        var lx = px - tx;
        var ly = py - ty;

        return solid_partial_at(t, lx, ly, tw, th);
    }

    return false;
}

// Ground check (vertical collision)
function ground_at(px, py, vy)
{
    var t = tile_type_at(px, py);

    if (t != TileType.ONEWAY_LEFT &&
        t != TileType.ONEWAY_MID  &&
        t != TileType.ONEWAY_RIGHT)
    {
        return solid_at(px, py);
    }

    // ignore when going up
    if (vy <= 0) return false;

    var tw = TILE_W, th = TILE_H;
    var tx = (px div tw) * tw;
    var ty = (py div th) * th;

    var lx = px - tx;

    // one-way width trim
    var trim = 8;

    if (t == TileType.ONEWAY_LEFT && lx < trim) return false;
    if (t == TileType.ONEWAY_RIGHT && lx > tw - trim) return false;

    // ground line
    if (bbox_bottom <= ty)
        return true;

    return false;
}
