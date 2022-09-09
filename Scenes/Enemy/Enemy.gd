extends KinematicBody


var path = []
var path_node = 0

var speed = 9

onready var player = get_parent().get_node("Player")
onready var nav = get_parent()
onready var pos = get_tree().get_nodes_in_group("move")

func _ready():
	$RayCast/AnimationPlayer.play("ray_move")
	pass

func _physics_process(delta):
	if path_node < path.size():
		
		var direction = (path[path_node] - global_transform.origin)
	
		if direction.length() < 1:
			path_node += 1
		else:
			look_at(path[path_node], Vector3.UP)
			move_and_slide(direction.normalized() * speed, Vector3.UP)
	
	if $RayCast.is_colliding() == true:
		if $RayCast.get_collider().is_in_group("player"):
			$RayCast/AnimationPlayer.stop()
			print("z")
		else: $RayCast/AnimationPlayer.play("ray_move")

func move_to(target_pos):
	path = NavigationServer.map_get_path(nav, global_transform.origin, target_pos, false, 1)
	path_node = 0
	#print(path)


func _on_Timer_timeout():
	#move_to(player.global_transform.origin)
	if pos != null:
		move_to(pos[0].global_transform.origin)
		if path.size() <= 4:
			if $Timer2.is_stopped() == true:
				$Timer2.start()

func _on_Timer2_timeout():
	pos.shuffle()

func _on_Area_body_entered(body):
	if(body.name == "Player"):
		print("death")
