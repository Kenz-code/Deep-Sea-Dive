extends Node2D

@export var colors : Array[Gradient]

var p = preload("res://Objects/tilemap_part/gpu_particles_2d.tscn")

signal make_particles

func _on_make_particles():
	var tilemap = get_parent().get_node("TileMap")
	for cell in tilemap.get_used_cells(0):
		var tiledata = tilemap.get_cell_tile_data(0, cell)
		if tiledata.get_custom_data("red"):
			var part = p.instantiate()
			part.position = tilemap.map_to_local(cell) * 3
			part.color_initial_ramp = colors[1]
			part.emitting = true
			add_child(part)
		elif tiledata.get_custom_data("blue"):
			var part = p.instantiate()
			part.position = tilemap.map_to_local(cell) * 3
			part.color_initial_ramp = colors[3]
			part.emitting = true
			add_child(part)
		elif tiledata.get_custom_data("pink"):
			var part = p.instantiate()
			part.position = tilemap.map_to_local(cell) * 3
			part.color_initial_ramp = colors[4]
			part.emitting = true
			add_child(part)
