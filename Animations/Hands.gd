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
	%Hand1.look_at(get_global_mouse_position())
	%Hand2.look_at(get_global_mouse_position())

func get_target_normalized() -> Vector2:
	return get_parent().global_position.direction_to(get_global_mouse_position()).normalized()

func setAnimation(action):
	if action == self.action:
		return
	self.action = action
	if action == "Attack":
		%Hand2.frame = 1
