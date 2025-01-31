extends UnitStats
class_name CharacterStats

@export var max_mana: int = 0
@export var cards_per_turn: int = 0

@export var starting_deck: CardPile: set = set_starting_deck

@export var deck: CardPile
@export var draw: CardPile
@export var discard: CardPile

var mana: int : set = set_mana

func set_starting_deck(new_pile: CardPile):
	starting_deck = new_pile
	deck = new_pile.duplicate(true)

func set_mana(value: int) -> void:
	mana = value
	stats_changed.emit(self)

func reset_mana() -> void:
	mana = max_mana

func can_play_card(card: CardStats) -> bool:
	return mana >= card.cost

func start_battle() -> void:
	draw.assign(deck.duplicate(true))
	draw.shuffle()

static func instance(stats: CharacterStats) -> CharacterStats:
	var new_stats = stats.duplicate()
	new_stats.reset_mana()
	new_stats.deck = stats.starting_deck.duplicate(true)
	new_stats.draw = CardPile.new()
	new_stats.discard = CardPile.new()
	return new_stats
