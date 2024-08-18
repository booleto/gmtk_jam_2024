extends TileMapLayer

@export var tilemap_size := Vector2i(32, 32)
@export var tilemap_bound := Vector2i(10, 10)
var color := Color(255.0, 0.0, 0.0)
var points: PackedVector2Array = []
func _ready():
	var bound = tilemap_size * tilemap_bound
	
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

func _draw():
	draw_multiline(points, color)

func _process(delta):
	queue_redraw()
