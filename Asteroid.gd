extends Area2D

onready var viewport_size = get_viewport_rect().size

var velocity = Vector2.ZERO

const MIN_SPEED = 50
const MAX_SPEED = 100

func _ready():
	position = Vector2(rand_range(0, viewport_size.x), rand_range(0, viewport_size.y))
	var dir = rand_range(0, 2*PI)
	velocity = Vector2.UP.rotated(dir) * rand_range(MIN_SPEED, MAX_SPEED)

func _draw():
	draw_circle(Vector2.ZERO, 20, Color.white)
	
func _process(delta):
	position += velocity * delta
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)


func _on_Asteroid_area_entered(area):
	if area.is_in_group("Bullets"):
		queue_free()
		area.queue_free()
