extends Node2D

@export var circle_radius = 3.0
@export var circle_gap = 8 # space between circles.
var ray_length = 1000.0 # default ray length.

@onready var raycast = $RayCast2D # raycast node for collision detection.

func _ready():
	process_mode = Node.PROCESS_MODE_INHERIT

func _process(_delta: float) -> void:
	aim_at_mouse()
	update_trail()

func aim_at_mouse():
	# calculate angle to mouse position.
	var global_mouse_pos = get_global_mouse_position()
	rotation = (global_mouse_pos - global_position).angle()

func update_trail():
	# reset raycast and calculate end position.

	raycast.enabled = true
	raycast.target_position = Vector2(ray_length, 0).rotated(rotation)
	raycast.force_update_transform()

	# redraw the trail.
	queue_redraw()

func _draw():
	# draw the trail.
	var trail_position = Vector2.ZERO
	var total_distance = raycast.get_collision_point().distance_to(global_position) if raycast.is_colliding() else ray_length

	while trail_position.length() < total_distance:
		draw_circle(trail_position, circle_radius, Color(1, 1, 1, 0.5)) # semi-transparent white circles.
		trail_position += Vector2(circle_gap, 0).rotated(rotation)

	
