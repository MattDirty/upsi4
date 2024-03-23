extends Node2D


var paused = false
var currentHour = 0


@onready var clock = $Clock


func _ready():
	$HourTimer.start()


func _on_hour_timer_timeout():
	addOneHour()
	$HourTimer.start()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pauseMenu()


func _on_continue_btn_pressed():
	pauseMenu()


func pauseMenu():
	if paused:
		$PauseMenu.hide()
		Engine.time_scale = 1
	else:
		$PauseMenu.show()
		Engine.time_scale = 0
		
	paused = !paused


func restartLevel():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Playground.tscn")


func backToMainMenu():
	get_tree().change_scene_to_file("res://Menu/StartMenu.tscn")


func addOneHour():
	currentHour += 1
	$ClockBell.play()
	clock.changeHour(currentHour)
	
	if (currentHour == 8):
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Menu/VictoryScreen.tscn")

