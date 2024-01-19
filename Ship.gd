extends Node2D

const Bullet = preload("res://Bullet.tscn")

var ship_points = PoolVector2Array()
var angular_speed = PI
var speed = 500
var acceleration = 2
var deceleration = 1
var velocity = Vector2.ZERO
var thruster_on = false

onready var viewport_size = get_viewport_rect().size
onready var main = $"/root/Main"

func _init():
	print("Ship instanced")

func _ready():
	
	var size = 10
	ship_points.push_back(Vector2(0, -1) * size)
	ship_points.push_back(Vector2(-1, 1) * size)
	ship_points.push_back(Vector2(1, 1) * size)
	ship_points.push_back(Vector2(0, -1) * size)
	
func _draw():
	#draw_circle(position, 10, Color.white)
	draw_polyline(ship_points, Color(1, 1, 1, 1), 1)
	
func _physics_process(delta):
	pass
	
func _process(delta):
	
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2.UP.rotated(rotation) * acceleration
	else:
		var decel_vec = velocity.normalized() * -1
		velocity += decel_vec * deceleration
		
	rotation += angular_speed * direction * delta	
	position += velocity * delta
	
	wrap_viewport()
	
	if Input.is_action_just_pressed("ui_select"):
		var bullet = Bullet.instance()
		bullet.position = position
		bullet.direction = Vector2.UP.rotated(rotation).normalized()
		print("instance Bullet")
		print(position)
		main.add_child(bullet)
	
func wrap_viewport():
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)
