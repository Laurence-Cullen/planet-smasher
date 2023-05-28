extends RigidBody2D


var boom = preload("res://boom_1.tscn")

var is_slung
var colour


# Called when the node enters the scene tree for the first time.
func _ready():
	is_slung = get_meta("is_slung", null)
	colour = get_meta("colour")
	set_colour(colour)

func get_texture_for_colour(c) -> Resource:
	return load("res://sprites/planet_{colour}1.png".format({"colour": c}))

func set_colour(c):
	$"Sprite".set_texture(get_texture_for_colour(c))
	self.colour = c

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func delete_faster_planet(planet1, planet2):
	if planet1.linear_velocity.length() > planet2.linear_velocity.length():
		planet1.queue_free()
	else:
		planet2.queue_free()
	
func animate_explosion(body):
	var boom_instance = boom.instantiate()
	get_parent().add_child(boom_instance)
	boom_instance.position = body.position

func _on_body_entered(body):
	var other_body = get_colliding_bodies()[0]

	animate_explosion(body)
		# If we hit a star delete ourselves	
	if other_body.name == 'Star':
		queue_free()
		return
		
	# If neither planet is slung delete the slower one
	if not is_slung and not other_body.get_meta('is_slung'):
		delete_faster_planet(body, other_body)
	
	# If both planets are slung delete the slower one
	if is_slung and other_body.get_meta('is_slung'):
		delete_faster_planet(body, other_body)
	
	# If the other planet is slung delete it
	elif other_body.get_meta('is_slung'):
		other_body.queue_free()
