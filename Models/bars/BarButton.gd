extends Area


var pressed = false

export var bar: NodePath

func _on_BarButton_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.name=="Player"):
		if(!pressed):
			#0.1 -> 0.01
			var pressTween = $PressTween
			pressTween.interpolate_property($button, "translation:y", 0.1, 0.01, 0.5)
			pressTween.start()
			#$button.translation.y -= 5
			var node = get_node(bar)
			print(node)
			#0.8->5
			var barTween = $BarTween
			barTween.interpolate_property(node, "translation:y", node.translation.y, node.translation.y+4.2, 1)
			barTween.start()
			#node.translation.y += 100
			#get_as_property_path().translation.y += 2
