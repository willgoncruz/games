extends CardState

var played: bool

func enter() -> void:
	card.sprite.modulate = Color(0.5, 0.5, 0.5)
	card.state.text = "RELEASED"
	played = false

	if not card.targets.is_empty():
		played = true
		print("CARD PLAYED: ", card.targets)
		card.play()

func on_input(event: InputEvent) -> void:
	if played:
		return

	transition.emit(self, CardState.State.BASE)
