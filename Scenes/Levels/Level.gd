extends Spatial

onready var level = get_tree().current_scene.name.right(6)

var steals = []

func _ready():
	
	for steal in get_node("Steals").get_children():
		steals.append(steal.name)
	updateList()

func updateList():
	AudioServer.set_bus_send(3, "HighPitch")
	get_node("Player/UI/List").text = ""
	for steal in steals:
		get_node("Player/UI/List").text += steal + "\n"
	if(steals.size()==0):
		get_node("Player/UI/List").text = "ESCAPE"
		get_node("Player/UI/List").modulate = Color.darkred
		

	
