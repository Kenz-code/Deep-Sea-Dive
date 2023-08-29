extends Node2D

var segment_path = "res://Segements/segment"

var s_num = {
	"level1": [1, 2, 3, 8, "res://Segements/finish_segment.tscn", "res://Segements/start_segment1.tscn"],
	"level2": [4, 5, 9, 10, "res://Segements/finish_segment.tscn", "res://Segements/start_segment2.tscn"],
	"level3": [6, 7, 11, 12, "res://Segements/finish_segment.tscn", "res://Segements/start_segment3.tscn"]
}

var previous_segment_num = 0

signal segments_created

func create_segments(start_pos, finish_segment := false, amount:= 10):
	for i in range(amount):
		if i == amount - 1:
			var segment_scene = load(s_num["level" + str(Global.level)][s_num["level" + str(Global.level)].size()-2])
			var segment = segment_scene.instantiate()
			segment.position.y = (720 * i) + start_pos
			add_child(segment)
			segment.get_node("TileMapP").make_particles.emit()
			
			Global.camera.limit_bottom = amount * 720 + start_pos + -Global.camera.offset.y
		elif i == 0:
			var segment_scene = load(s_num["level" + str(Global.level)][s_num["level" + str(Global.level)].size()-1])
			var segment = segment_scene.instantiate()
			segment.position.y = start_pos
			add_child(segment)
			segment.get_node("TileMapP").make_particles.emit()
		else:
			var to_num = s_num["level" + str(Global.level)].size() - 3
			
			var segment_iter = randi_range(0, to_num)
			var segment_num = s_num["level" + str(Global.level)][segment_iter]
			
			while segment_num == previous_segment_num:
				segment_iter = randi_range(0, to_num)
				segment_num = s_num["level" + str(Global.level)][segment_iter]
			previous_segment_num = segment_num
			
			var segment_scene = load(segment_path + str(segment_num) + ".tscn")
			var segment = segment_scene.instantiate()
			segment.position.y = (720 * i) + start_pos
			add_child(segment)
			segment.get_node("TileMapP").make_particles.emit()
	

func delete_segments():
	for i in get_children():
		i.queue_free()
