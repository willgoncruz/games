extends CardState

func enter():
	if not card.is_node_ready():
		await card.ready

	card.state.text = "BASE"
	card.sprite.modulate = Color(1, 1, 1)
	card.pivot_offset = Vector2.ZERO
	SignalBus.unhand_card.emit(card)

func on_gui_input(event: InputEvent):
	if event is not InputEventMouseButton:
		return
	
	var mouse_event: InputEventMouseButton = event
	if mouse_event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_viewport().set_input_as_handled()
			card.pivot_offset = card.get_global_mouse_position() - card.global_position
			transition.emit(self, CardState.State.CLICKED)
