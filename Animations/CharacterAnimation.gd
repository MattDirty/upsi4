extends AnimatedSprite2D

var action = "IdleSouth"

signal startInteract
signal stopInteract
signal fire(position: Vector2)

const DAMAGE_TEXT = [
	"Ouch",
	"Aie",
	"Hok",
	"Waaah",
	"Ouin!",
]

func setAnimation(action, direction):
	if action == "Interact":
		direction = ""
	elif self.action == "Interact":
		%AnimationPlayerLabel.stop()
		stopInteract.emit()
	if "Death" in self.action:
		return
	if action + direction == self.action and action != "Damage":
		return

	if "Damage" in self.action and action != "Damage" and action != "Death" and action != "Interact" and self.is_playing():
		return

	if %AnimationPlayer.has_animation(action):
		%AnimationPlayer.play(action)
	else:
		%AnimationPlayer.play("Idle")
	if %Hands/Hand1.sprite_frames.has_animation(action):
		%Hands/Hand1.play(action)
		%Hands/Hand2.play(action)
	else:
		%Hands/Hand1.play("Idle")
		%Hands/Hand2.play("Idle")
	%Hands.setAnimation(action)

	if action == "Damage":
		damageAnimation()
		self.stop()
		self.frame = 0

	if self.sprite_frames.has_animation(action + direction):
		self.play(action + direction)
	self.action = action + direction

func endInteractTransition():
	%Mouth.rotation = 0
	%AnimationPlayerLabel.play("Sleep")
	startInteract.emit()

func damageAnimation():
	%AnimationPlayerLabel.stop()
	%Mouth.rotation = randf_range(-PI / 3, PI / 3)
	%DamageText.text = DAMAGE_TEXT.pick_random()
	%AnimationPlayerLabel.play("Damage")

func fireAnimation():
	%Mouth.rotation = randf_range(-PI / 3, PI / 3)
	%AnimationPlayerLabel.play("Attack")
	fire.emit(%FireEmiter.global_position)

func deathAnimation():
	%Hands.visible = false
	get_tree().change_scene_to_file("res://Menu/GameOverScreen.tscn")
	pass

func setLife(health: float, max_health: float):
	var value: int = (max_health - health) / 4
	%Heart.frame = value
	%Heart/HeartBeatAnim.speed_scale = (3 - (float(health) / float(max_health)) * 2)
