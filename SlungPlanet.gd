extends RigidBody2D

enum {UNPRESSED, PRESSED}

var state = UNPRESSED  # whether the planet has been preseed - default undefined
var boundary = 200;

@onready var centre_position = $"../Sling/Centre".global_position
@onready var sling = $"../Sling"
@onready var arrow = $"Arrow/Sprite"

var force = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
	arrow.visible = true
	var distance = centre_position - global_position
	var scale = distance.length() / 200
	arrow.scale.x = scale
	arrow.scale.y = scale
	arrow.rotation = -distance.angle_to(Vector2.RIGHT)
	# arrow.offset.x = -arrow.get_rect().width
	sling.set_line_point(global_position)


func shoot():
	arrow.visible = false
	sling.reset_line_to_origin()
	var distance = centre_position - global_position
	var impulse = distance.normalized() * distance.length() * force

	apply_impulse(distance, impulse)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		state = PRESSED
