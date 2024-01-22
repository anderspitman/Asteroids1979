extends Area2D

const Asteroid := preload("res://Asteroid.tscn")
const Bullet = preload("res://Bullet.tscn")

const MAX_SPEED = 400
const ACCELERATION = 8
const DECELERATION = ACCELERATION / 2

var ship_points = PoolVector2Array()
var angular_speed = PI

var velocity = Vector2.ZERO
var thruster_on = false

var rng = RandomNumberGenerator.new()

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
	#draw_line(Vector2.ZERO, velocity.rotated(-rotation), Color.green, 4)

	
func _physics_process(delta):
	pass
	
func _process(delta):
	#print("Ship.direction", Vector2.UP.rotated(rotation))

	update()
	
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2.UP.rotated(rotation) * ACCELERATION
	else:
		var decel_vec = velocity.normalized() * -1
		velocity += decel_vec * DECELERATION
		
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
		
	rotation += angular_speed * direction * delta	
	position += velocity * delta
	
	wrap_viewport()
	
	if Input.is_action_just_pressed("ui_select"):
		var bullet = Bullet.instance()
		bullet.position = position + Vector2.UP.rotated(rotation) * 10
		#bullet.velocity = Vector2.UP.rotated(rotation)
		bullet.velocity = velocity + Vector2.UP.rotated(rotation) * 400
		main.add_child(bullet)
		
	if Input.is_action_just_pressed("shift"):
		position.x = rng.randf_range(0, viewport_size.x)
		position.y = rng.randf_range(0, viewport_size.y)
		velocity = Vector2.ZERO
	
func wrap_viewport():
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)

func _on_Ship_area_entered(area):	
	if area.is_in_group("Asteroids"):
		position.x = viewport_size.x / 2
		position.y = viewport_size.y / 2
		velocity = Vector2.ZERO
