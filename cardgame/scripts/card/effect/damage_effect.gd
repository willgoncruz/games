extends CardEffect
class_name DamageEffect

var amount: int

static func from(amount: int) -> DamageEffect:
	var damage = DamageEffect.new()
	damage.amount = amount
	return damage

func execute(targets: Array[Unit]) -> void:
	for target in targets:
		if not target:
			continue

		target.health.damage(self.amount)
