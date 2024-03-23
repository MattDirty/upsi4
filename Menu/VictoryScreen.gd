extends Control


func _ready():
	$TextureRect/BackToMainMenuBtn.grab_focus()


func _on_back_to_main_menu_btn_pressed():
	get_tree().change_scene_to_file("res://Menu/StartMenu.tscn")
