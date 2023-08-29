extends HBoxContainer

var prev_pearls = 0

func _ready():
	pivot_offset = size /2

func _process(_delta):
	$PearlCounter.text = str(Global.pearls)
	if Global.pearls != prev_pearls:
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self,"scale", Vector2(1.1,1.1),0.1)
		tween.tween_property(self,"scale", Vector2(1,1),0.1)
	
	prev_pearls = Global.pearls
