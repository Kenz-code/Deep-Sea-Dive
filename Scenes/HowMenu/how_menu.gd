extends Control


func _on_back_button_pressed():
	SceneManager.change_scene("res://Scenes/MainMenu/main_menu.tscn", Global.custom_scene_change)
