extends Control


func _ready():
	var dir = Directory.new()
	dir.open("res://Scenes/Levels")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		file_name = dir.get_next()
		if("-" in file_name.right(5)):
			var level = file_name.right(6).split(".")#right(6)
			
			var button = preload("res://Scenes/LevelButton.tscn").instance()
			button.level = level[0]
			
			
			$LevelGrid.add_child(button)

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
