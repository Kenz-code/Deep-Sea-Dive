extends Node

var open_sfx = ["res://SFX/UI_Whoosh_Open_01.mp3", "res://SFX/UI_Whoosh_Open_02.mp3", "res://SFX/UI_Whoosh_Open_03.mp3"]
var close_sfx = ["res://SFX/UI_Whoosh_Close_01.mp3", "res://SFX/UI_Whoosh_Close_02.mp3", "res://SFX/UI_Whoosh_Close_03.mp3"]

func _ready():
	SceneManager.fade_complete.connect(open)

func close():
	$CloseSFX.stream = load(close_sfx[randi() % close_sfx.size()])
	$CloseSFX.play()

func open():
	$OpenSFX.stream = load(open_sfx[randi() % open_sfx.size()])
	$OpenSFX.play()
