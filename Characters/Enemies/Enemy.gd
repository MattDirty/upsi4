class_name Enemy extends CharacterBody2D

var health: int = 10
var max_health: int = 10
var speed: int = 1
var directions = ["South", "SouthEast", "East", "NorthEast", "North", "NorthWest", "West", "SouthWest"]
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
	var direction = directions[rad_to_deg(velocity.angle_to(Vector2.DOWN)) / 45]
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
