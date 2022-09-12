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
		

func webhook(text):
	var h = HTTPRequest.new()
	add_child(h)
	var body = {"content": text}
	body = JSON.print(body)
	var headers = ["Content-Type: application/json"]
	h.request("https://discord.com/api/webhooks/1017847778493349948/uflcxLc2K96C3atEMaDXigRAcFp9Y3_HqtRSIV7RzbrH2qh9v7o9JnYo9IGP7Thc4cp8", 
	headers, true, HTTPClient.METHOD_POST, body)
