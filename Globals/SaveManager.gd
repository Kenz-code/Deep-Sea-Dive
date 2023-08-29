extends Node

const SAVE_GAME_PATH := "user://savegame.tres"

var save: SaveGame

func create_or_load_save() -> void:
	if save_exists():
		save = load_savegame()
	else:
		save = SaveGame.new()
		write_savegame()


func save_game() -> void:
	write_savegame()


func write_savegame() -> void:
	ResourceSaver.save(save, SAVE_GAME_PATH)


static func save_exists() -> bool:
	return ResourceLoader.exists(SAVE_GAME_PATH)


static func load_savegame() -> Resource:
	return ResourceLoader.load(SAVE_GAME_PATH)

func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		create_or_load_save()
		save.high_score = 0
		save.name = ""
		save_game()
