extends Area2D

export var size = "large"
signal destroyed(position, size)

onready var viewport_size = get_viewport_rect().size

var velocity = Vector2.ZERO
var radius = 0

func _ready():
	var dir = rand_range(0, 2*PI)
	
	var min_speed = 50
	var max_speed = 100
	radius = 20
	if size == "medium":
		min_speed = 75
		max_speed = 150
		radius = 15
	elif size == "small":
		min_speed = 100
		max_speed = 175
		radius = 8
		
	velocity = Vector2.UP.rotated(dir) * rand_range(min_speed, max_speed)
	
	var circle = CircleShape2D.new()
	circle.radius = radius
	$CollisionShape2D.shape = circle

func _draw():
	#draw_circle(Vector2.ZERO, 20, Color.white)
		
	draw_arc(Vector2.ZERO, radius, 0, 2*PI, 10, Color.white, 1)
	
func _process(delta):
	position += velocity * delta
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)


func _on_Asteroid_area_entered(area):
	if area.is_in_group("Bullets"):
		emit_signal("destroyed", position, size)
		
		queue_free()
		area.queue_free()
