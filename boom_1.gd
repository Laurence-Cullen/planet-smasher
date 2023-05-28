extends AnimatedSprite2D

var age
var max_age = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	age = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	age += delta
	if age > max_age:
		queue_free()
