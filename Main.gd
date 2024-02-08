extends Node

signal score_updated(score)

const Asteroid := preload("res://Asteroid.tscn")

onready var viewport_size = get_viewport().size

onready var viewport = $"/root/Main/ViewportContainer/Viewport"

var score = 0
var ship_count = 4

func _on_Asteroid_spawn_timeout():
	var pos = Vector2(rand_range(0, viewport_size.x), rand_range(0, viewport_size.y))
	create_asteroid(pos, "large")

func _on_Asteroid_destroyed(pos, size):
	if size == "large":
		for i in 2:
			create_asteroid(pos, "medium")
		score += 20
	elif size == "medium":
		for i in 2:
			create_asteroid(pos, "small")
		score += 50
	else:
		score += 100
			
	emit_signal("score_updated", score)
			
func create_asteroid(position, size):
	var asteroid = Asteroid.instance()
	asteroid.position = position
	asteroid.size = size
	asteroid.connect("destroyed", self, "_on_Asteroid_destroyed")
	viewport.add_child(asteroid)


func _on_Ship_destroyed(ship):
	ship_count -= 1
	if ship_count == 0:
		ship.queue_free()
