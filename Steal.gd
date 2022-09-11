extends Spatial


onready var leveltree = get_parent().get_parent().get_parent().get_parent()
onready var player = leveltree.get_node("Player")

onready var identifier = self.get_parent().get_parent().name

func _on_Area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.name=="Player"):
		leveltree.steals.erase(identifier)
		leveltree.updateList()
		
		get_parent().get_parent().queue_free()
