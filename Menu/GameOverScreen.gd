extends Control


func _ready():
	$TextureRect/RestartBtn.grab_focus()


func _on_restart_btn_pressed():
	get_tree().change_scene_to_file("res://Playground.tscn")


func _on_back_to_main_menu_btn_pressed():
	get_tree().change_scene_to_file("res://Menu/StartMenu.tscn")
