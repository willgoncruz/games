extends HBoxContainer
class_name StatsUI

@onready var health_label: Label = $Health/HealthLabel

func update(health: HealthComponent):
	if health_label:
		health_label.text = str(health.health)
