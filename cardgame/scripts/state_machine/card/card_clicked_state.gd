extends CardState

func enter():
	card.sprite.modulate = Color(0, 1, 1)
	card.state.text = "CLICKED"
	card.drop_detector.monitoring = true

func on_input(event: InputEvent):
	if event is InputEventMouseMotion:
		transition.emit(self, CardState.State.DRAGGING)
