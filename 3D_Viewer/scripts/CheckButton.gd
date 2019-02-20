extends CheckButton
onready var viewer = get_node("../../Viewport/Camera")
onready var lamp = get_node("../../Viewport/Camera/light_pivot")


func _ready():
	
	pass # Replace with function body.

func light_on():
	viewer.is_enabled = false
	lamp.is_enabled = true


func light_off():
	viewer.is_enabled = true
	lamp.is_enabled = false



func _on_CheckButton_toggled(button_pressed):
	if button_pressed :
		light_on()
	else :
		light_off()
	pass # Replace with function body.
