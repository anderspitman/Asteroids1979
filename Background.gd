extends Node2D

onready var viewport_size = get_viewport_rect().size

func _draw():
	draw_rect(Rect2(0, 0, viewport_size.x, viewport_size.y), Color.black)
