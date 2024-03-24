extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func bulletExits():
	return


func _on_safe_area_body_entered(body):
	if body is Player:
		body.addSafeArea(self)


func _on_safe_area_body_exited(body):
	if body is Player:
		body.removeSafeArea(self)


func _on_interact_body_entered(body):
	body.toggleInteractUnicorn(self)


func _on_interact_body_exited(body):
	body.toggleInteractUnicorn(null)

