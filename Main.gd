extends Node

const Asteroid := preload("res://Asteroid.tscn")


func _init():
	print("Hi there")


func _on_Asteroid_spawn_timeout():
	var asteroid = Asteroid.instance()
	add_child(asteroid)
