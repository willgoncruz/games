extends UnitStats
class_name CharacterStats

@export var max_mana: int = 0

@export var starting_deck: CardPile

@export var deck: CardPile
@export var hand: CardPile
@export var discard: CardPile

var mana: int : set = set_mana

func set_mana(value: int) -> void:
	mana = value
	stats_changed.emit(self)
	
func reset_mana() -> void:
	mana = max_mana

func can_play_card(card: CardStats) -> bool:
	return mana >= card.cost

static func instance(stats: CharacterStats) -> CharacterStats:
	return stats.duplicate(true)
