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
			
			
			var butt = Button.new()
			butt.connect("pressed", self, "playLevel", [level[0]])
			butt.text = "Level "+level[0]
			
			
			$LevelList.add_child(butt)

func playLevel(basse):
	get_tree().change_scene("res://Scenes/Levels/level-"+basse+".tscn")
	Debug.get_node("dbgmsg").text = basse
