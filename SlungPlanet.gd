extends RigidBody2D

enum {UNPRESSED, PRESSED, SHOT, PROJECTING}

var state = UNPRESSED  # whether the planet has been preseed - default undefined

@onready var centre_position = $"../Sling/Centre".global_position
@onready var sling = $"../Sling"
@onready var arrow = $"Arrow/Sprite"
@onready var root = $".."
@onready var launchpad_position = $"../..".global_position
@onready var boundary = Rect2(launchpad_position.x - 100, launchpad_position.y - 100, 200.0, 200.0)

var force = 10;
var projected_velocity = Vector2.ZERO
var projected_position = Vector2.ZERO
var colour = null
var colours = ["red", "yellow", "blue"]

# Called when the node enters the scene tree for the first time.
func _ready():
	# FIXME
	set_colour(colours[randi() % len(colours)])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if state != PRESSED && !boundary.has_point(global_position):
		# Retain the velocity and the global position before
		# resetting the slung planet
		projected_velocity = linear_velocity
		projected_position = global_position

		# Disable and freeze so we don't move or interact
		set_deferred("disable_mode", true)
		set_deferred("freeze", true)

		# Set the global position back to our initial postiion
		set_global_position(root.global_position)
		# Stop all velocity
		linear_velocity = Vector2.ZERO

		# Move the projecting state so we handle the spawning
		# of a new planet in the next frame.
		state = PROJECTING

	if state == PROJECTING:
		# Load up the new planet
		var planet = load("res://body.tscn").instantiate()
		# Set the retained position and veolocity
		planet.set_global_position(projected_position)
		planet.linear_velocity = projected_velocity
		# Set the colour of the new planet
		# planet.get_node("Sprite").set_texture(get_texture_for_colour(colour))
		planet.set_meta("is_slung", true)
		planet.set_meta("colour", colour)

		# FIXME
		set_colour(colours[randi() % len(colours)])
		set_meta("colour", colour)

		# Add it to the stage
		var stage = $"../../.."
		stage.add_child(planet)

		# We can now interact
		set_deferred("disable_mode", false)
		set_deferred("freeze", false)
		state = UNPRESSED


func _input(event):
	if state == PRESSED:
		var position = event.position
		if !boundary.has_point(position):
			position = Vector2(
				min(max(boundary.position.x, position.x), boundary.end.x),
				min(max(boundary.position.y, position.y), boundary.end.y),
			)
		set_global_position(position)
		on_drag()

		if event is InputEventMouseButton && !event.is_pressed():
			state = UNPRESSED
			shoot()


func on_drag():
	arrow.visible = true
	var distance = centre_position - global_position
	var scale = distance.length() / 100
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
	state = SHOT


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		state = PRESSED


func get_texture_for_colour(c) -> Resource:
	return load("res://sprites/planet_{colour}1.png".format({"colour": c}))

func set_colour(c):
	$"Sprite".set_texture(get_texture_for_colour(c))
	self.colour = c
