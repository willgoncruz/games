extends Node2D
class_name HealthComponent

signal died()
signal health_change(component: HealthComponent)

var health: int
var max_health: int

func init(initial_health: int):
	self.health = initial_health
	self.max_health = initial_health
	health_change.emit(self)

#func damage(attack: AttackStats):
	#self.health -= attack.damage
	#health_change.emit(self)
#
	#if self.health <= 0:
		#died.emit()
		
func damage(damage: int):
	self.health -= damage
	health_change.emit(self)

	if self.health <= 0:
		died.emit()

func is_alive():
	return health > 0
