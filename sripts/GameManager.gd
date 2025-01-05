extends Node

var gravity: float = 1000.0

func set_gravity(value: float) -> void:
	gravity = value

func get_gravity() -> float:
	return gravity