class_name TimerBar
extends Control

@export var timer := Timer

func _process(_delta):
	$ProgressBar.max_value = timer.wait_time
	$ProgressBar.value = float(timer.wait_time) - float(timer.time_left)
