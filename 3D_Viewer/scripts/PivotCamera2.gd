extends Spatial



var cam_pitch = 0.0
var cam_yaw = 0.0
var cam_radius = 70.0

var cam_cpitch = cam_pitch
var cam_cyaw = cam_yaw
var cam_cradius = cam_radius

var cam_view_sensitivity = 0.3

var cam_pitch_minmax = Vector2(90, -90)
var cam_initial_zoom = 4


export var is_enabled = true

export(NodePath) var cam = "pivot/Camera"
export(NodePath) var pivot = "pivot"

func _ready():
	cam = get_node(cam)
	pivot = get_node(pivot)
	
	var diff = cam.get_global_transform().origin - pivot.get_global_transform().origin
	cam.set_fov(diff.length()*cam_initial_zoom)
	cam_radius = cam.fov
	cam_cradius = cam_radius

	
	
	

	
	

func _input(ie):
	if !is_enabled:
		return
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and ie is InputEventMouseMotion or ie is InputEventScreenDrag :
		cam_pitch = max(min(cam_pitch+(ie.relative.y*cam_view_sensitivity),cam_pitch_minmax.x),cam_pitch_minmax.y)
		cam_yaw = cam_yaw-(ie.relative.x*cam_view_sensitivity)
	elif ie is InputEventMouseButton:
		if ie.pressed:
			if ie.button_index == BUTTON_WHEEL_UP:
				cam_radius = max(min(cam_radius-0.8,10.0),1.5)
			elif ie.button_index == BUTTON_WHEEL_DOWN:
				cam_radius = max(min(cam_radius+0.8,10.0),1.5)

func _process(delta):
	if !is_enabled:
		return
	
	cam_cpitch = lerp(cam_cpitch, cam_pitch, 10*delta)
	cam_cyaw = lerp(cam_cyaw, cam_yaw, 10*delta)
	cam_cradius = lerp(cam_cradius, cam_radius, 5*delta)

	
	
	cam_update()

func cam_update():
	
	var cam_pos = pivot.get_global_transform().origin
	
	
	cam_pos.x += cam_cradius * sin(deg2rad(cam_cyaw)) * cos(deg2rad(cam_cpitch))
	
	cam_pos.y = cam_cradius * sin(deg2rad(cam_cpitch))	
	
	cam_pos.z += cam_cradius * cos(deg2rad(cam_cyaw)) * cos(deg2rad(cam_cpitch))
	
	cam.look_at_from_position(cam_pos, pivot.get_global_transform().origin, Vector3(0,1,0))
