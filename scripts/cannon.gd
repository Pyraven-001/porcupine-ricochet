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

func _process(delta: float) -> void:
	gravitize(delta)
	change_marker_position()

func _on_body_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		body.in_cannon = true
		body.position = marker_2d_position
