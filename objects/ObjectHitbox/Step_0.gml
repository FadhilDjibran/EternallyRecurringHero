lifetime--;
if (lifetime <= 0)
{
    instance_destroy();
    exit; 
}

if (instance_exists(owner))
{
    var _offset_x = owner.attack_hitbox_offset_x;
    var _offset_y = owner.attack_hitbox_offset_y;
    
    x = owner.x + (_offset_x * owner.image_xscale);
    y = owner.y + _offset_y;
    
    image_xscale = owner.image_xscale; 
}
else
{
    instance_destroy();
    exit;
}


// Collision
var _list_enemies = ds_list_create();
var _enemies_hit = collision_rectangle_list(
    bbox_left, 
    bbox_top, 
    bbox_right, 
    bbox_bottom, 
    ObjectEnemy, 
    false, 
    true, 
    _list_enemies, 
    false
);

if (_enemies_hit > 0)
{
    for (var i = 0; i < _enemies_hit; i++)
    {
        var _enemy_id = _list_enemies[| i];
        
        var _already_hit = (ds_list_find_index(hit_list, _enemy_id) != -1);
        
        if (!_already_hit)
        {
            ds_list_add(hit_list, _enemy_id);
            
            _enemy_id.take_damage(damage);
        }
    }
}

ds_list_destroy(_list_enemies);