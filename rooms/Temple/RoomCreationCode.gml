// Temukan layer collision dan simpan tilemap-nya
var layer_id = layer_get_id("Collision");
global.tm_collision = layer_tilemap_get_id(layer_id);

global.debug = true;
