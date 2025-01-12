extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var max_speed: float = 2000.0
@export var jump_force: float = 250.0

var gravity: float = GameManager.get_gravity()
var speed: float = 1000.0

enum State { IDLE, FLY, FLY_NEEDLE, DEAD, IN_CANNON }
var current_state: State = State.IDLE

var is_flying = false
var in_cannon = false
var in_needle_mode = false
var is_dead = false

var direction = Vector2.ZERO

# Function to shoot the porcupine from the cannon
# direction: The direction in which the porcupine is shot
# force: The force with which the porcupine is shot
func shoot_from_cannon(direction: Vector2, force: float) -> void:
	is_flying = true
	velocity = direction.normalized() * force

func idle(delta: float) -> void:
	current_state = State.IDLE

	velocity.x = move_toward(velocity.x, direction.x * max_speed, speed * delta)
	velocity.y = move_toward(velocity.y, direction.y * max_speed, speed * delta)

func handle_keyboard_input(delta: float) -> void:
	pass

func fly(delta: float) -> void:
	current_state = State.FLY

func gravitize(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta

func is_in_cannon(delta: float) -> void:
	velocity.y = 0
	current_state = State.IN_CANNON

func handle_movement(delta: float) -> void:
	if !in_cannon:
		gravitize(delta)
	else:
		is_in_cannon(delta)

func change_animation() -> void:
	if current_state == State.IN_CANNON:
		animated_sprite_2d.play("in-cannon")
	elif current_state == State.FLY_NEEDLE:
		animated_sprite_2d.play("fly_needle")
	elif current_state == State.FLY:
		animated_sprite_2d.play("fly")
	elif current_state == State.DEAD:
		animated_sprite_2d.play("dead")
	else:
		animated_sprite_2d.play("idle")

func _ready():
	current_state = State.IDLE

func _process(delta: float) -> void:
	change_animation()

# Physics process function to handle the porcupine's movement
func _physics_process(delta: float) -> void:
	handle_movement(delta)

	move_and_slide()
