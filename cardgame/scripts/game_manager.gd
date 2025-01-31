extends Node
class_name GameManager

@export var player_stats: CharacterStats

@onready var end_turn: Button = $"End Turn"

func _ready() -> void:
	SignalBus.player_hand_drawn.connect(_on_player_hand_drawn)

func _on_button_pressed() -> void:
	end_turn.disabled = true
	SignalBus.player_turn_ended.emit()


func _on_snapback_pressed() -> void:
	$"../Hand".update_hand_fanning()

func _on_turn_count(card: CardScene):
	pass

func _on_player_hand_drawn() -> void:
	end_turn.disabled = false
