class_name SafeZone extends Node2D

@export var max_size := 1.0
@export var step_size := 0.1
@export var initial_size := 0.5
@export var lost_step := 0.05
@onready var current_size := initial_size
@onready var safeArea = $SafeArea
var lost_size := 0.0

signal lose

# Called when the node enters the scene tree for the first time.
func _ready():
	safeArea.scale = Vector2(current_size, current_size)
	lose.connect(loseSize)


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

func loseSize():
	lost_size += lost_step
	current_size -= lost_step
	if lost_size > max_size:
		lost_size = max_size
	if current_size >= max_size - lost_size:
		current_size = max_size - lost_size
	if current_size <= 0:
		dead()
	setScaleFromCurrentSize()


func bulletExits():
	loseSize()
	var tween = get_tree().create_tween()
	tween.tween_property(
		$SafeArea/PointLight2D,
		"color",
		Color(1,0,0),
		0.2
	)
	tween.tween_property(
		$SafeArea/PointLight2D,
		"color",
		Color(1,1,1),
		0.2
	)


func dead():
	queue_free()

func _on_safe_area_body_entered(body):
	if body is Player:
		body.addSafeArea(self)


func _on_safe_area_body_exited(body):
	if body is Player:
		body.removeSafeArea(self)
