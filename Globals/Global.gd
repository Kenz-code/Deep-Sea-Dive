extends Node

var camera = null

var level = 1

signal level_finished
signal level_start

var pearls = 0

var mute = false

var custom_scene_change = {
	"color" : Color("0f0f69"),
	"pattern": "res://Art/scene_trans.png",
}

func _ready():
	SilentWolf.configure({
	"api_key": "M6Aubi2Ilx36yu0vUMrlE2aHeuovqgvC2p8wgcIm",
	"game_id": "deepseadive",
	"log_level": 1})
	
	AudioServer.set_bus_volume_db(1, linear_to_db(0.5))
	AudioServer.set_bus_volume_db(2, linear_to_db(0.8))

