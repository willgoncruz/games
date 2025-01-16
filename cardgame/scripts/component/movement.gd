extends Node2D
class_name MovementComponent

var grid_position: Vector2i = Vector2i(0, 0)

func board_position() -> Vector2i:
	return grid_position

# Moves the player position on grid
func shift(movement: Vector2i):
	grid_position += movement
