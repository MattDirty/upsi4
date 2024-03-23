extends Node2D

var status: String = "Ready" # or "Cooldown" or "Attacking"
var damages: int = 5
var cooldown: float = 3
var cooldown_elapsed = 0
var frames: int = 4
var ticks_since_attack: int = 0
var attacked_enemies: Array = []
var deal_with_status = {
	"Ready": deal_with_ready,
	"Cooldown": deal_with_cooldown,
	"Attacking": deal_with_attacking,
}
@onready var hitbox: Area2D = $"Area2D"


func reset_weapon():
	cooldown_elapsed = cooldown
	ticks_since_attack = 0
	attacked_enemies.clear()
	status = "Ready"

func _ready():
	reset_weapon()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(get_global_mouse_position())
	deal_with_status[status].call(delta)


func attack():
	if status == "Cooldown" or status == "Attacking":
		return
	status = "Attacking"
	attacked_enemies.clear()
	ticks_since_attack = 0
	cooldown_elapsed = 0


func deal_with_cooldown(delta):
		cooldown_elapsed += delta
		if cooldown_elapsed >= cooldown:
			status = "Ready"


func deal_with_attacking(_delta):
	ticks_since_attack += 1
	if ticks_since_attack >= frames:
		status = "Cooldown"
	else:
		var hits = hitbox.get_overlapping_areas()
		for hit in hits:
			var enemy = hit.get_parent()
			deal_damages_to_enemy(enemy)


func deal_with_ready(_delta):
	pass


func deal_damages_to_enemy(enemy: Enemy):
	if enemy in attacked_enemies:
		return
	enemy.take_damages(damages)
	attacked_enemies.append(enemy)
