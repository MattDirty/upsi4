extends Node2D

@export var max_size := 1.0
@export var step_size := 0.1
@export var initial_size := 0.5
@export var lost_size := 0.3
@onready var current_size := initial_size
@onready var safeArea = $SafeArea


# Called when the node enters the scene tree for the first time.
func _ready():
	safeArea.scale = Vector2(current_size, current_size)


func setScaleFromCurrentSize():
	var tween = get_tree().create_tween()
	tween.tween_property(
		safeArea,
		"scale",
		Vector2(current_size, current_size),
		1.0
	)

func _on_interact_body_entered(body):
	body.toggleInteract(self)


func _on_interact_body_exited(body):
	body.toggleInteract(null)


func playerInteract():
	current_size += step_size
	if current_size >= max_size - lost_size:
		current_size = max_size - lost_size
	setScaleFromCurrentSize()


func _on_safe_area_body_entered(body):
	body.addSafeArea(self)


func _on_safe_area_body_exited(body):
	body.removeSafeArea(self)
