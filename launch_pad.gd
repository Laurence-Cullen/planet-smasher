extends Node2D

enum {NO_SLING, HAZ_SLING}

var state = NO_SLING


# Called when the node enters the scene tree for the first time.
func _ready():
	add_sling()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func add_sling():
	var sling = load("res://sling.tscn").instantiate()
	sling.position = Vector2(-50, -50)
	# sling.get_child(1).boundary = Rect2(global_position.x, global_position.y, 200, 200)
	add_child(sling)


func _on_area_2d_input_event(viewport, event, shape_idx):
	pass
	# if event.is_pressed() && state == NO_SLING:
	#	state = HAZ_SLING
	#	sling_position = event.position - global_position
	#	sling = sling_scene.instantiate()
	#	sling.position = sling_position
	#	sling.get_child(1).boundary = Rect2(global_position.x, global_position.y, 200, 200)
	#	add_child(sling)


func _on_child_exiting_tree(node):
	pass
	# add_sling()
