extends AnimatedSprite2D

var action = "IdleSouth"

signal startInteract
signal stopInteract
signal fire

func setAnimation(action, direction):
	if action == "Interact":
		direction = ""
	elif self.action == "Interact":
		%AnimationPlayerLabel.stop()
		stopInteract.emit()

	if action + direction == self.action:
		return

	if %AnimationPlayer.has_animation(action):
		%AnimationPlayer.play(action)
	if %Hands/Hand1.sprite_frames.has_animation(action):
		%Hands/Hand1.play(action)
		%Hands/Hand2.play(action)
	if self.sprite_frames.has_animation(action + direction):
		self.play(action + direction)
	%Hands.setAnimation(action)
	self.action = action + direction

func endInteractTransition():
	%AnimationPlayerLabel.play("Sleep")
	startInteract.emit()

func fireAnimation():
	%Mouth.rotation = randf_range(-PI / 3, PI / 3)
	%AnimationPlayerLabel.play("Attack")
	fire.emit()
