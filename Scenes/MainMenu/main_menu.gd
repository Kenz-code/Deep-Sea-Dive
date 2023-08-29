extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SaveManager.create_or_load_save()
	if SaveManager.save.name == "":
		get_tree().change_scene_to_file("res://Scenes/NameInputMenu/name_input_menu.tscn")




func _on_play_button_pressed():
	SceneManager.change_scene("res://Scenes/Game/game.tscn", Global.custom_scene_change)


func _on_cred_button_pressed():
	SceneManager.change_scene("res://Scenes/CreditsMenu/credits_menu.tscn", Global.custom_scene_change)


func _on_leaderboard_button_pressed():
	SceneManager.change_scene("res://Scenes/Leaderboard/leaderboard_menu.tscn", Global.custom_scene_change)


func _on_how_button_pressed():
	SceneManager.change_scene("res://Scenes/HowMenu/how_menu.tscn", Global.custom_scene_change)


func _on_mute_button_pressed():
	Global.mute = not Global.mute
	AudioServer.set_bus_mute(0, Global.mute)
	if Global.mute:
		$MuteButton.icon = load("res://Art/muted_button.png")
		$AnimationPlayer.play("Shameonyou")
	else:
		$MuteButton.icon = load("res://Art/mute_button.png")
