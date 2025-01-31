extends Node2D
class_name Unit

@export var health: HealthComponent
@export var movement: MovementComponent

@export var stats: UnitStats: set = _set_stats

func _set_stats(new_stats: UnitStats):
	stats = new_stats

func init() -> void:
	#await self.ready
	add_to_group("units")

	health.died.connect(_on_unit_death)
	if stats != null:
		health.init(stats.max_health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_unit_death():
	print("UNIT %s has died" % stats.name)
	queue_free()
