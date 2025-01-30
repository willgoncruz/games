extends Unit
class_name Enemy

@export var actions: Array[EnemyAction]

@onready var turn_display = $Info/TurnCount
@onready var stats_ui: StatsUI = $StatsUI

var countdown: int
var current_action: EnemyAction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.health_change.connect(stats_ui.update)

	self.init()
	add_to_group("enemies")

	reset_action()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_turn_countdown(turns: int):
	countdown = turns
	turn_display.text = str(countdown)

func turn_countdown(count: int):
	set_turn_countdown(countdown - count)
	if can_act() and countdown <= 0:
		SignalBus.enemy_act.emit(self)

func can_act() -> bool:
	return health.is_alive()

func action() -> EnemyAction:
	return current_action
	
func reset_action():
	var i = randi_range(0, actions.size() - 1)
	current_action = actions[i]
	set_turn_countdown(current_action.turns)
