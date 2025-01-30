extends Control

@export var HAND_SIZE = 400.0

const horizontal_curve: Curve = preload("res://resources/horizontal_spacing_curve.tres")

var hand: Array[CardScene]
var highlighted: Array[CardScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.draw_card.connect(_on_deck_draw_card)
	SignalBus.play_card.connect(_on_play_card)
	SignalBus.unhand_card.connect(_on_unhand_card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Highlight the current card in mouse position
	highlight_current_card()

func highlight_current_card():
	var highest_index_highlight = -1
	for card in highlighted:
		card.unhighlight()
		highest_index_highlight = max(highest_index_highlight, hand.find(card))
	
	if highest_index_highlight in range(hand.size()):
		hand[highest_index_highlight].highlight()

func _on_play_card(card: CardScene) -> void:
	hand.erase(card)
	card.queue_free()
	update_hand_fanning()

func _on_unhand_card(_card: CardScene) -> void:
	update_hand_fanning()

func _on_deck_draw_card(card: CardScene) -> void:
	if card == null:
		return

	hand.push_back(card)
	card.hover.connect(self.hover_card)
	card.blur.connect(self.blur_card)
	card.position = Vector2(horizontal_curve.sample(-1.0) * HAND_SIZE, 0)
	add_child(card)
	update_hand_fanning()

func hover_card(card: CardScene):
	highlighted.push_back(card)

func blur_card(card: CardScene):
	card.unhighlight()
	highlighted.erase(card)

func update_hand_fanning():
	for i in range(hand.size()):
		var card = hand[i]
		
		if hand.size() > 1:
			var hand_ratio = float(i) / (hand.size() - 1)
			var new_position = Vector2(horizontal_curve.sample(hand_ratio) * HAND_SIZE, 0)
			card.z_index = hand.size() - i
			card.unhighlight()
			card.animate_to_position(new_position)
