extends CharacterBody2D
class_name Player

@onready var Animator = $CharacterAnimator
@onready var Attack = $Attack
@export var speed = 400
@export var health := 100
var direction = "South"
var action = "Idle"


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	if Input.is_action_pressed("main_attack") and Attack.status != "Cooldown":
		action = "Attack"
		Attack.attack()
	elif velocity == Vector2.ZERO:
		action = "Idle"
	else:
		action = "Move"


func _ready():
	Animator.changeAnimation(action, direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	setDirectionInRelationToMouse()
	get_input()
	Animator.changeAnimation(action, direction)
	move_and_slide()


func setDirectionInRelationToMouse():
	direction = Orientation.get_direction_from_angle(get_local_mouse_position().angle())
