extends Node2D
class_name Unit

@export var health: HealthComponent
@export var movement: MovementComponent

@export var stats: UnitStats

func init() -> void:
	add_to_group("units")

	health.init(stats.max_health)
	health.died.connect(_on_unit_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit(damage: DamageStats):
	if damage.range.contains(movement.board_position()):
		health.damage(damage)

func _on_unit_death():
	print("UNIT %s has died" % stats.name)
	queue_free()
