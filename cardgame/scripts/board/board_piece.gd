extends Node2D
class_name BoardPiece

@export var usuable: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_player_shift_position() -> Vector2:
	return Vector2(55, 10)

func enemy_board_piece():
	self.usuable = false
	self.modulate = Color(0.8, 0, 0)

func attack_highlight():
	self.modulate = Color(0, 0.8, 0.2)
