extends CharacterBody2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var aiming_trail: Node2D = $AimingTrail
@onready var timer: Timer = $Timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity: float = GameManager.get_gravity()

var player_in_cannon: bool = false
var player_body: Node2D

var marker_2d_position: Vector2

var circle_count: int = 10
var max_distance: float = 400.0

var show_aim_trails = false
var shooting = false

var time_of_flight = 1.0

func _ready() -> void:
	marker_2d_position = marker_2d.global_position

func gravitize(delta: float):
	if !is_on_floor():
		velocity.y += gravity * delta

func change_marker_position() -> void:
	if animated_sprite_2d.flip_h:
		marker_2d_position = -marker_2d.global_position
	else:
		marker_2d_position = marker_2d.global_position

func shoot() -> void:
	# object.velocity += Vector2(dx, dy) * vel
	if shooting:
		player_body.velocity.x += 10

	print("player body: ", player_body)

	timer.start(time_of_flight)

func handle_input():
	if Input.is_action_just_pressed("Fly"):
		if player_body:
			shooting = true

func _process(delta: float) -> void:
	if player_body:
		aiming_trail.player_active = true
	gravitize(delta)
	change_marker_position()
	handle_input()
	shoot()

func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		show_aim_trails = true
		body.in_cannon = true
		body.position = marker_2d_position

		player_body = body

func _on_timer_timeout() -> void:
	if shooting:
		shooting = false


func _on_body_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("exited")
		# if player_body:
		# 	player_body = null
