extends Enemy

var delta_since_last_move: float = 0

func idle_roam():
	var random_rotation = randf() * 2.0 * PI
	var direction = Vector2(randf_range(15, 45), 0).rotated(random_rotation)
	velocity = direction * speed


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta_since_last_move += delta
	if delta_since_last_move >= 2:
		idle_roam()
		delta_since_last_move = 0
	move_and_slide()
	super(delta)


func _on_hurtbox_body_entered(body):
	if not body is Player:
		return
	
