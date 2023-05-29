extends Node2D

enum {OUT, IN}

var state = OUT


func _on_area_2d_input_event(viewport, event, shape_idx):
	if state == IN and event is InputEventMouse and $"SlingNode/SlungPlanet".state == 0:
		$"SlingNode".set_global_position(event.position)


func _on_area_2d_mouse_entered():
	state = IN


func _on_area_2d_mouse_exited():
	state = OUT
