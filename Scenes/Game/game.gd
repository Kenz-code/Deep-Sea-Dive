extends Node2D

var player_default_spawn = Vector2(280,200)

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.level = 1
	Global.pearls = 0
	
	Global.level_finished.connect(_on_level_finished)
	Global.level_start.connect(_on_level_start)
	
	Global.level_start.emit()
	
	$Segments.delete_segments()
	$Segments.create_segments(0, true, 8)
	
	BgMusic.stream = load("res://SFX/Brackeys_Gamejam_Gameplay_Music_V2.mp3")
	BgMusic.play()

func _on_level_start():
	$UI/Control/DepthCounter.start(str(Global.level - 1) + "000m")


func _on_level_finished():
	$Player.can_move = false
	$Player.reset_dive_cooldown()
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	$Player.position = player_default_spawn
	
	$Segments.delete_segments()
	
	Global.level += 1
	if Global.level > 3:
		game_finished()
		return
		
	$MenuBG.texture = load("res://Art/bg" + str(Global.level)+ ".png")
	$MenuBG.position.y = 0
	
	$Segments.create_segments(0, true, 8)
	
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	$Player.can_move = true
	Global.level_start.emit()

func game_finished():
	SceneManager.change_scene("res://Scenes/FinishMenu/finish_menu.tscn", Global.custom_scene_change)
