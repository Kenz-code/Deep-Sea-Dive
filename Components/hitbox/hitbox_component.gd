extends Area2D

signal body_hit(body)

func _on_body_entered(body):
	body_hit.emit(body)
