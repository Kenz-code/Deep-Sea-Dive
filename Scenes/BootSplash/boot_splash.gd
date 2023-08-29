extends Control

func _on_animation_player_animation_finished(_anim_name):
	SceneManager.change_scene("res://Scenes/MainMenu/main_menu.tscn", Global.custom_scene_change)
