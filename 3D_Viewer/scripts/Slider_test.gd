extends HSlider
onready var object = get_node("../../../Viewport/Camera")
onready var lamp = get_node("../../../Viewport/Camera/light_pivot/Sun")
onready var slider = get_node(".")
onready var label = get_node("../Label")


func _ready():
	lamp.light_energy = 0.3
	label.text = str(lamp.light_energy)
	pass

	



func _on_HSlider_mouse_entered():
	
	object.is_enabled = false
	pass # replace with function body
	
func _on_HSlider_mouse_exited():
	
	object.is_enabled = true
	pass # replace with function body





#warning-ignore:unused_argument
func _on_HSlider_value_changed(value):
	lamp.light_energy = slider.value
	label.text = str(slider.value)
	
	pass # replace with function body
