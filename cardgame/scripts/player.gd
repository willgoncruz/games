extends Unit
class_name Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.init()
	add_to_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
