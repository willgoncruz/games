extends Node2D

@export var HAND_SIZE = 400.0

const horizontal_curve: Curve = preload("res://resources/horizontal_spacing_curve.tres")

var hand: Array[CardScene]
var highlighted: Array[CardScene]
var card_dragged: CardScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Highlight the current card in mouse position
	highlight_current_card()
	
	# Drag the current card 
	drag_card()

func _on_input_manager_interact_hand(card: CardScene) -> void:
	card_dragged = card
	
func _on_input_manager_mouse_released() -> void:
	update_hand_fanning()
	card_dragged = null
	
func highlight_current_card():
	var highest_index_highlight = -1
	for card in highlighted:
		card.unhighlight()
		highest_index_highlight = max(highest_index_highlight, hand.find(card))
	
	if highest_index_highlight in range(hand.size()):
		hand[highest_index_highlight].highlight()

func drag_card():
	if card_dragged:
		var viewport = get_viewport_rect().size
		var mouse_pos = get_global_mouse_position()
		card_dragged.global_position = Vector2(
			clamp(mouse_pos.x, 0, viewport.x),
			clamp(mouse_pos.y, 0, viewport.y),
		)

func _on_deck_draw_card(card: CardScene) -> void:
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
			card.unhighlight()
			card.animate_to_position(new_position)


func _on_play_card_area_released() -> void:
	hand.erase(card_dragged)
	card_dragged = null
