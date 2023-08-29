extends Control

var is_add_score = false
var add_score_finished = false

var death_phrases : Array[String] = ["lol noob",
"drink some\nmilk nerd",
"your death\ngo BRRRRRR",
"imagine\ngetting\nowned\nby a fish",
"#1 Tip:\nDon't die",
"'Wow, that\nwas great!'\n- No one"]

func _ready():
	$Title.text = death_phrases[randi() % death_phrases.size()]
	$Pearls.text = "Pearls: " + str(Global.pearls)
	
	SaveManager.create_or_load_save()
	if Global.pearls > SaveManager.save.high_score:
		is_add_score = true
		
		SaveManager.save.high_score = Global.pearls
		SaveManager.save_game()
		
		add_score()
	
	BgMusic.stream = load("res://SFX/Brackeys_GameJam_Music_Main_Menu_Loop_V2.1.mp3")
	BgMusic.play()

func add_score():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	for score in sw_result.scores:
		if score.player_name == SaveManager.save.name:
			await SilentWolf.Scores.delete_score(score.score_id).sw_delete_score_complete
	
	#add new score
	await SilentWolf.Scores.save_score(SaveManager.save.name, Global.pearls).sw_save_score_complete
	add_score_finished = true

func _on_menu_button_pressed():
	if is_add_score:
		if add_score_finished:
			SceneManager.change_scene("res://Scenes/MainMenu/main_menu.tscn", Global.custom_scene_change)
		else:
			$AnimationPlayer.play("score_saving")
	else:
		SceneManager.change_scene("res://Scenes/MainMenu/main_menu.tscn", Global.custom_scene_change)


func _on_play_button_pressed():
	if is_add_score:
		if add_score_finished:
			SceneManager.change_scene("res://Scenes/Game/game.tscn", Global.custom_scene_change)
		else:
			$AnimationPlayer.play("score_saving")
	else:
		SceneManager.change_scene("res://Scenes/Game/game.tscn", Global.custom_scene_change)
