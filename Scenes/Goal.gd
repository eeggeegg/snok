extends Area

onready var thelabel = get_parent().get_node("Player/UI/TheLabel")
onready var player = get_parent().get_node("Player")
func _on_goal(body_rid, body, body_shape_index, local_shape_index):
	if(body.name=="Player"):
		if(get_parent().steals.size()>0):
			var stealz = ""
			for steal in get_parent().steals:
				stealz += ", " + steal
			stealz = stealz.right(2)
			
			thelabel.visible = true
			thelabel.text = ("You still need to steal\n"+str(stealz))
		else:
			player.die()
			#get_tree().reload_current_scene()


func _on_Goal_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if(body.name=="Player"):
		thelabel.visible = false
