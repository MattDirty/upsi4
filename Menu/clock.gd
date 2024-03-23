extends CanvasLayer


func _ready():
	$BoxContainer/AnimatedSprite2D.set_frame(0)


func changeHour(time):
	$BoxContainer/AnimatedSprite2D.set_frame(time)
