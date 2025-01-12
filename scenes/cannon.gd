extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity: float = GameManager.get_gravity()

var player_in_cannon: bool = false
var player_body: Node2D

func gravitize(delta: float):
	if !is_on_floor():
		velocity.y += gravity * delta

func _process(delta: float) -> void:
	gravitize(delta)
	set_player()


func set_player() -> void:
	if player_in_cannon:
		player_body.in_cannon = true
	else:
		if player_body:
			player_body.in_cannon = false


func _on_body_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		player_in_cannon = true
		player_body = body
