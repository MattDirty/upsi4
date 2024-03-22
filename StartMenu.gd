extends Control


func _ready():
	$VBoxContainer/StartBtn.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://Playground.tscn")


func _on_help_btn_pressed():
	pass # Replace with function body.


func _on_credits_btn_pressed():
	pass # Replace with function body.


func _on_quit_btn_pressed():
	get_tree().quit()
