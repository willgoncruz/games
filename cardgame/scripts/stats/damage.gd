class_name DamageStats
extends Resource

var damage: int
var range: GridRange

static func from(player: Player, attack: AttackStats):
	var damage = DamageStats.new()
	damage.damage = attack.damage
	damage.range = attack.range.get_active_range(player.movement.board_position())
	return damage
