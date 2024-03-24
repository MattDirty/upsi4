extends CharacterBody2D
class_name Player

var Bullet = load("res://Entities/Bullet.tscn")

@export var speed = 400
@export var max_health := 20
@onready var health := max_health
@export var interact_interval := 0.5
@export var outside_damage_interval := 0.5
var time_since_outside_damage := 0.0
var direction = "South"
var action = "Idle"
var can_interact := false
var is_interacting := false
var interact_target: Node2D
var time_since_interact := 0.0
var safe_areas := []
var is_dead := false

func _input(event):
	if event.is_action_pressed("take_damage"): #debug code?
		takeDamage(1)

func get_input():
	if Input.is_action_pressed("interact") and can_interact:
		action = "Interact"
		return
	
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	if input_direction:
		direction = Orientation.get_direction_from_angle(input_direction.angle())
	if Input.is_action_pressed("main_attack"): # and Attack.status != "Cooldown":
		action = "Attack"
		#Attack.attack()
	elif velocity == Vector2.ZERO and action != "Interact":
		action = "Idle"
	else:
		action = "Move"

func _ready():
	%Body.startInteract.connect(func(): self.is_interacting = true)
	%Body.stopInteract.connect(func(): self.is_interacting = false)
	%Body.fire.connect(attack)
	setBeatRate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead:
		return
	if is_interacting:
		if time_since_interact >= interact_interval:
			interact_target.playerInteract()
			time_since_interact = 0
	else:
		time_since_interact = 0

	get_input()
	%Body.setAnimation(action, direction)
	move_and_slide()

	if time_since_outside_damage >= outside_damage_interval and safe_areas.size() <= 0:
		takeDamage(1)
		time_since_outside_damage = 0

	time_since_interact += delta
	time_since_outside_damage += delta

func takeDamage(value: int):
	health -= value
	setBeatRate()
	%Body.setLife(health, max_health)
	%Body.setAnimation("Damage", direction)
	if health <= 0:
		death()

func death():
	is_dead = true
	%Body.setAnimation("Death", direction)
	(%Heart as AudioStreamPlayer).stop()


func setDirectionInRelationToMouse():
	direction = Orientation.get_direction_from_angle(get_local_mouse_position().angle())


func toggleInteract(target):
	can_interact = !can_interact
	if can_interact:
		interact_target = target
	else:
		interact_target = null
		
		
func addSafeArea(safe_area):
	safe_areas.append(safe_area)


func removeSafeArea(safe_area):
	safe_areas.remove_at(safe_areas.find(safe_area))


func attack(position: Vector2):
	var target = get_global_mouse_position()
	var bullet = Bullet.instantiate()
	bullet.position = position
	bullet.layer = 2
	bullet.direction = position.direction_to(target)
	get_node("/root").add_child(bullet)
	#for area in safe_areas:
		#area.lose.emit()

func setBeatRate():
	var heart = %Heart as AudioStreamPlayer
	heart.volume_db = 6 - (health)
	heart.set_pitch_scale(3 - (float(health) / float(max_health)) * 2)
