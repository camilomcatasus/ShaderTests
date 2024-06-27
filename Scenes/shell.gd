extends MeshInstance3D

@export var density: float;
@export var shell_count: int;
@export var shell_distance: float;

@onready var last_density: float = density;
@onready var last_shell_count: int = shell_count;
@onready var last_shell_distance: float = shell_distance;

# Called when the node enters the scene tree for the first time.
var shell_list: Array = [];

func _ready():
	
	self.set_instance_shader_parameter("density", density);
	self.set_instance_shader_parameter("shell_index", 0);
	self.set_instance_shader_parameter("shell_count", float(shell_count));
	self.set_instance_shader_parameter("shell_distance", shell_distance)
	var parent_node: Node3D = get_parent();
	
	for current_shell_index in range(1, shell_count):
		var shell_mesh = MeshInstance3D.new();
		shell_mesh.mesh = self.mesh;
		parent_node.add_child.call_deferred(shell_mesh);
		shell_mesh.set_instance_shader_parameter("density", density);
		shell_mesh.set_instance_shader_parameter("shell_index", float(current_shell_index));
		shell_mesh.set_instance_shader_parameter("shell_count", float(shell_count));
		shell_mesh.set_instance_shader_parameter("shell_distance", shell_distance)
		
		
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if density != last_density || shell_count != last_shell_count || shell_distance != last_shell_distance:
		for shell in shell_list:
			shell.set_instance_shader_parameter("density", density);
			shell.set_instance_shader_parameter("shell_count", float(shell_count));
			shell.set_instance_shader_parameter("shell_distance", shell_distance)
			
			last_density = density;
			last_shell_count = shell_count;
			last_shell_distance = shell_distance;
	pass
