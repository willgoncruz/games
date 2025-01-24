extends CardState

func enter():
	card.sprite.modulate = Color(1, 1, 0)
	card.state.text = "DRAGGING"

func on_input(event: InputEvent):
	var mouse_motion := event is InputEventMouseMotion
	var mouse_click := event is InputEventMouseButton
	var cancel := mouse_click and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT
	
	var confirm := mouse_click and (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT
	
	if mouse_motion:
		card.global_position = card.get_global_mouse_position() - card.pivot_offset

	if cancel:
		transition.emit(self, CardState.State.BASE)
	elif confirm:
		get_viewport().set_input_as_handled()
		transition.emit(self, CardState.State.RELEASED)
