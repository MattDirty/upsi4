extends Enemy

var Fireball = load("res://Entities/Fireball.tscn")
var delta_since_last_move: float = 0
@onready var cooldown := Timer.new()
@onready var rangeCooldown := Timer.new()
var idle := false
var rangeIdle := false
@onready var player = get_tree().root.get_node("Playground/Player")
var target: Player
var status := "Following"

func _ready():
	super._ready()
	cooldown.wait_time = 0.8
	cooldown.timeout.connect(endCooldown)
	rangeCooldown.wait_time = 4.0
	rangeCooldown.timeout.connect(endRangeCooldown)
	add_child(cooldown)
	add_child(rangeCooldown)
	$EvilLaugh.play(1.1)

func endRangeCooldown():
	rangeIdle = false
	rangeAttack()

func follow_player():
	if (player):
		var direction = (player.position - self.position).normalized()
		
		if (direction.x > 0):
			get_node("CharacterAnimator").scale.x = abs(get_node("CharacterAnimator").scale.x)
		else:
			get_node("CharacterAnimator").scale.x = -abs(get_node("CharacterAnimator").scale.x)
			
		velocity = direction * speed


func rangeAttack():
	if not target or rangeIdle or dead:
		return
	$EvilAttack.play(0.84)
	rangeIdle = true
	rangeCooldown.start()
	var fireball = Fireball.instantiate()
	fireball.position = position
	fireball.layer = 1
	fireball.direction = position.direction_to(target.position)
	get_node("/root").add_child(fireball)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dead:
		return
	if status == "Following":
		follow_player()
		move_and_slide()
	elif status == "RangeAttack":
		rangeAttack()


func _on_attack_range_body_entered(body):
	if not body is Player:
		return
	target = body
	status = "RangeAttack"


func _on_attack_range_body_exited(body):
	if not body is Player:
		return
	target = null
	status = "Following"


func _on_hurtbox_body_entered(body):
	if body is Player:
		target = body
		tryToAttack()

func _on_hurtbox_body_exited(body):
	if body is Player:
		target = null
		

func tryToAttack():
	if not target or idle:
		return
	target.takeDamage(1)
	idle = true
	cooldown.start()

func endCooldown():
	idle = false
	tryToAttack()

func take_damages(value: int):
	super.take_damages(value)
	if dead:
		$CharacterAnimator.scale = Vector2(0.7, 0.7)
		$CharacterAnimator.self_modulate = Color("4b004c")
		$EvilDeath.play(0.86)
		set_collision_mask_value(2, false)
		set_collision_layer_value(2, false)
		$Hitbox.set_collision_mask_value(2, false)
		$Hitbox.set_collision_layer_value(2, false)
		$Hurtbox.set_collision_mask_value(2, false)
		$Hurtbox.set_collision_layer_value(2, false)
