extends CanvasLayer


func _ready():
	$AnimatedSprite2D.set_frame(0)


func changeHour(time):
	$AnimatedSprite2D.set_frame(time)
