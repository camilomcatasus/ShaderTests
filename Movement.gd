extends Camera3D


@export var pivot_y: Node3D;
@export var pivot_z: Node3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#rotation_degrees = Vector3(0, 0, 0);
	pass # Replace with function body.

@export var sensitivity: float = 0.5;
@export var speed: float = 1.0;



func _input(event):
	if event is InputEventMouseMotion:
		#print(event)
		
		#print(Input.get_last_mouse_velocity())
		var horizontal_scalar = (deg_to_rad(event.relative.x) * sensitivity);
		#print(horizontal_scalar);
		pivot_y.rotation.y -= horizontal_scalar;
		pivot_z.rotation.x = clamp(pivot_z.rotation.x + (deg_to_rad(event.relative.y) * sensitivity), -PI/2, PI/2);
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
var last_position: Vector3 = position;
@export var place_distance: float = 400.0;
func _process(delta):
	
	var forward_movement = 0; 
	var hover_movement = 0;
	var strafe_movement = 0;
	if(Input.is_action_pressed("ui_right")):
		strafe_movement += 1;
	if(Input.is_action_pressed("ui_left")):
		strafe_movement -= 1;
	if(Input.is_action_pressed("ui_up")):
		forward_movement -= 1;
	if(Input.is_action_pressed("ui_down")):
		forward_movement += 1;
	if(Input.is_key_pressed(KEY_SPACE)):
		hover_movement += 1;
	if(Input.is_key_pressed(KEY_CTRL)):
		hover_movement -= 1;
	var aim: Basis = get_global_transform().basis;
	var temp_pos = pivot_y.position;
	
	temp_pos += forward_movement * aim.z * delta * speed;
	temp_pos += strafe_movement * aim.x * delta * speed;
	temp_pos.y += hover_movement * delta * speed;
	
	pivot_y.position = temp_pos;
		
			
	pass
