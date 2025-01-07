extends Node2D

const CELL_SIZE = 16
const BOARD_SIZE = 30

const BG_TILE = Vector2i(0, 9)
const WALL_TILE = Vector2i(0, 15)
const APPLE_TILE = Vector2i(2, 14)
const SNAKE_TILE = Vector2i(1, 13)

@onready var timer = $Timer
@onready var map = $TileMap

var snake: Array[Vector2]
var game_over = true

var direction: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_init()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
	if Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT

	if direction != Vector2.ZERO and game_over:
		game_start()

func game_init():
	for i in BOARD_SIZE - 1:
		for j in BOARD_SIZE - 1:
			map.set_cell(0, Vector2(i + 1, j + 1), 0, BG_TILE)
		
	direction = Vector2.ZERO

	var start_pos = Vector2(5, 5)
	snake.clear()
	snake.append(start_pos)
	map.set_cell(0, start_pos, 0, SNAKE_TILE)

func game_start():
	game_over = false
	create_apple()
	timer.start()

func game_finish():
	game_over = true
	timer.stop()
	game_init()

func _on_timer_timeout() -> void:
	if game_over:
		return

	var head = snake[-1]
	
	var next = head + direction
	snake.append(next)

	var next_cell = map.get_cell_atlas_coords(0, next)
	
	if next_cell == BG_TILE:
		map.set_cell(0, next, 0, SNAKE_TILE)
		map.set_cell(0, snake.pop_front(), 0, BG_TILE)
	elif next_cell == APPLE_TILE:
		map.set_cell(0, next, 0, SNAKE_TILE)
		create_apple()
	else:
		game_finish()

func create_apple():
	var possibilities = []
	for i in BOARD_SIZE - 1:
		for j in BOARD_SIZE - 1:
			var pos = Vector2(i + 1, j + 1)
			var cell = map.get_cell_atlas_coords(0, pos)
			if cell != SNAKE_TILE:
				possibilities.append(pos)
			
	var apple_pos = possibilities[randi_range(0, possibilities.size())]
	map.set_cell(0, apple_pos, 0, APPLE_TILE)
