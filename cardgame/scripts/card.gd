class_name CardScene
extends Node2D

@export var stats: CardStats

@onready var costLabel = $Cost
@onready var nameLabel = $Name
@onready var sprite = $Image
@onready var animation = $AnimationPlayer

signal hover(card: CardScene)
signal blur(card: CardScene)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nameLabel.text = stats.name
	costLabel.text = str(stats.cost)
	
	sprite.texture = stats.sprite
	sprite.scale = Vector2(0.8, 0.765)
	
	animation.play("flip_card")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func highlight():
	self.z_index = get_parent().get_child_count() * 3
	self.sprite.modulate = Color(0, 0, 1)

func unhighlight():
	self.z_index = self.get_index() + 1
	self.sprite.modulate = Color(1, 1, 1)
	
func animate_to_position(position: Vector2):
	get_tree().create_tween().tween_property(self, "position", position, 0.1)
	
func _on_area_2d_mouse_entered() -> void:
	hover.emit(self)

func _on_area_2d_mouse_exited() -> void:
	blur.emit(self)
