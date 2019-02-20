extends Spatial



var sun_pitch = 0.0
var sun_yaw = 0.0
var sun_radius = 70.0

var sun_cpitch = sun_pitch
var sun_cyaw = sun_yaw
var sun_cradius = sun_radius

var sun_view_sensitivity = 0.3

var sun_pitch_minmax = Vector2(90, -90)



export var is_enabled = true

export(NodePath) var sun = "Sun"
export(NodePath) var pivot = "."

func _ready():
	sun = get_node(sun)
	pivot = get_node(pivot)
	
	

func _input(ie):
	if !is_enabled:
		return
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and ie is InputEventMouseMotion or ie is InputEventScreenDrag :
		sun_pitch = max(min(sun_pitch+(ie.relative.y*sun_view_sensitivity),sun_pitch_minmax.x),sun_pitch_minmax.y)
		sun_yaw = sun_yaw-(ie.relative.x*sun_view_sensitivity)
	

func _process(delta):
	if !is_enabled:
		return
	
	sun_cpitch = lerp(sun_cpitch, sun_pitch, 10*delta)
	sun_cyaw = lerp(sun_cyaw, sun_yaw, 10*delta)
	

	
	
	sun_update()

func sun_update():
	
	var sun_pos = pivot.get_global_transform().origin
	
	
	sun_pos.x += sun_cradius * sin(deg2rad(sun_cyaw)) * cos(deg2rad(sun_cpitch))
	
	sun_pos.y = sun_cradius * sin(deg2rad(sun_cpitch))	
	
	sun_pos.z += sun_cradius * cos(deg2rad(sun_cyaw)) * cos(deg2rad(sun_cpitch))
	
	sun.look_at_from_position(sun_pos, pivot.get_global_transform().origin, Vector3(0,1,0))