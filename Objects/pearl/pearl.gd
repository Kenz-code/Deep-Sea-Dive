extends RigidBody2D

enum Types {
	ORANGE,
	PURPLE,
	BLUE
}
var type = Types.ORANGE

var colors : Array = [load("res://Objects/tilemap_part/1.tres"),
	load("res://Objects/tilemap_part/2.tres"),
	load("res://Objects/tilemap_part/3.tres")]

func _process(_delta):
	$CollectP.color_initial_ramp = colors[type]
	match type:
		Types.ORANGE:
			$Sprite2D.texture = load("res://Art/orange.png")
		Types.PURPLE:
			$Sprite2D.texture = load("res://Art/prupl.png")
		Types.BLUE:
			$Sprite2D.texture = load("res://Art/blue.png")

func _on_area_body_entered(body):
	if body.name == "Player":
		Global.camera.shake(25)
		Global.pearls += 1
		
		$CollectP.restart()
		
		$Area/CollisionShape2D.set_deferred("disabled",true)
		$CollisionShape2D.set_deferred("disabled",true)
		$Sprite2D.hide()
		
		$CollectSFX.play()
		
		await get_tree().create_timer(0.7).timeout
		queue_free()
