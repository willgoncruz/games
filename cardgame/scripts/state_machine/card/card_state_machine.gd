extends Node
class_name CardStateMachine

@export var initial_state: CardState

var current_state: CardState
var states := {}

func init(card: CardScene) -> void:
	for child in get_children():
		if child is CardState:
			states[child.state] = child
			child.transition.connect(_on_transition)
			child.card = card

	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _on_transition(from: CardState, to: CardState.State):
	if from != current_state:
		return

	var new_state = states[to]
	if not new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state

func on_input(_event: InputEvent):
	if current_state:
		current_state.on_input(_event)

func on_gui_input(_event: InputEvent):
	if current_state:
		current_state.on_gui_input(_event)

func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()
	
func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()
