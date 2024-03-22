extends AnimatedSprite2D



# Called every frame. 'delta' is the elapsed time since the previous frame.

func setAnimation(action, direction):
	self.play(action + direction)
