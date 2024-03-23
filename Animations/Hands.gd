extends Node2D

@export var distance: float = 4.0

func _physics_process(_delta_time):
	position = get_target_normalized() * distance
	look_at(get_parent().global_position)
	rotate(PI / 2)

func get_target_normalized() -> Vector2:
	return get_parent().global_position.direction_to(get_global_mouse_position()).normalized()

