extends TextureRect

var heart_size: int = 16

func _on_hearts_changed(hearts):
	size.x = hearts * heart_size
	
	$LossLifeP.position.x = hearts * heart_size + 8
	$LossLifeP.restart()
	
