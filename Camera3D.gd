extends Camera3D
@onready var shell_object: Node3D = $"../ShellObject";

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_rel: Vector2 = event.relative
		shell_object.rotate_y(mouse_rel.x / 10);
		shell_object.rotate_z(mouse_rel.y / 10);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
