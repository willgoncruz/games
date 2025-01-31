extends Resource
class_name CardPile

@export var cards: Array[CardStats] = []

signal card_pile_changed(card_pile: CardPile)

func empty() -> bool:
	return cards.is_empty()

func size() -> int:
	return cards.size()
	
func draw_card() -> CardStats:
	var card = cards.pop_front()
	card_pile_changed.emit(self)
	return card

func assign(pile: CardPile) -> void:
	cards.assign(pile.cards)

func add_card(card: CardStats) -> void:
	cards.push_back(card)
	card_pile_changed.emit(self)

func shuffle() -> void:
	cards.shuffle()
	
