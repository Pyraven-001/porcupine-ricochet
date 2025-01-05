extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var max_speed: float = 3.0
@export var jump_force: float = 250.0

var gravity: float = GameManager.get_gravity()
var speed: float = 100.0

enum State { IDLE, JUMP, WALK }
var state: State = State.IDLE

func idle() -> void:
	pass

func _ready():
	pass

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass