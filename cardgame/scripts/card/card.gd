class_name CardScene
extends Control

@export var stats: CardStats

@onready var costLabel = $Cost
@onready var state: Label = $State
@onready var nameLabel = $Name
@onready var sprite = $Image
@onready var animation = $AnimationPlayer
@onready var card_state_machine: CardStateMachine = $CardStateMachine
@onready var drop_detector: Area2D = $DropDetector

@onready var targets: Array[Node] = []

signal hover(card: CardScene)
signal blur(card: CardScene)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nameLabel.text = stats.name
	costLabel.text = str(stats.cost)
	
	sprite.texture = stats.sprite
	sprite.scale = Vector2(0.8, 0.765)
	
	animation.play("flip_card")
	card_state_machine.init(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent):
	card_state_machine.on_input(event)

func highlight():
	self.z_index = get_parent().get_child_count() * 3
	self.sprite.modulate = Color(0, 0, 1)

func unhighlight():
	self.z_index = self.get_index() + 1
	self.sprite.modulate = Color(1, 1, 1)
	
func animate_to_position(position: Vector2):
	get_tree().create_tween().tween_property(self, "position", position, 0.1)

func play() -> void:
	SignalBus.play_card.emit(self)

func _on_drop_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	card_state_machine.on_input(event)
	card_state_machine.on_gui_input(event)


func _on_drop_detector_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()


func _on_drop_detector_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()


func _on_drop_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.push_back(area)

func _on_drop_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
