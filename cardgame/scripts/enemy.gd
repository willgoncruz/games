extends Node2D
class_name Enemy

@export var health: HealthComponent
@export var movement: MovementComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hit(damage: DamageStats):
	if damage.range.contains(movement.board_position()):
		health.damage(damage)
