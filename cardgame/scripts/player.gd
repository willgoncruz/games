extends Node2D
class_name Player

const X_SIZE = 225
const Y_SIZE = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func move(position: Vector2):
	self.position = position
