extends Node
class_name BoardPosition

var x: int = 0
var y: int = 0

func _new(x, y: int):
	self.x = x
	self.y = y

func equal(another: BoardPosition) -> bool:
	return self.x == another.x and self.y == another.y
