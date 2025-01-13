extends RayCast2D
class_name MouseRaycast

signal interact(node: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func raycast_at_cursor():
	var space = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.collide_with_areas = true
	parameters.collision_mask = collision_mask
	parameters.position = get_global_mouse_position()
	var result = space.intersect_point(parameters)
	if !result.is_empty():
		var last_shape = result.reduce(func (max, vec): return vec if vec.collider.get_parent().z_index > max.collider.get_parent().z_index else max)
		var node = last_shape.collider.get_parent()
		interact.emit(node)
