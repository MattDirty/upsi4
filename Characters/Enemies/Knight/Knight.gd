extends Enemy

var delta_since_last_move: float = 0


func idle_roam():
	var random_rotation = randf() * 2.0 * PI
	var direction = Vector2(randf_range(15, 45), 0).rotated(random_rotation)
	velocity = direction * speed


func follow_player():
	var player =  get_tree().root.get_node("Playground/Player")
	
	if (player):
		var direction = (player.position - self.position).normalized()
		
		if (direction.x > 0):
			get_node("CharacterAnimator").scale.x = 1
		else:
			get_node("CharacterAnimator").scale.x = -1
			
		velocity = direction * speed	


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow_player()
	move_and_slide()


func _on_hurtbox_body_entered(body):
	if not body is Player:
		return
	
