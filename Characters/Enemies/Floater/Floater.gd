extends Enemy

var delta_since_last_move: float = 0
@onready var cooldown := Timer.new()
var idle := false
@onready var player = get_tree().root.get_node("Playground/Player")
var target: Player


func _ready():
	super._ready()
	cooldown.wait_time = 0.8
	cooldown.timeout.connect(endCooldown)
	add_child(cooldown)

func idle_roam():
	var random_rotation = randf() * 2.0 * PI
	var direction = Vector2(randf_range(15, 45), 0).rotated(random_rotation)
	velocity = direction * speed


func follow_player():
	
	if (player):
		var direction = (player.position - self.position).normalized()
		
		if (direction.x > 0):
			get_node("CharacterAnimator").scale.x = 1
		else:
			get_node("CharacterAnimator").scale.x = -1
			
		velocity = direction * speed	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
	follow_player()
	move_and_slide()


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
		set_collision_mask_value(2, false)
		set_collision_layer_value(2, false)
		$Hitbox.set_collision_mask_value(2, false)
		$Hitbox.set_collision_layer_value(2, false)
		$Hurtbox.set_collision_mask_value(2, false)
		$Hurtbox.set_collision_layer_value(2, false)
	
