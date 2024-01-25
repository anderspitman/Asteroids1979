extends Node

const Asteroid := preload("res://Asteroid.tscn")

onready var viewport_size = get_viewport().size

onready var viewport = $"/root/Main/ViewportContainer/Viewport"

func _on_Asteroid_spawn_timeout():
	var pos = Vector2(rand_range(0, viewport_size.x), rand_range(0, viewport_size.y))
	create_asteroid(pos, "large")

func _on_Asteroid_destroyed(pos, size):
	if size == "large":
		for i in 2:
			create_asteroid(pos, "medium")
	elif size == "medium":
		for i in 2:
			create_asteroid(pos, "small")
			
func create_asteroid(position, size):
	var asteroid = Asteroid.instance()
	asteroid.position = position
	asteroid.size = size
	asteroid.connect("destroyed", self, "_on_Asteroid_destroyed")
	viewport.add_child(asteroid)
