extends Control


func _ready():
	$VBoxContainer/StartBtn.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_start_btn_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Playground.tscn")


func _on_help_btn_pressed():
	$HelpUI.visible = true
	$HelpUI/HelpBackBtn.grab_focus()


func _on_credits_btn_pressed():
	$CreditsUI.visible = true
	$CreditsUI/CreditsBackBtn.grab_focus()


func _on_quit_btn_pressed():
	get_tree().quit()


func _on_help_back_btn_pressed():
	$HelpUI.visible = false
	$VBoxContainer/StartBtn.grab_focus()
	

func _on_credits_back_btn_pressed():
	$CreditsUI.visible = false
	$VBoxContainer/StartBtn.grab_focus()
