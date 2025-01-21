extends CharacterBody2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


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

func shoot(object: CharacterBody2D, dx: float, dy: float, vel: float) -> void:
	# object.velocity += Vector2(dx, dy) * vel
	object.velocity.x += 100

func handle_input():
	if Input.is_action_just_pressed("Fly"):
		if player_body:
			shooting = true
			shoot(player_body, 1, 1, 5)

func _process(delta: float) -> void:
	gravitize(delta)
	change_marker_position()

func _on_body_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		show_aim_trails = true
		body.in_cannon = true
		body.position = marker_2d_position

		player_body = body
