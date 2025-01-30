extends Node2D

const BOARD_SIZE = Vector2(3, 3)

const BoardPieceScene = preload("res://scenes/board_piece.tscn")
const EnemyScene = preload("res://scenes/enemy.tscn")

var player: Player
var enemies: Array[Enemy]
var board: Array[BoardPiece]

#var player_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("Player")
	player.movement.shift(Vector2i(1, 1))

	board.resize(2 * BOARD_SIZE.x * BOARD_SIZE.y)
	for i in range(2 * BOARD_SIZE.x):
		for j in range(BOARD_SIZE.y):
			var player_board_piece = BoardPieceScene.instantiate()
			board[i * BOARD_SIZE.x + j] = player_board_piece
			player_board_piece.set_grid_base(i, j)
			
			if i > 2:
				player_board_piece.enemy_board_piece()

			add_child(player_board_piece)
	
	move_entity_to_board_position(player)
	
	for i in BOARD_SIZE.y:
		var enemy = EnemyScene.instantiate()
		enemy.stats = preload("res://resources/units/slime.tres")
		enemy.movement.shift(Vector2i(3, i))
		enemies.push_back(enemy)
		move_entity_to_board_position(enemy)
		add_child(enemy)
	
	SignalBus.play_card.connect(play_card)
	SignalBus.enemy_act.connect(enemy_act)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent):
	var move = Vector2i.ZERO
	if event is not InputEventMouseButton:
		if Input.is_action_pressed("ui_right"):
			move = Vector2i.RIGHT
		elif Input.is_action_pressed("ui_left"):
			move = Vector2i.LEFT
		elif Input.is_action_pressed("ui_down"):
			move = Vector2i.DOWN
		elif Input.is_action_pressed("ui_up"):
			move = Vector2i.UP

	if move != Vector2i.ZERO and can_make_move(move):
		player.movement.shift(move)
		move_entity_to_board_position(player)

func can_make_move(move: Vector2i):
	var board_piece = get_board_piece_at(player.movement.board_position() + move)
	if board_piece == null:
		return false

	return board_piece.usuable

func move_entity_to_board_position(node: Node2D):
	if !node.has_node("MovementComponent"):
		pass

	var movement: MovementComponent = node.get_node("MovementComponent") as MovementComponent
	var board_piece = get_board_piece_at(movement.board_position())
	if board_piece != null:
		board_piece.position_inside(node)

func get_board_piece_at(position: Vector2i) -> BoardPiece:
	return board.filter(func (piece: BoardPiece): return piece.grid_base == position).pop_front()

func get_units() -> Array[Unit]:
	var units: Array[Unit] = []
	units.assign(get_tree().get_nodes_in_group("units"))
	return units

func play_card(card: CardScene):
	for effect in card.stats.get_effects():
		var effective_range = card.stats.range.get_active_range(player.movement.board_position())
		var targets: Array[Unit] = get_units().filter(func (unit: Unit): return effective_range.contains(unit.movement.board_position()))
	
		effect.execute(targets)
		get_tree().call_group("board", "attack_highlight", effective_range)

	#var damage: DamageStats = DamageStats.from(player, card.stats.attack)

	#get_tree().call_group("enemies", "hit", damage)
	get_tree().call_group("enemies", "turn_countdown", 1)

### TODO RACE CONDITION OF BEING HIT AND ENEMY ACT, CREATE SAFEGUARD
func enemy_act(enemy: Enemy):
	#var damage: DamageStats = DamageStats.enemy_action(enemy)
	#
	#get_tree().call_group("player", "hit", damage)
	#get_tree().call_group("board", "attack_highlight", damage)

	enemy.reset_action()
