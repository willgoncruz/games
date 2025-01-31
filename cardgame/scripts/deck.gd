extends Node2D
class_name Deck

@export var player_stats: CharacterStats : set = _set_player_stats

@onready var count = $Count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _set_player_stats(stats: CharacterStats):
	player_stats = stats
	player_stats.draw.card_pile_changed.connect(_change_draw_pile_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
func _change_draw_pile_count(pile: CardPile):
	count.text = str(pile.size())

func _on_game_manager_card_added_hand(card: CardScene) -> void:
	player_stats.deck.add_card(card.stats)

func draw_card_from_deck():
	var card = player_stats.draw.draw_card()
	SignalBus.draw_card.emit(card)

func _on_input_manager_interact_deck() -> void:
	draw_card_from_deck()
