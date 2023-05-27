extends Node2D

@onready var left_line = $"Left/Point/Line"
@onready var right_line = $"Right/Point/Line"
@onready var centre_line = $"Centre/Line"

@onready var left_line_point = $"Left/Point".global_position
@onready var right_line_point = $"Right/Point".global_position
@onready var centre_position = $"Centre".global_position


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_line_to_origin()


func set_line_point(pos : Vector2):
	var point1 = pos - left_line_point
	var point2 = pos - right_line_point
	left_line.set_point_position(1 , point1)
	right_line.set_point_position(1 , point2)
	centre_line.set_point_position(0, pos - centre_position)


func reset_line_to_origin():
	set_line_point(centre_position)
