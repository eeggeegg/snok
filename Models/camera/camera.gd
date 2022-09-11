extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var turn_left = 30
export(int) var turn_right = -30

# Called when the node enters the scene tree for the first time.
func _ready():
	g(turn_left)
	$Timer.start()
	pass # Replace with function body.

func g(turn: int):
	$Tween.interpolate_property($cam, "rotation_degrees:y",
	$cam.rotation_degrees.y, turn, 4,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()



#func _process(delta):


func _on_Timer_timeout():
	g(turn_right)
	$Timer2.start()


func _on_Timer2_timeout():
	g(turn_left)
	$Timer.start()
