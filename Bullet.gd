extends Node2D

onready var viewport_size = get_viewport_rect().size

export var direction = Vector2.ZERO

var SPEED = 200
	

func _draw():
	
	draw_circle(Vector2.ZERO, 1, Color.white)
	
func _process(delta):
	position += direction * SPEED * delta
	wrap_viewport()
	
func _physics_process(delta):
	pass
	

func wrap_viewport():
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)


func _on_Timer_timeout():
	queue_free()
