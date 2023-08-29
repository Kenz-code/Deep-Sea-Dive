class_name Health
extends Node2D


@export var max_health := 3
var health = max_health

func _ready():
	health = max_health

func damage(health_points : int):
	health -= health_points

func heal(health_points : int):
	health += health_points
	
	if health > max_health:
		health = max_health
