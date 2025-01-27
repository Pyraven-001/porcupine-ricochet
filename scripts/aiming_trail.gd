extends Node2D

@export var ray_length: float = 1000.0

var player_active = false

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	if player_active:
		var start_pos = global_position
		
		var mouse_pos = get_global_mouse_position()
		var direction = (mouse_pos - start_pos).normalized()
		var end_pos = start_pos + direction * ray_length

		draw_line(start_pos - global_position + Vector2(7,-3), end_pos - global_position, Color(1, 0, 0), 1)
