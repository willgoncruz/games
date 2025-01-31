extends Control
class_name Hand

@export var HAND_SIZE = 400.0

@export var player_stats: CharacterStats

const CARD_SCENE = preload("res://scenes/card.tscn")

const horizontal_curve: Curve = preload("res://resources/horizontal_spacing_curve.tres")

var highlighted: Array[CardScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.play_card.connect(_on_play_card)
	SignalBus.unhand_card.connect(_on_unhand_card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Highlight the current card in mouse position
	highlight_current_card()

func highlight_current_card():
	pass
	#var highest_index_highlight = -1
	#for card in highlighted:
		#card.unhighlight()
		#highest_index_highlight = max(highest_index_highlight, hand.find(card))
	#
	#if highest_index_highlight in range(hand.size()):
		#hand[highest_index_highlight].highlight()

func _on_play_card(card: CardScene) -> void:
	card.queue_free()
	update_hand_fanning()

func _on_unhand_card(_card: CardScene) -> void:
	update_hand_fanning()

func add_card(card: CardStats) -> void:
	var new_card = CARD_SCENE.instantiate()

	new_card.stats = card
	new_card.hover.connect(self.hover_card)
	new_card.blur.connect(self.blur_card)
	new_card.position = Vector2(horizontal_curve.sample(-1.0) * HAND_SIZE, 0)

	add_child(new_card)
	update_hand_fanning()

func hover_card(card: CardScene):
	highlighted.push_back(card)

func blur_card(card: CardScene):
	card.unhighlight()
	highlighted.erase(card)

func discard_card(card: CardScene):
	card.queue_free()

func disable():
	for card in self.get_children():
		card.disabled = true

func update_hand_fanning():
	var cards = self.get_children()
	for i in range(cards.size()):
		var card = cards[i]
		
		if cards.size() > 1:
			var hand_ratio = float(i) / (cards.size() - 1)
			var new_position = Vector2(horizontal_curve.sample(hand_ratio) * HAND_SIZE, 0)
			card.z_index = cards.size() - i
			card.unhighlight()
			card.animate_to_position(new_position)
