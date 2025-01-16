extends Node2D
class_name BoardPiece

static var BOARD_PIECE_SIZE = Vector2i(112, 80)

@export var usuable: bool = true

var grid_base: Vector2i = Vector2i(-1, -1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("board")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_player_shift_position() -> Vector2i:
	return Vector2(55, 10)

func set_grid_base(x, y: int):
	grid_base = Vector2i(x, y)
	position = BOARD_PIECE_SIZE * grid_base

func position_inside(node: Node2D):
	node.position = position + Vector2(55, 10)

func enemy_board_piece():
	self.usuable = false
	self.modulate = Color(0.8, 0, 0)

func attack_highlight(damage: DamageStats):
	if damage.range.contains(grid_base):
		self.modulate = Color(0, 0.8, 0.2)

func unhighlight():
	self.modulate = Color(1, 1, 1)
