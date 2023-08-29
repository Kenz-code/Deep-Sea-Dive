extends Area2D

signal body_hit(body)

@export var health_component : Health


func _on_body_entered(body):
	health_component.damage(body.damage_points)
	emit_signal("body_hit", body)
