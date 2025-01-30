extends Unit
class_name Player

@onready var stats_ui: StatsUI = $StatsUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("player")

	health.died.connect(_on_unit_death)
	health.health_change.connect(stats_ui.update)

	self.init()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_unit_death():
	print("PLAYER %s has died" % stats.name)
