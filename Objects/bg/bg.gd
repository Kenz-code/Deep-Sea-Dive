@tool
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(100):
		var sprite = Sprite2D.new()
		sprite.texture = load("res://Art/Bg.png")
		sprite.centered = false
		sprite.position.y = 720 * i
		sprite.position.x = -80
		add_child(sprite)
