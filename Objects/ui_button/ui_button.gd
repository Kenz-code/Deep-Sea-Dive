extends Button

var hover_sfx = ["res://SFX/UI_Hover_01.mp3", "res://SFX/UI_Hover_02.mp3", "res://SFX/UI_Hover_03.mp3"]
var click_sfx = ["res://SFX/UI_Click_01.mp3", "res://SFX/UI_Click_02.mp3", "res://SFX/UI_Click_03.mp3"]

func _ready():
	pivot_offset = size /2


func _on_mouse_entered():
	$HoverSFX.stream = load(hover_sfx[randi() % hover_sfx.size()])
	$HoverSFX.play()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"scale", Vector2(1.1,1.1),0.1)


func _on_mouse_exited():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"scale", Vector2(1,1),0.1)


func _on_pressed():
	$ClickSFX.stream = load(click_sfx[randi() % click_sfx.size()])
	$ClickSFX.play()
