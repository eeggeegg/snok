extends Control

func _on_Continue_pressed():
	var nextLevel = int(get_tree().current_scene.name.replace("level-", "")) + 1
	if ResourceLoader.exists("res://Scenes/Levels/level-"+str(nextLevel)+".tscn"):
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().change_scene("res://Scenes/Levels/level-"+str(nextLevel)+".tscn")
	else:
		get_tree().paused = false
		get_tree().change_scene("res://Scenes/Levels.tscn")


func _on_Restart_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	self.visible = false
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Levels_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Levels.tscn")
