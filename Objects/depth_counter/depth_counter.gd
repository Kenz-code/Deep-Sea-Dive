extends Label


func start(depth : String):
	text = depth
	$AnimationPlayer.play("blink")
