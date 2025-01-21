extends Node2D
class_name HealthComponent

signal died()

var health: int
var max_health: int

func init(initial_health: int):
	self.health = initial_health
	self.max_health = initial_health

func damage(attack: DamageStats):
	self.health -= attack.damage

	if self.health <= 0:
		died.emit()

func is_alive():
	return health > 0
