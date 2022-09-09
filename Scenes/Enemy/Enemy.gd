extends KinematicBody


var path = []
var path_node = 0

var speed = 9

onready var player = get_parent().get_node("Player")
onready var nav = get_parent()

func _ready():
	pass

func _physics_process(delta):
	if path_node < path.size():
		
		var direction = (path[path_node] - global_transform.origin)
	
		if direction.length() < 1:
			path_node += 1
		else:
			look_at(path[path_node], Vector3.UP)
			move_and_slide(direction.normalized() * speed, Vector3.UP)

func move_to(target_pos):
	path = NavigationServer.map_get_path(nav, global_transform.origin, target_pos, false, 1)
	path_node = 0


func _on_Timer_timeout():
	move_to(player.global_transform.origin)



func _on_Area_body_entered(body):
	if(body.name == "Player"):
		print("death")
