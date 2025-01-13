extends Node

const KNIGHT = preload("res://resources/cards/knight.tres")
const CARD_SCENE  = preload("res://scenes/card.tscn")

signal card_added_hand(card: CardScene)

func _on_button_pressed() -> void:
	var new_card = CARD_SCENE.instantiate()
	new_card.stats = KNIGHT
	card_added_hand.emit(new_card)


func _on_snapback_pressed() -> void:
	$"../Hand".update_hand_fanning()
