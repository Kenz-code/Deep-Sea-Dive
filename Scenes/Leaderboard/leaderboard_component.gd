extends HBoxContainer


func set_values(pos,_name,score):
	$Pos.text = str(pos) + ". "
	$Name.text = str(_name)
	$Score.text = str(score)
