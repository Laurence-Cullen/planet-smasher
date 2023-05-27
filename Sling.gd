extends Node2D

@onready var back_line = $"Back/Point/Line"
@onready var front_line = $"Front/Point/Line"

@onready var back_line_point = $"Back/Point".global_position
@onready var front_line_point = $"Front/Point".global_position

@onready var centre_position = $"Centre".global_position


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_line_to_origin()


func set_line_point(pos : Vector2):
	var point1 = pos - back_line_point
	var point2 = pos - front_line_point
	back_line.set_point_position(1 , point1)
	front_line.set_point_position(1 , point2)


func reset_line_to_origin():
	set_line_point(centre_position)
