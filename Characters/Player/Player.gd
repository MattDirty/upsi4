extends CharacterBody2D

@onready var Animator = $CharacterAnimator
@onready var viewport_size = get_viewport().get_visible_rect().size
@onready var Attack = $Attack
@export var speed = 400
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


func viewport_resize():
	viewport_size = get_viewport().get_visible_rect().size


func _ready():
	Animator.changeAnimation(action, direction)
	get_tree().get_root().size_changed.connect(viewport_resize)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	setDirectionInRelationToMouse()
	get_input()
	Animator.changeAnimation(action, direction)
	move_and_slide()


func setDirectionInRelationToMouse():
	direction = Orientation.get_direction_from_angle(get_local_mouse_position().angle())
