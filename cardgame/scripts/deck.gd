extends Node2D

var deck: Array[CardScene] = []

@onready var count = $Count

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	const CARD_SCENE  = preload("res://scenes/card.tscn")
	const PLAYER = preload("res://resources/characters/test/test_stats.tres")
	
	var player = CharacterStats.instance(PLAYER)
	
	for card_stats in player.starting_deck.cards:
		var new_card = CARD_SCENE.instantiate()
		new_card.stats = card_stats
		#deck = player.starting_deck
		_on_game_manager_card_added_hand(new_card)
		draw_card_from_deck()
	
	#for i in range(5):
		#const KNIGHT = preload("res://resources/cards/knight.tres")
		#const LASER = preload("res://resources/cards/laser.tres")
#
		#var new_card = CARD_SCENE.instantiate()
		#new_card.stats = KNIGHT
		#_on_game_manager_card_added_hand(new_card)
		#
		#new_card = CARD_SCENE.instantiate()
		#new_card.stats = LASER
		#_on_game_manager_card_added_hand(new_card)
		#
		#draw_card_from_deck()
		#draw_card_from_deck()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count.text = str(deck.size())

func _on_game_manager_card_added_hand(card: CardScene) -> void:
	deck.push_back(card)

func draw_card_from_deck():
	var card = deck.pop_front()
	SignalBus.draw_card.emit(card)

func _on_input_manager_interact_deck() -> void:
	draw_card_from_deck()
