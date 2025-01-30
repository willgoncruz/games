extends CardStats

var damage = 10

func get_effects() -> Array[CardEffect]:
	return [DamageEffect.from(damage)]
