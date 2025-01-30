class_name CardStats
extends Resource

@export var id: int = 0
@export var cost: int = 0
@export var name: String = ""
@export var description: String = ""
@export var sprite: Texture2D

# Reference range for the card
@export var range: GridRange

# All card effects that will happen
func get_effects() -> Array[CardEffect]:
	return []
