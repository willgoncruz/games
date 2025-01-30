extends Resource
class_name UnitStats

signal stats_changed(unit: UnitStats)

@export var name: String
@export var max_block: int
@export var max_health: int

@export var initial_block: int
