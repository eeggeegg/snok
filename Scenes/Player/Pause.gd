extends Node

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		if get_parent().get_parent().dead == false and get_node("../Win").visible == false:
			match Input.mouse_mode:
				Input.MOUSE_MODE_CAPTURED:
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					self.visible = true
					get_tree().paused = true
				Input.MOUSE_MODE_VISIBLE:
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
					self.visible = false
					get_tree().paused = false


func _on_Resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.visible = false
	get_tree().paused = false


func _on_Restart_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Exit_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.visible = false
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Levels.tscn")
