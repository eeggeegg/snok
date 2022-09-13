extends Button

export var level = 0

func _ready():
	text = str(level)

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Levels/level-"+str(level)+".tscn")
