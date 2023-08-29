extends Control

var l_com = load("res://Scenes/Leaderboard/leaderboard_component.tscn")

func _ready():
	load_scores()


func add_score(player_name : String, score : String, pos : int):
	var l = l_com.instantiate()
	l.set_values(pos,player_name,score)
	
#	if pos <= 1:
#		var col = Color("ef7d57")
#		pos_label.modulate = col
#		score_label.modulate = col
#		player_name_label.modulate = col
	
	
	$ScrollContainer/VBoxContainer.add_child(l)


func clear_scores():
	for c in $ScrollContainer/VBoxContainer.get_children():
		c.queue_free()

func load_scores():
	clear_scores()
	
	$Loading.show()
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	$Loading.hide()
	
	var idx = 1
	for score in sw_result.scores:
		add_score(score.player_name, str(int(score.score)), idx)
		idx +=1


func _on_back_button_pressed():
	SceneManager.change_scene("res://Scenes/MainMenu/main_menu.tscn", Global.custom_scene_change)
