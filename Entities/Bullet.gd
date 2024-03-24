extends AnimatedSprite2D

@export var speed := 120.0
var velocity: Vector2
var direction: Vector2
var layer: int
var dead = false
var inert := false

var already_spawn := false

@export var bulletDuration := 35.0

@onready var lifeTimer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = direction.normalized() * speed
	lifeTimer.wait_time = bulletDuration
	lifeTimer.autostart = true
	lifeTimer.one_shot = true
	lifeTimer.timeout.connect(queue_free)
	add_child(lifeTimer)
	%Area2D.set_collision_mask_value(layer, true)


func _physics_process(delta_time):
	position += velocity * delta_time


func _on_area_2d_body_entered(body):
	dead = true
	body.take_damages(10)
	queue_free()


func _on_area_2d_area_exited(area):
	if area.name != "SafeArea" or %Area2D.has_overlapping_areas() or dead or inert:
		return
	inert = true
	velocity = velocity / 5
	area.get_parent().bulletExits()
	
	
