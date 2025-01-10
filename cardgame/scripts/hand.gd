extends Node2D

@export var HAND_SIZE = 200.0

const horizontal_curve: Curve = preload("res://resources/horizontal_spacing_curve.tres")

var hand: Array[CardScene]
var highlighted: Array[CardScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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

func _on_game_manager_card_added_hand(card: CardScene) -> void:
	hand.push_back(card)
	card.hover.connect(self.hover_card)
	card.blur.connect(self.blur_card)
	add_child(card)
	update_hand_fanning()

func hover_card(card: CardScene):
	highlighted.push_back(card)
	
func blur_card(card: CardScene):
	highlighted.erase(card)

func update_hand_fanning():
	for i in hand.size():
		var card = hand[i]
		
		if hand.size() > 1:
			var hand_ratio = float(i) / (hand.size() - 1)
			card.z_index = i + 1
			card.position.x = horizontal_curve.sample(hand_ratio) * HAND_SIZE
