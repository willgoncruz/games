extends Node2D

const Y_TILE_SIZE = 80
const X_TILE_SIZE = 112

const BOARD_SIZE = Vector2(3, 3)
const BOARD_MOVE = Vector2(X_TILE_SIZE, Y_TILE_SIZE)

const BoardPieceScene = preload("res://scenes/board_piece.tscn")

var player: Player
var board: Array[BoardPiece]

var player_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("Player")
	player_position = Vector2(1, 1)
	
	board.resize(2 * BOARD_SIZE.x * BOARD_SIZE.y)
	for i in range(2 * BOARD_SIZE.x):
		for j in range(BOARD_SIZE.y):
			var player_board_piece = BoardPieceScene.instantiate()
			player_board_piece.position = BOARD_MOVE * Vector2(i, j)
			board[i * BOARD_SIZE.x + j] = player_board_piece
			if i > 2:
				player_board_piece.enemy_board_piece()
				
			add_child(player_board_piece)
	
	move_player_board_position()
	SignalBus.play_card.connect(play_card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent):
	var move = Vector2.ZERO
	if event is not InputEventMouseButton:
		if Input.is_action_pressed("ui_right"):
			move = Vector2.RIGHT
		elif Input.is_action_pressed("ui_left"):
			move = Vector2.LEFT
		elif Input.is_action_pressed("ui_down"):
			move = Vector2.DOWN
		elif Input.is_action_pressed("ui_up"):
			move = Vector2.UP

	if move != Vector2.ZERO and can_make_move(move):
		player_position += move
		move_player_board_position()

func can_make_move(move: Vector2):
	var new_player_position = player_position + move
	return get_board_piece_at(new_player_position).usuable

func move_player_board_position():
	var player_screen_position = player_position * BOARD_MOVE + Vector2(55, 10)
	player.move(player_screen_position)

func get_board_piece_at(position: Vector2):
	var index: int = (position.x) * BOARD_SIZE.x + position.y
	if range(board.size()).has(index):
		return board[index]

	return null

func play_card(card: CardScene):
	var range = card.stats.attack.get_range()
	
	for position in range:
		var attack_position = player_position + position
		var board_piece = get_board_piece_at(attack_position)
		if board_piece:
			board_piece.attack_highlight()
