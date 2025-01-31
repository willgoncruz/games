extends Node
class_name PlayerManager

@export var hand: Hand
@export var deck: Deck
@export var board: Board

@export var character_stats: CharacterStats

const HAND_DRAW_INTERVAL := 0.5

func _ready() -> void:
	SignalBus.play_card.connect(_on_play_card)
	SignalBus.player_turn_ended.connect(_on_turn_ended)
	SignalBus.player_hand_discarded.connect(start_turn)

	character_stats = CharacterStats.instance(character_stats)

	hand.player_stats = character_stats
	deck.player_stats = character_stats
	board.player.stats = character_stats
	start_battle()

func start_battle() -> void:
	character_stats.start_battle()
	start_turn()

func start_turn() -> void:
	character_stats.reset_mana()
	draw_cards(character_stats.cards_per_turn)

func draw_card() -> void:
	reshuffle_draw_from_discard()
	hand.add_card(character_stats.draw.draw_card())
	reshuffle_draw_from_discard()

func reshuffle_draw_from_discard() -> void:
	if not character_stats.draw.empty():
		return

	while not character_stats.discard.empty():
		character_stats.draw.add_card(character_stats.discard.draw_card())

	character_stats.draw.shuffle()

func discard_cards() -> void:
	var cards = hand.get_children()
	if cards.is_empty():
		SignalBus.player_hand_discarded.emit()
		return

	var tween = create_tween()
	for card in cards:
		tween.tween_callback(character_stats.discard.add_card.bind(card.stats))
		tween.tween_callback(hand.discard_card.bind(card))
		tween.tween_interval(HAND_DRAW_INTERVAL)

	tween.finished.connect(
		func(): SignalBus.player_hand_discarded.emit()
	)

func draw_cards(amount: int) -> void:
	var tween = create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)

	tween.finished.connect(
		func(): SignalBus.player_hand_drawn.emit()
	)

func _on_turn_ended() -> void:
	hand.disable()
	discard_cards()

func _on_play_card(card: CardScene) -> void:
	character_stats.discard.add_card(card.stats)
