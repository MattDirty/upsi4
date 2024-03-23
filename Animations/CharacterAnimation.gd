extends AnimatedSprite2D

var action = "IdleSouth"

signal startInteract
# Called every frame. 'delta' is the elapsed time since the previous frame.

func setAnimation(action, direction):
	if action == "Interact":
		direction = ""
	if action + direction == self.action:
		return

	if %AnimationPlayer.has_animation(action):
		%AnimationPlayer.play(action)
	%AnimationPlayerLabel.stop()
	self.play(action + direction)
	%Hands.setAnimation(action)
	self.action = action + direction

func endInteractTransition():
	%AnimationPlayerLabel.play("Sleep")
	startInteract.emit()
