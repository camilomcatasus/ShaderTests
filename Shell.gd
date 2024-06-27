extends Node3D
@export var shell_mesh: Mesh;
@export var shell_shader: Shader;
@export var shell_count: int = 16;
@export var shell_length: float = 0.15;
@export var shell_distance_attenuation: float = 1.0;
@export var density: float = 100.0;
@export var noise_min: float = 0.0;
@export var noise_max: float = 1.0;
@export var thickness: float = 1.0;
@export var curvature: float = 1.0;
@export var displacement_strength: float = 0.1;
@export var shell_color: Color;
@export var occlusion_attenuation = 1.0;
@export var occlusions_bias = 0.0;
@export var light_direction = Vector3(1,  1, 0).normalized();

var shell_material: ShaderMaterial = ShaderMaterial.new();
var shells: Array;
@onready var displacement_direction: Vector3 = Vector3(0, 0, 0);
# Called when the node enters the scene tree for the first time.
func _ready():
	shell_material.shader = shell_shader;
	for shell_index in range(0, shell_count):
		var mesh_instance = MeshInstance3D.new()
		mesh_instance.mesh = shell_mesh;
		mesh_instance.material_override = shell_material;
		self.add_child(mesh_instance);
		mesh_instance.set_instance_shader_parameter("shell_index", shell_index);
		mesh_instance.set_instance_shader_parameter("shell_count", shell_count);
		mesh_instance.set_instance_shader_parameter("shell_length", shell_length);
		mesh_instance.set_instance_shader_parameter("shell_distance_attenuation", shell_distance_attenuation);
		mesh_instance.set_instance_shader_parameter("density", density);
		mesh_instance.set_instance_shader_parameter("noise_min", noise_min);
		mesh_instance.set_instance_shader_parameter("noise_max",noise_max);
		mesh_instance.set_instance_shader_parameter("thickness",thickness);
		mesh_instance.set_instance_shader_parameter("curvature",curvature);
		mesh_instance.set_instance_shader_parameter("displacement_strength",displacement_strength);
		mesh_instance.set_instance_shader_parameter("shell_color",shell_color);
		mesh_instance.set_instance_shader_parameter("occlusion_attenuation", occlusion_attenuation );
		mesh_instance.set_instance_shader_parameter("occlusions_bias", occlusions_bias);
		mesh_instance.set_instance_shader_parameter("light_direction", light_direction);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
