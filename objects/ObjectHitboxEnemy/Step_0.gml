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
    
    var _dir = -sign(owner.image_xscale);
    x = owner.x + (_offset_x * _dir);
    y = owner.y + _offset_y;
	image_xscale = hitbox_w * _dir; 
    image_yscale = hitbox_h;
}
else
{
    instance_destroy();
    exit;
}


// Collision
var _list_targets = ds_list_create();
var _targets_hit = collision_rectangle_list(
    bbox_left, 
    bbox_top, 
    bbox_right, 
    bbox_bottom, 
    ObjectPlayer, 
    false, 
    true, 
    _list_targets, 
    false
);

if (_targets_hit > 0)
{
    for (var i = 0; i < _targets_hit; i++)
    {
        var _player_id = _list_targets[| i];
        
        var _already_hit = (ds_list_find_index(hit_list, _player_id) != -1);
        
        if (!_already_hit)
        {
            ds_list_add(hit_list, _player_id);
            
            _player_id.take_damage(damage);
        }
    }
}

ds_list_destroy(_list_targets);