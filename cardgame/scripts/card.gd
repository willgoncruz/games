class_name CardScene
extends Node2D

@export var stats: CardStats

@onready var costLabel = $Cost
@onready var nameLabel = $Name
@onready var sprite = $Image

signal hover(card: CardScene)
signal blur(card: CardScene)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nameLabel.text = stats.name
	costLabel.text = str(stats.cost)
	
	sprite.texture = stats.sprite
	sprite.scale = Vector2(0.8, 0.765)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func highlight():
	self.sprite.modulate = Color(0, 0, 1)

func unhighlight():
	self.sprite.modulate = Color(1, 1, 1)
	
func _on_area_2d_mouse_entered() -> void:
	#self.sprite.modulate = Color(0, 0, 1)
	hover.emit(self)

func _on_area_2d_mouse_exited() -> void:
	#self.sprite.modulate = Color(1, 1, 1)
	blur.emit(self)
