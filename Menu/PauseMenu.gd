extends Control


@onready var playground = get_tree().root.get_node("Playground")


func _ready():
	$PauseMenu/VBoxContainer/ContinueBtn.grab_focus()


func _on_continue_btn_pressed():
	playground.pauseMenu()


func _on_restart_btn_pressed():
	playground.restartLevel()


func _on_back_to_main_menu_btn_pressed():
	playground.backToMainMenu()
