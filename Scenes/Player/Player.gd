extends KinematicBody


onready var camera = $Head/Camera

var velocity = Vector3()

var gravity = -30
var max_speed = 8
var dead=false
var mouse_sensitivity = 0.006
func die():
	if(!dead):
		dead=true
		$UI/DetectionBar.visible = false
		$UI/List.visible = false
		$UI/Death.visible = true
		AudioServer.set_bus_send(3, "LowPitch")
		$UI/Death/FadeTimer.start()
		var tw = get_node("UI/Death/FadeTween")
		tw.interpolate_property($UI/Death/Fade, "modulate", Color(1, 0, 0, 0), Color(0, 0, 0, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tw.start()
	
func _ready():
	AudioServer.set_bus_send(3, "Master")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("move_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("crawl"):
		
		#$CollisionShape.shape.height = 0.001
		max_speed = 2
		var tween = get_node("CrawlTween")
		tween.interpolate_property($CollisionShape, "shape:height",
				$CollisionShape.shape.height, 0.4, 0.2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()


		#$CollisionS
		
		#$CollisionShape.translation.y = 0.3
		var camtween = get_node("CameraTween")
		camtween.interpolate_property($Head, "translation:y",
				$Head.translation.y, 1, 0.2,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		camtween.start()
	else:
		if(!$HeadCheck.is_colliding()):
			max_speed = 8
			var tween = get_node("CrawlTween")
			tween.interpolate_property($CollisionShape, "shape:height",
					$CollisionShape.shape.height, 2, 0.2,
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			var camtween = get_node("CameraTween")
			camtween.interpolate_property($Head, "translation:y",
					$Head.translation.y, 2.516, 0.2,
					Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			camtween.start()
		
	if Input.is_action_pressed("move_right"):
		input_dir += global_transform.basis.x
	if Input.is_action_just_pressed("esc"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	input_dir = input_dir.normalized()
	return input_dir
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Head.rotate_x(-event.relative.y * mouse_sensitivity)
		$Head.rotation.x = clamp($Head.rotation.x, -1.2, 1.2)
		
func _physics_process(delta):
	if($UI/DetectionBar).value>99:
		
		die()

	velocity.y += gravity * delta
	if(translation.y<-50):
		die()
	if(!dead):
		var desired_velocity = get_input() * max_speed

		velocity.x = desired_velocity.x
		velocity.z = desired_velocity.z
		velocity = move_and_slide(velocity, Vector3.UP, true)


func _on_FadeTimer_timeout():
	get_tree().reload_current_scene()
	pass # Replace with function body.
