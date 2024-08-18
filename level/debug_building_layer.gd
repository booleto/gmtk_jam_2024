extends TileMapLayer

var tilemap_size := Vector2i(32, 32)
var tilemap_bound := Vector2i(10, 10)

func _ready():
	set_process(true)
	
func _draw():
	var color = Color(255.0, 0.0, 0.0)
	var bound = tilemap_size * tilemap_bound
	
	var points: PackedVector2Array = []
	points.resize(tilemap_bound.x * tilemap_bound.y * 2)
	
	var i := 0
	for x in range(0, tilemap_bound.x + 1):
		points[i] = Vector2(x * tilemap_size.x, 0)
		i += 1
		points[i] = Vector2(x * tilemap_size.x, bound.y)
		i += 1
	for y in range(0, tilemap_bound.y + 1):
		points[i] = Vector2(0, y * tilemap_size.y)
		i += 1
		points[i] = Vector2(bound.x, y * tilemap_size.y)
		i += 1
	
	draw_multiline(points, color)
func _process(delta):
	queue_redraw()
