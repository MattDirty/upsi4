extends Node2D

@export var max_size := 1.0
@export var step_size := 0.1
@export var initial_size := 0.5
@onready var current_size := initial_size
@onready var safeArea = $SafeArea

# Called when the node enters the scene tree for the first time.
func _ready():
	setScaleFromCurrentSize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func setScaleFromCurrentSize():
	safeArea.scale = Vector2(current_size, current_size)


func _on_interact_body_entered(body):
	body.toggleInteract(self)


func _on_interact_body_exited(body):
	body.toggleInteract(null)


func playerInteract():
	current_size += step_size
	if current_size >= max_size:
		current_size = max_size
	setScaleFromCurrentSize()
