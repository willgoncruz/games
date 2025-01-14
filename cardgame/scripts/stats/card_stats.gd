class_name CardStats
extends Resource

@export var cost: int = 0
@export var name: String = ""
@export var description: String = ""
@export var sprite: Texture2D

# Ranges that the card attacks on board
@export var attack: AttackStats
