extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_area_2d_body_exited(body):
	if body.name == "Player":
		$Area2D.set_deferred("monitioring",false)
		$Area2D.set_deferred("monitiorable",false)
		
		Global.level_finished.emit()
