extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	# Reload the current scene file
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
