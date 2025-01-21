class_name GridRange
extends Resource

@export var range: Array[Vector2i] = []

func get_active_range(base_board_position: Vector2i) -> GridRange:
	var new_range: Array[Vector2i]
	new_range.assign(range.map(func (r): return r + base_board_position))
	
	var g = GridRange.new()
	g.range = new_range
	return g

func get_enemy_range(base_board_position: Vector2i) -> GridRange:
	var new_range: Array[Vector2i]
	new_range.assign(range.map(func (r): return base_board_position - r))
	
	var g = GridRange.new()
	g.range = new_range
	return g

func contains(base_board_position: Vector2i):
	return range.has(base_board_position)
