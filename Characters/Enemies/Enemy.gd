class_name Enemy extends CharacterBody2D

var health: int = 10
var max_health: int = 10
var speed: int = 1
@onready var Animator = $"CharacterAnimator"
@onready var HealthBar: ProgressBar = $"HealthBar"

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	HealthBar.max_value = max_health
	HealthBar.value = health
	HealthBar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Orientation.get_direction_from_angle(velocity.angle())
	var action = "Idle"
	if velocity.length() > 0:
		action = "Move"
	Animator.changeAnimation(action, direction)


func take_damages(damages: int):
	health -= damages
	HealthBar.value = health
	HealthBar.visible = true
	if health <= 0:
		queue_free()
