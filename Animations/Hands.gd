extends Node2D

@export var distance: float = 4.0

var action = "Idle"

func _physics_process(_delta_time):
	if action == "Interact":
		rotation = 0
		position = Vector2.ZERO
		return
	position = get_target_normalized() * distance
	look_at(get_parent().global_position)
	rotate(PI / 2)

func get_target_normalized() -> Vector2:
	return get_parent().global_position.direction_to(get_global_mouse_position()).normalized()

func setAnimation(action):
	print(action)
	self.action = action
