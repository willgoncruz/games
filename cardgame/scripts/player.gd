extends Node2D
class_name Player

const X_SIZE = 225
const Y_SIZE = 150

@export var health: HealthComponent
@export var movement: MovementComponent

#var grid_position: Vector2 = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func move(position: Vector2):
	self.position = position

#func get_grid_position() -> Vector2:
	#return grid_position
#
## Moves the player position on grid
#func shift(movement: Vector2):
	#grid_position += position
