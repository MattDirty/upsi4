extends Node2D


var paused = false


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pauseMenu()


func _on_continue_btn_pressed():
	pauseMenu()


func pauseMenu():
	if paused:
		$Player/PauseMenu.hide()
		Engine.time_scale = 1
	else:
		$Player/PauseMenu.show()
		Engine.time_scale = 0
		
	paused = !paused
	

func restartLevel():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Playground.tscn")
	

func backToMainMenu():
	get_tree().change_scene_to_file("res://Menu/StartMenu.tscn")
