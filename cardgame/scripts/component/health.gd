extends Node2D
class_name HealthComponent

const INITIAL_HEALTH = 10

var health: int = INITIAL_HEALTH

func damage(attack: DamageStats):
	health -= attack.damage
	
	if health <= 0:
		print("YOU DIED")
