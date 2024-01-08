extends Node2D

var status: String = "Ready" # or "Cooldown" or "Attacking"
var damages: int = 5
var cooldown: float = 3
var cooldown_elapsed = 0
var frames: int = 1
var ticks_since_attack: int = 0
@onready var hitbox: Area2D = $"Area2D"
@onready var CooldownBar: ProgressBar = $"../CooldownBar"


func _ready():
	cooldown_elapsed = cooldown
	CooldownBar.max_value = cooldown
	CooldownBar.value = cooldown_elapsed


func attack():
	if status == "Cooldown":
		return
	status = "Attacking"
	ticks_since_attack = 0
	cooldown_elapsed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if status == "Cooldown":
		cooldown_elapsed += delta
		CooldownBar.max_value = cooldown
		CooldownBar.value = cooldown_elapsed
		if cooldown_elapsed >= cooldown:
			status = "Ready"
	if status == "Attacking":
		ticks_since_attack += 1
		var hits = hitbox.get_overlapping_areas()
		for hit in hits:
			var enemy = hit.get_parent()
			deal_damages_to_enemy(enemy)
		if ticks_since_attack >= frames:
			status = "Cooldown"
	look_at(get_global_mouse_position())



func deal_damages_to_enemy(enemy):
	enemy.take_damages(damages)
