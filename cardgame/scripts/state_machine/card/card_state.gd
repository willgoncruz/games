extends Node
class_name CardState

enum State { BASE, CLICKED, DRAGGING, RELEASED }

signal transition(from: CardState, to: CardState.State)

@export var state: State

@export var card: CardScene

func enter() -> void:
	pass

func exit() -> void:
	pass

func on_input(_event: InputEvent):
	pass

func on_gui_input(_event: InputEvent):
	pass

func on_mouse_entered() -> void:
	pass
	
func on_mouse_exited() -> void:
	pass
