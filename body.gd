extends RigidBody2D

var boom = preload("res://boom_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_body_entered(body):
	var boom_instance = boom.instantiate()
	add_child(boom_instance)
