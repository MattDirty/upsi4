class_name Enemy extends CharacterBody2D

var health: int = 10
var max_health: int = 10
var speed: int = 50
var damages: int = 1
var dead := false
@onready var Animator = $"CharacterAnimator"

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	Animator.play("Idle")


func take_damages(damagesTaken: int):
	health -= damagesTaken

	if health <= 0:
		dead = true
		Animator.play("Death")
		await Animator.animation_finished
		queue_free()
