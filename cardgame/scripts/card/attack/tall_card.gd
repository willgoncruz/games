extends CardStats

var damage = 5

func get_effects() -> Array[CardEffect]:
	return [DamageEffect.from(damage)]
