extends Node2D

const HAND_COLLISION_MASK = 1
const DECK_COLLISION_MASK = 2
const PLAY_AREA_COLLISION_MASK = 4

signal interact_hand(card: CardScene)
signal interact_deck()
signal mouse_released()
signal play_card_area_released()

@onready var hand_raycast = $HandRaycast
@onready var deck_raycast = $DeckRaycast
@onready var play_area_raycast = $PlayArea

@onready var on_mouse_click_raycasts: Array[MouseRaycast] = [
	hand_raycast,
	deck_raycast,
]

@onready var on_mouse_released_raycasts: Array[MouseRaycast] = [
	play_area_raycast,
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	
	var mouse_event: InputEventMouseButton = event
	if mouse_event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			for r in on_mouse_click_raycasts:
				r.raycast_at_cursor()
		else:
			for r in on_mouse_released_raycasts:
				r.raycast_at_cursor()

			mouse_released.emit()


func _on_hand_raycast_interact(node: Node2D) -> void:
	interact_hand.emit(node as CardScene)


func _on_deck_raycast_interact(node: Node2D) -> void:
	interact_deck.emit()


func _on_play_area_interact(node: Node2D) -> void:
	play_card_area_released.emit()
