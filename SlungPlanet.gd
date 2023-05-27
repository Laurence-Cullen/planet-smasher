extends RigidBody2D

enum {UNPRESSED, PRESSED}

var state = UNPRESSED  # whether the planet has been preseed - default undefined
var boundary = 100;

@onready var centre_position = $"../Sling/Centre".global_position
@onready var sling = $"../Sling"

var force = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == UNPRESSED:
		var distance_to_centre = global_position - centre_position


func _input(event):
	if state == PRESSED:
		set_global_position(event.position)
		var distance_to_centre = global_position - centre_position
		if distance_to_centre.length() > boundary:
			set_global_position(distance_to_centre.normalized() * boundary + centre_position)

		on_drag()

	if event is InputEventMouseButton && !event.is_pressed():
		state = UNPRESSED
		shoot()


func on_drag():
	sling.set_line_point(global_position)


func shoot():
	sling.reset_line_to_origin()
	var distance = centre_position - global_position
	var impulse = distance.normalized() * distance.length() * force

	apply_impulse(distance, impulse)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		state = PRESSED
