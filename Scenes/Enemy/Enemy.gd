extends KinematicBody


var path = []
var path_node = 0

var speed = 4

onready var player = get_parent().get_parent().get_node("Player")
onready var nav = get_parent()
onready var pos = get_tree().get_nodes_in_group("move")

var navgroup = ""

func _ready():
	for group in get_groups():
		if "nav" in group:
			navgroup = group
	
	pos.shuffle()
	$RayCast/AnimationPlayer.play("ray_move")
	pass

func _physics_process(delta):
	if path_node < path.size():
		
		var p;
		if(path.size()>path_node+2):
			p=transform.looking_at(path[path_node+2],Vector3.UP)
		else:
			p=transform.looking_at(path[path_node],Vector3.UP)
			
		var q = Quat(global_transform.basis.orthonormalized())
		q.normalized()
			
		global_rotation.y = q.slerp(Quat(p.basis.orthonormalized()).normalized(),10*delta).get_euler().y

		var direction = (path[path_node] - global_transform.origin)
	
		if direction.length() < 1:
			path_node += 1
		else:
			#look_at(path[path_node], Vector3.UP)
			

			
			
			move_and_slide(direction.normalized() * speed, Vector3.UP)
			
	$LookAt.look_at(player.get_node("Target").global_translation, Vector3.UP)
#	if($LookAt.rotation.y<0):
#		$LookAt.rotation == 0
	
	if $LookAt.is_colliding() == true:
		if $LookAt.get_collider().is_in_group("player"):
			#var distance = global_transform.origin.distance_to(player.global_transform.origin) 
			#if distance < 5:
				#print((5.0 / distance) / (10.0 / 3))
				#player.get_node("UI/DetectionBar").value = ((5.0 / distance) / (10.0 / 3)) * 100
			if($DetectionTimer.is_stopped()):
				$DetectionTimer.start()
	if $RayCast.is_colliding() == true:
		if $RayCast.get_collider().is_in_group("player"):
			$RayCast/AnimationPlayer.stop()
			#print("z")
			$LookAt.enabled = true
			

			speed = 9
			$AngerTimer.start()
			
		else:$RayCast/AnimationPlayer.play("ray_move")
	player.get_node("UI/DetectionBar").value -= 0.1
	
	
func move_to(target_pos):
	path = NavigationServer.map_get_path(nav, global_transform.origin, target_pos, false, 1)
	path_node = 0
func _on_DetectionTimer_timeout():
	player.get_node("UI/DetectionBar").value += 5
	pass

func _on_MoveTimer_timeout():
	#move_to(player.global_transform.origin)
	if($AngerTimer.is_stopped()==true):
		if pos != null:
			if navgroup != "":
				var check = false
				while check == false:
					if pos[0].is_in_group(navgroup):
						move_to(pos[0].global_transform.origin)
						if path.size() <= 4:
							if $IdleTimer.is_stopped() == true:
								$IdleTimer.start()
						check = true
					else:
						pos.shuffle()
			else:
				move_to(pos[0].global_transform.origin)
				if path.size() <= 4:
					if $IdleTimer.is_stopped() == true:
						$IdleTimer.start()
	else:
		move_to(player.global_transform.origin)

func _on_Timer2_timeout():
	
	pos.shuffle()

func _on_Area_body_entered(body):
	if(body.name == "Player"):
		print("death")
func _on_AngerTimer_timeout():
	speed = 4
	$LookAt.enabled = false
